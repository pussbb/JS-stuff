

class CalendarHeaderView extends AbstractCalendarView

  template: calendarHeaderTemplate
  templateMini: calendarHeaderMiniTemplate
  changeMonthYearTemplate: changeMonthYear

  events: {
    'click .content button[class*="view-"]': '_change_view_event_handler'
    'click button.prev': '_previuos_event_handler'
    'click button.next': '_next_event_handler'
    'dblclick .content .changable': '_header_title_dblclick_event_handler'
    'submit form[name="change_month_year"]': '_change_month_year_event_handler'
  }

  render: ()->
    if @parent.options.miniMode
      @$el.html @templateMini()
    else
      @$el.html @template()
    @title = $('.content .title', @$el)
    @

  activateButton: (name)->
    @$('.content button[class*="view-"]', @$el).removeClass 'btn-primary'
    @$(".content button.view-#{name}", @$el).addClass 'btn-primary'

  setTitle: (title, changable=false)->
    @title.html title
    if changable and not @parent.options.miniMode
      @title.addClass 'changable'
    else
      @title.removeClass 'changable'

  _change_view_event_handler: (e)->
    $btn = $(e.target)
    for i in CalendarView.availableViews
      if $btn.hasClass "view-#{i}"
        @parent.changeViewTo i
        return

  _previuos_event_handler: ->
    switch @parent.options.viewType
      when CalendarView.VIEW_DAY then @parent.moment.subtract('days', 2)
      when CalendarView.VIEW_WEEK then @parent.moment.subtract('w', 1)
      when CalendarView.VIEW_MONTH then @parent.moment.subtract('M', 1)
      else throw CalendarException 'Not supported view type', 34
    @parent.refresh()

  _next_event_handler: ->
    switch @parent.options.viewType
      when CalendarView.VIEW_DAY then @parent.moment.startOf('day').add 'h', 12
      when CalendarView.VIEW_WEEK then @parent.moment.add 'w', 1
      when CalendarView.VIEW_MONTH then @parent.moment.add 'M', 1
      else throw CalendarException 'Not supported view type', 34
    @parent.refresh()

  _header_title_dblclick_event_handler: ->
    @title.html @changeMonthYearTemplate({'now': @parent.moment})

  _change_month_year_event_handler: (e)->
    e.preventDefault()
    $form = $(e.target)
    for i in ['month', 'year']
      @parent.moment.set(i, parseInt($("select[name='#{i}']", $form).val(),10))
    @parent.refresh()
