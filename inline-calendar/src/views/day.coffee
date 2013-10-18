
class CalendarDayView extends AbstractCalendarView
  template: dayTemplate

  refresh: (now)->
    now.hours(0)
    @parent.header.setTitle now.format('dddd DD MMMM YYYY')
    @$el.html @template({'now': now})
