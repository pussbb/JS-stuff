
class CalendarDayView extends AbstractCalendarView
  template: dayTemplate

  refresh: (now)->
    now.startOf 'day'
    @parent.header.setTitle now.format(@parent.options.dayTitleFormat)
    @$el.html @template({'now': now, 'timeFormat': @parent.options.timeFormat})
    now = null
    @
