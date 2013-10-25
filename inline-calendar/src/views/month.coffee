
class CalendarMonthView extends AbstractCalendarView

  template: monthTemplate
  templateMini: monthTemplateMini
  eventsForDayInMonthTemplate: eventsForDayInMonthTemplate

  events: {
    'click span.date a': '_view_day_event_handler'
    'mouseenter td[class*="day"]': '_mouseenter_hover_event_handler'
    'mouseleave td[class*="day"]': '_mouseleave_day_event_handler'
    'click .month-day-events ul li a': '_day_event_click_hanlder'
  }

  refresh: (now)->
    @parent.header.setTitle now.format(@parent.options.monthTitleFormat), true

    startDay = moment(now).startOf('month').startOf('week')
    endDate = moment(startDay).week(startDay.week() + 5).endOf 'week'
    data = {
      'startDay': moment(startDay),
      'endDate': moment(endDate),
      'now': now
    }

    if @parent.options.miniMode
      @$el.html @templateMini(data)
    else
      @$el.html @template(data)
      @loadEvents startDay, endDate

    now = null
    startDay = null
    endDate = null
    @

  renderEvents: ->
    return if @parent.options.miniMode
    events = @parent.collection.groupBy '_date'
    self = @
    $('table td[data-day]', @$el).each ->
      $el = $(@)
      day = moment($el.data('day')).format 'YYYY-MM-DD'
      dayEvents = events[day] || []
      return if ! dayEvents.length
      $el.append self.eventsForDayInMonthTemplate {events: dayEvents}

  _view_day_event_handler: (e)->
    e.preventDefault()
    date = $(e.target).closest('td').data('day')
    @notify 'dayclicked', date

  _mouseenter_hover_event_handler: (e)->
    $(e.target).addClass 'hover'

  _mouseleave_day_event_handler: (e)->
    $('td.hover', @$el).removeClass 'hover'

  _day_event_click_hanlder: (e)->
    e.preventDefault()

