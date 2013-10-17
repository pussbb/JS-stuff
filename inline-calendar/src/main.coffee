
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
    "click .header .content a.view-month": '_render_month'
    "click .header .content a.view-week": '_render_week'
    "click .header .content a.view-day": '_render_day'
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

    @refresh()

  render: ()->
    @$el.html @template()
    #@$el.addClass 'table-responsive'
    @

  clear: ->
    @container.html ''
    @

  refresh: (date)->
    switch @options.viewType
      when Calendar.VIEW_DAY then @_render_day date
      when Calendar.VIEW_WEEK then @_render_week date
      when Calendar.VIEW_MONTH then @_render_month date
      else throw CalendarException 'Not supported view type', 34
    @

  _render_month: (date)->
    @clear()
    @options.viewType = Calendar.VIEW_MONTH
    @options.monthView.refresh date
    @

  _render_day: (date)->
    @clear()
    @options.viewType = Calendar.VIEW_DAY
    @options.dayView.refresh date
    @

  _render_week: (date)->
    @clear()
    @options.viewType = Calendar.VIEW_WEEK
    @options.weekView.refresh date
    @


  option: (name, value)->
    if not value
      return @options[name]
    @options[name] = value

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
  console.log vv
  vv.Calendar 'hello', 'Hi'
  console.log vv.Calendar 'options'

 # day.day( day.day() < this.settings.weekStart ? this.settings.weekStart-7 : this.settings.weekStart);
