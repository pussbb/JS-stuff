
CalendarException = (message, code = 10 ) ->
  @message = message
  @code = code
  @name = "CalendarException"
  @toString = ()=> return "[#{@code}] (#{@name}) - #{@message}"
  @


class Calendar extends Backbone.View

  @VIEW_DAY = 1
  @VIEW_WEEK = 2
  @VIEW_MONTH = 3

  template: calendarTemplate

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
      @options.dayView = new CalendarDayView
    if not @options.weekView
      @options.weekView = new CalendarWeekView
    if not @options.monthView
      @options.monthView = new CalendarMonthView

    @render()
    @refresh()

  render: ()->
    @$el.html @template()
    #@$el.addClass 'table-responsive'
    @

  clear: ->
    $('tbody', @$el).html ''
    @

  refresh: (date)->
    @clear()
    switch @options.viewType
      when Calendar.VIEW_DAY then @_render_day date
      when Calendar.VIEW_WEEK then @_render_week date
      when Calendar.VIEW_MONTH then @_render_month date
      else throw CalendarException 'Not supported view type', 34
    @

  _render_month: (date)->
    now = moment(date).hours(12)
    startDay = moment(now).date(-1)
    endDate = moment(startDay).week(startDay.week() + 5).endOf 'week'
    i = 0
    $tbody = $('tbody', @$el)
    $('th.title', @$el).prop 'colspan', 4
    while startDay < endDate
      if i % 7 is 0
        tr = $('<tr>')
        $tbody.append tr
      tr.append "<td>#{startDay.format()}</td>"
      startDay.add('d', 1)
      i++
    @

  _render_day: ->
    @

  _render_week: ->
    @

  hello: (msg)->
      console.log msg

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
      'viewType': Calendar.VIEW_MONTH
      'daysCollectionBaseURL': 'ddsfds'
    }
  console.log vv
  vv.Calendar 'hello', 'Hi'
  console.log vv.Calendar 'options'

 # day.day( day.day() < this.settings.weekStart ? this.settings.weekStart-7 : this.settings.weekStart);
