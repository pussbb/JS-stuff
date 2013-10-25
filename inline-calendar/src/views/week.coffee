
class CalendarWeekView extends AbstractCalendarView

  template: weekTemplate
  eventsForDayInWeekTemplate: eventsForDayInWeekTemplate

  events: {
    'click th.day': '_view_day_event_handler'
    'dblclick td': '_view_day_event_handler'
    'mouseenter tr.week .day': '_mouseenter_hover_event_handler'
    'mouseleave tr.week .day': '_mouseleave_day_event_handler'
  }

  refresh: (now)->
    @parent.header.setTitle now.format(@parent.options.weekTitleFormat), true
    startDay = moment(now).startOf 'week'
    endDate = moment(startDay).endOf 'week'
    now.startOf 'day'
    data = {
      'startDay': moment(startDay),
      'endDate': moment(endDate),
      'now': now,
      'timeFormat': @parent.options.timeFormat
      'dayInWeekFormat': @parent.options.dayInWeekFormat
    }
    @$el.html @template(data)
    @loadEvents startDay, endDate
    now = null
    startDay = null
    endDate = null
    @

  renderEvents: ->
    events = @parent.collection.groupBy '_date'
    self = @
    $('table th[data-day]', @$el).each ->
      $el = $(@)
      day = moment($el.data('day')).format 'YYYY-MM-DD'
      dayEvents = events[day] || []
      return if ! dayEvents.length
      $td = $("td.day:nth-child(#{$el.index()}):first", self.$el)
      $td.append self.eventsForDayInWeekTemplate {events: dayEvents}

  _view_day_event_handler: (e)->
    e.preventDefault()
    $el = $(e.target)
    if $el.is 'td'
      cellIndex = e.target.cellIndex
      $el = $("th.day:eq(#{cellIndex-1})", @$el)

    date = $el.data('day')
    return if not date
    @notify 'dayclicked', date

  _mouseenter_hover_event_handler: (e)->
    return if ! e.target.cellIndex
    cellIndex = e.target.cellIndex + 1
    selector = "th.day:nth-child(#{cellIndex}), td.day:nth-child(#{cellIndex})"
    $(selector, @$el).addClass 'hover'

  _mouseleave_day_event_handler: (e)->
    return if ! e.target.cellIndex
    $('.hover', @$el).removeClass 'hover'

