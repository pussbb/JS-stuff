
class CalendarMonthView extends AbstractCalendarView

  template: monthTemplate
  templateMini: monthTemplateMini

  events: {
    'click span.date a': '_view_day_event_handler'
    'mouseenter td[class*="day"]': '_mouseenter_hover_event_handler'
    'mouseleave td[class*="day"]': '_mouseleave_day_event_handler'
  }

  refresh: (now)->
    @parent.header.setTitle now.format(@parent.options.monthTitleFormat), true

    @startDay = moment(now).startOf('month').startOf('week')
    @endDate = moment(@startDay).week(@startDay.week() + 5).endOf 'week'
    data = {
      'startDay': moment(@startDay),
      'endDate': moment(@endDate),
      'now': now
    }

    if @parent.options.miniMode
      @$el.html @templateMini(data)
    else
      @$el.html @template(data)

    @loadEvents @startDay, @endDate
    now = null
    startDay = null
    endDate = null
    @

  renderEvents: ->
    events = @parent.collection.groupBy '_date'

    while @startDay <= @endDate
      dayEvents = events[@startDay.format('YYYY-MM-DD')] || []
      @startDay.add 'd', 1
      if ! dayEvents.length
        continue

  _view_day_event_handler: (e)->
    e.preventDefault()
    date = $(e.target).closest('td').data('day')
    @notify 'dayclicked', date

  _mouseenter_hover_event_handler: (e)->
    $(e.target).addClass 'hover'

  _mouseleave_day_event_handler: (e)->
    $('td.hover', @$el).removeClass 'hover'
