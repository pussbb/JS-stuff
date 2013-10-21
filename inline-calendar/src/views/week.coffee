
class CalendarWeekView extends AbstractCalendarView

  template: weekTemplate

  refresh: (now)->
    @parent.header.setTitle now.format('MMMM gggg'), true
    startDay = moment(now).startOf 'week'
    endDate = moment(startDay).endOf 'week'
    @$el.html @template({'startDay': startDay, 'endDate': endDate, 'now': now})
