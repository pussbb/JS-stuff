
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
    'click .header .content button[class*="view-"]': '_change_view_event'
  }

  options: {
    viewType: Calendar.VIEW_WEEK
    dayView: null
    weekView: null
    monthView: null
    daysCollectionBaseURL: null
    dayEventsCollectionBaseURL: null
    days: []
    weekStart: 0
  }

  initialize: (el, options)->
    @$el = el
    if _.isObject options
      @options = _.extend @options, options

    if @options.daysCollectionBaseURL
      CalendarDaysCollection.baseURL = @options.daysCollectionBaseURL

    if @options.dayEventsCollectionBaseURL
      CalendarDayEventsCollection.baseURL = @options.dayEventsCollectionBaseURL

    @options.daysCollection = new CalendarDaysCollection @options.days

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
    btnClassPrefix = null
    switch @options.viewType
      when Calendar.VIEW_DAY
        @_render_day date
        btnClassPrefix = "day"
      when Calendar.VIEW_WEEK
        @_render_week date
        btnClassPrefix = "week"
      when Calendar.VIEW_MONTH
        @_render_month date
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

  _change_view_event: (e)->
    $btn = $(e.target)
    type = null
    if $btn.hasClass 'view-day'
      type = Calendar.VIEW_DAY
    if $btn.hasClass 'view-week'
      type = Calendar.VIEW_WEEK
    if $btn.hasClass 'view-month'
      type = Calendar.VIEW_MONTH
    @changeViewTo type

  _render_month: (date)->
    now = moment(date).hours(12)
    @title.html now.format('MMMM YYYY')
    @options.monthView.refresh now
    @

  _render_day: (date)->
    now = moment(date).hours(12)
    @title.html now.format('DD MMMM YYYY')
    @options.dayView.refresh now
    @

  _render_week: (date)->
    now = moment(date).hours(12)
    @title.html now.format('MMMM gggg')
    @options.weekView.refresh now
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
      'daysCollectionBaseURL': 'ddsfds'
    }
#   console.log vv
#   vv.Calendar 'hello', 'Hi'
#   console.log vv.Calendar 'options'

