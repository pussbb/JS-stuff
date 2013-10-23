
today = moment()

CalendarException = (@message, @code = 10 ) ->
  @name = "CalendarException"
  @toString = ()=> return "[#{@code}] (#{@name}) - #{@message}"
  @

class AbstractCalendarView extends Backbone.View
  parent: null
  initialize: (options)->
    @parent = options['parent'] || @

  notify: (event)->
    args = Array.prototype.slice.call(arguments, 1)
    #for internal handlers
    @parent.trigger event, args
    #global
    @parent.$el.trigger event, args
    @

class CalendarView extends Backbone.View

  @VIEW_DAY = 1
  @VIEW_WEEK = 2
  @VIEW_MONTH = 3

  @availableViews: [
    CalendarView.VIEW_DAY,
    CalendarView.VIEW_WEEK,
    CalendarView.VIEW_MONTH,
  ]

  template: calendarTemplate

  defaultOptions: ()->
    {
      viewType: CalendarView.VIEW_MONTH
      miniMode: false
      dayView: null
      weekView: null
      monthView: null
      dayEventsCollectionBaseURL: null
      dayEventsCollection: null
      lang: 'ru'
      monthTitleFormat: 'MMMM YYYY'
      weekTitleFormat: 'MMMM gggg'
      dayInWeekFormat: 'dd. DD MMMM'
      dayTitleFormat: 'dddd Do MMMM YYYY'
      timeFormat: 'hh' # 'hh a' with am/pm
    }

  initialize: (options)->
    @options = @defaultOptions()
    if _.isObject options
      @options = _.extend @options, options


    @moment = moment(today).lang(@options.lang).startOf 'day'
    if @options.dayEventsCollectionBaseURL
      CalendarDayEventsCollection.baseURL = @options.dayEventsCollectionBaseURL

    if _.isObject(@options.dayEventsCollection) and
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
        parent = @
        @options[option] = new klass {'el': @container, 'parent': parent}
      else
        @options[option].$el = @container
        @options[option].parent = @

    dayclicked = (date)=>
      if not @options.miniMode
        @changeViewTo CalendarView.VIEW_DAY, date[0]

    @bind 'dayclicked', dayclicked

    @refresh()

  render: ()->
    @$el.html @template()
    parent = @
    @header = new CalendarHeaderView {'el': $('.header', @$el), 'parent': parent}
    @header.render()
    @

  clear: ->
    @container.html ''
    @

  refresh: (date)->
    @clear()

    if date
      @moment = moment(date).lang(@options.lang).startOf 'day'
      if not @moment.isValid()
        return throw CalendarException "Invalid date", 69

    switch @options.viewType
      when CalendarView.VIEW_DAY then @options.dayView.refresh moment(@moment)
      when CalendarView.VIEW_WEEK then @options.weekView.refresh moment(@moment)
      when CalendarView.VIEW_MONTH then @options.monthView.refresh moment(@moment)
      else return throw CalendarException 'Not supported view type', 34
    @header.activateButton @options.viewType
    @

  changeViewTo: (type=CalendarView.VIEW_MONTH, date)->
    if type not in CalendarView.availableViews
      return throw CalendarException 'Not supported view type', 34

    if @options.miniMode and type isnt CalendarView.VIEW_MONTH
      return throw CalendarException 'You cann\'t set another view type except VIEW_MONTH', 35
    @options.viewType = type
    @refresh date
    date = null
    @

  option: (name, value)->
    if not value
      return @options[name]

    @options[name] = value
    switch name
      when 'viewType' then @changeViewTo value
      when 'lang'
        @moment.lang(value)
        @refresh()

  destroy: ->
    @undelegateEvents()
    @stopListening()
    @header.undelegateEvents()
    @header.stopListening()
    @header.remove()
    @header = null
    for i in ['dayView', 'weekView', 'monthView']
      @options[i].undelegateEvents()
      @options[i].stopListening()
      @options[i].remove()
      @options[i] = null
    @collection.stopListening()
    @collection.reset()
    @options.dayEventsCollection.stopListening()
    @options.dayEventsCollection.reset()
    @collection = null
    @options.dayEventsCollection = null
    @options = null
    @moment = null
    @$el.html ''
    @$el.data 'Calendar', null
    @$el = null


$ ->

  $.fn.Calendar = (options)->
    args = Array.prototype.slice.call(arguments, 1)
    result = []
    $res = @each ()->
      $el = $(@)
      obj = $el.data 'Calendar'
      if ! obj and _.isString options
        return throw CalendarException 'Firstly you must create object before trying to use it', 12
      if ! obj
        obj = new CalendarView _.extend({el: $el}, options)
        $el.data 'Calendar', obj
        return @
      return @ if jQuery.type(options) isnt 'string'
      if not jQuery.isFunction obj[options]
        result_ = obj[options]
      else
        result_ = obj[options].apply obj, args
      result.push result_
      obj = null
      $el = null

    return $res if not result.length
    result = result[0] if result.length is 1
    result



