
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

  options: {
    viewType: Calendar.VIEW_WEEK
    dayView: null
    weekView: null
    monthView: null
    dayCollection: null
    days: []
  }

  initialize: (el, options)->
    @$el = el
    if _.isObject options
      @options = _.extend @options, options
    if not @options.dayCollection
      @options.dayCollection = new CalendarDaysCollection @options.days
    if not @options.dayView
      @options.dayView = new CalendarDayView
    if not @options.weekView
      @options.weekView = new CalendarWeekView
    if not @options.monthView
      @options.monthView = new CalendarMonthView
    @refresh()

  clear: ->
    @$el.html ''

  refresh: ->
    switch @options.viewType
      when Calendar.VIEW_DAY then @_render_day()
      when Calendar.VIEW_WEEK then @_render_week()
      when Calendar.VIEW_MONTH then @_render_month()
      else throw CalendarException 'Not supported view type', 34
    @

  _render_month: ->
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


  vv = $('div.calendar').Calendar {'viewType': 3454}
  console.log vv
  vv.Calendar 'hello', 'Hi'
  console.log vv.Calendar 'options'
