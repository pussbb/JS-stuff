
class CalendarMonthView extends AbstractCalendarView

  template: monthTemplate

  events: {
    'click .calendar-day .day a': '_view_day_event_handler'
  }

  _view_day_event_handler: (e)->
    e.preventDefault()
    @parent.changeViewTo CalendarView.VIEW_DAY, $(e.target).closest('td').data('day')

  refresh: (now)->
    @parent.header.setTitle now.format('MMMM YYYY'), true
    startDay = moment(now).startOf('month').startOf('week')
    endDate = moment(startDay).week(startDay.week() + 5).endOf 'week'
    @$el.html @template({'startDay': startDay, 'endDate': endDate, 'now': now})
