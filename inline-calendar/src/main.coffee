
CalendarException = (@message, @code = 10 ) ->
  @name = "CalendarException"
  @toString = ()=> return "[#{@code}] (#{@name}) - #{@message}"
  @


class Calendar extends Backbone.View

  @VIEW_DAY = 1
  @VIEW_WEEK = 2
  @VIEW_MONTH = 3

  template: calendarTemplate

  events: {
    'click .header .content button[class*="view-"]': '_change_view_event_handler'
    'click .header .prev button': '_previuos_event_handler'
    'click .header .next button': '_next_event_handler'
  }

  options: {
    viewType: Calendar.VIEW_WEEK
    dayView: null
    weekView: null
    monthView: null
    dayEventsCollectionBaseURL: null
    dayEventsCollection: null
  }

  initialize: (el, options)->
    @$el = el
    @moment =  moment().hours(12)

    if _.isObject options
      @options = _.extend @options, options

    if @options.dayEventsCollectionBaseURL
      CalendarDayEventsCollection.baseURL = @options.dayEventsCollectionBaseURL

    if _.isObject(@options.dayEventsCollection) and \
        @options.dayEventsCollection instanceof CalendarDayEventsCollection
      @collection = @options.dayEventsCollection
    else
      data = _.isArray @options.dayEventsCollection ? @options.dayEventsCollection | []
      @collection = @options.dayEventsCollection = new CalendarDayEventsCollection data

    if not @options.dayView
      @options.dayView = new CalendarDayView {}
    if not @options.weekView
      @options.weekView = new CalendarWeekView
    if not @options.monthView
      @options.monthView = new CalendarMonthView

    @render()

    @container = $('div.calendar-container', @$el)
    for i in ['dayView', 'weekView', 'monthView']
      @options[i].$el = @container

    @title = $('.header .content .title', @$el)

    @refresh()

  render: ()->
    @$el.html @template()
    @

  clear: ->
    @container.html ''
    @

  refresh: (date)->
    @clear()

    if date
      @moment = moment(date).hours(12)

    if not @moment.isValid()
      throw CalendarException "Invalid date", 69

    btnClassPrefix = null
    switch @options.viewType
      when Calendar.VIEW_DAY
        @_render_day()
        btnClassPrefix = "day"
      when Calendar.VIEW_WEEK
        @_render_week()
        btnClassPrefix = "week"
      when Calendar.VIEW_MONTH
        @_render_month()
        btnClassPrefix = "month"
      else throw CalendarException 'Not supported view type', 34

    $('.header .content button[class*="view-"]', @$el).removeClass 'btn-primary'
    $(".header .content button.view-#{btnClassPrefix}", @$el).addClass 'btn-primary'

    @

  changeViewTo: (type=Calendar.VIEW_MONTH)->
    if type not  in [Calendar.VIEW_DAY, Calendar.VIEW_WEEK, Calendar.VIEW_MONTH]
      throw CalendarException 'Not supported view type', 34
    @options.viewType = type
    @refresh()

  _change_view_event_handler: (e)->
    $btn = $(e.target)
    type = null
    if $btn.hasClass 'view-day'
      type = Calendar.VIEW_DAY
    if $btn.hasClass 'view-week'
      type = Calendar.VIEW_WEEK
    if $btn.hasClass 'view-month'
      type = Calendar.VIEW_MONTH
    @changeViewTo type

  _previuos_event_handler: ->
    switch @options.viewType
      when Calendar.VIEW_DAY then @moment.set('d', @moment.day()-1)
      when Calendar.VIEW_WEEK then @moment.set('d', @moment.day()-7)
      when Calendar.VIEW_MONTH then @moment.set('month', @moment.month()-1)
      else throw CalendarException 'Not supported view type', 34
    @refresh()

  _next_event_handler: ->
    switch @options.viewType
      when Calendar.VIEW_DAY then @moment.add 'd', 1
      when Calendar.VIEW_WEEK then @moment.add 'w', 1
      when Calendar.VIEW_MONTH then @moment.add 'm', 1
      else throw CalendarException 'Not supported view type', 34
    @refresh()

  _render_month: ->
    @title.html @moment.format('MMMM YYYY')
    @options.monthView.refresh @moment
    @

  _render_day: ->
    @title.html @moment.format('DD MMMM YYYY')
    @options.dayView.refresh @moment
    @

  _render_week: ->
    @title.html @moment.format('MMMM gggg')
    @options.weekView.refresh @moment
    @

  option: (name, value)->
    if not value
      return @options[name]

    switch name
      when 'viewType' then @changeViewTo value
      else @options[name] = value

$ ->

  $.fn.Calendar = (options)->
    args = Array.prototype.slice.call(arguments, 1)
    result = []
    $res = @each ()->
      $el = $(@)
      obj = $el.data 'Calendar'
      if ! obj
        obj = new Calendar $el, options
        $el.data 'Calendar', obj
        return
      return if jQuery.type(options) is not 'string'
      if not jQuery.isFunction obj[options]
        result_ = obj[options]
      else
        result_ = obj[options].apply obj, args
      result.push result_

    return $res if not result.length
    result = result[0] if result.length is 1
    result


  vv = $('div.calendar').Calendar {
      'viewType': Calendar.VIEW_WEEK
    }

#   console.log vv
#   vv.Calendar 'hello', 'Hi'
#   console.log vv.Calendar 'options'

