
class CalendarWeekView extends AbstractCalendarView

  template: weekTemplate

  events: {
    'click th.day': '_view_day_event_handler'
    'dblclick td': '_view_day_event_handler'
  }

  refresh: (now)->
    @parent.header.setTitle now.format(@parent.options.weekTitleFormat), true
    startDay = moment(now).startOf 'week'
    endDate = moment(startDay).endOf 'week'
    now.hours(0)
    data = {
      'startDay': startDay,
      'endDate': endDate,
      'now': now,
      'timeFormat': @parent.options.timeFormat
      'dayInWeekFormat': @parent.options.dayInWeekFormat
    }
    @$el.html @template(data)

  _view_day_event_handler: (e)->
    e.preventDefault()
    $el = $(e.target)
    if $el.is 'td'
      cellIndex = $el[0].cellIndex
      $el = $("th.day:eq(#{cellIndex-1})", @$el)

    date = $el.data('day')
    console.log moment(date)
    return if not date
    @notify 'dayclicked', date

