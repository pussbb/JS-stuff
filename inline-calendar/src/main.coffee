
CalendarException = (@message, @code = 10 ) ->
  @name = "CalendarException"
  @toString = ()=> return "[#{@code}] (#{@name}) - #{@message}"
  @

class AbstractCalendarView extends Backbone.View
  parent: null
  initialize: (@$el, @parent=@)-> @

class CalendarView extends Backbone.View

  @VIEW_DAY = 1
  @VIEW_WEEK = 2
  @VIEW_MONTH = 3

  @availableViews: [
    CalendarView.VIEW_DAY,
    CalendarView.VIEW_WEEK,
    CalendarView.VIEW_MONTH
  ]

  template: calendarTemplate

  options: {
    viewType: CalendarView.VIEW_WEEK
    dayView: null
    weekView: null
    monthView: null
    dayEventsCollectionBaseURL: null
    dayEventsCollection: null
  }

  initialize: (@$el, options)->
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

    @render()
    @container = $('div.calendar-container', @$el)
    views = {
      'dayView': CalendarDayView
      'weekView': CalendarWeekView
      'monthView': CalendarMonthView
    }
    for option, klass of views
      if not @options[option]
        @options[option] = new klass @container, @
      else
        @options[option].$el = @container
        @options[option].parent = @

    @refresh()

  render: ()->
    @$el.html @template()
    @header = new CalendarHeaderView $('.header', @$el), @
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

    switch @options.viewType
      when CalendarView.VIEW_DAY then @options.dayView.refresh @moment
      when CalendarView.VIEW_WEEK then @options.weekView.refresh @moment
      when CalendarView.VIEW_MONTH then @options.monthView.refresh @moment
      else throw CalendarException 'Not supported view type', 34
    @header.activateButton @options.viewType
    @

  changeViewTo: (type=CalendarView.VIEW_MONTH, date)->
    if type not in CalendarView.availableViews
      throw CalendarException 'Not supported view type', 34
    @options.viewType = type
    @refresh date

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
        obj = new CalendarView $el, options
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
      'viewType': CalendarView.VIEW_MONTH
    }


