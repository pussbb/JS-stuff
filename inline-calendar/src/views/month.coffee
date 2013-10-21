
class CalendarMonthView extends AbstractCalendarView

  template: monthTemplate
  templateMini: monthTemplateMini

  events: {
    'click span.day a': '_view_day_event_handler'
  }

  _view_day_event_handler: (e)->
    e.preventDefault()
    date = $(e.target).closest('td').data('day')
    @notify 'dayclicked', date


  refresh: (now)->
    @parent.header.setTitle now.format(@parent.options.monthTitleFormat), true

    startDay = moment(now).startOf('month').startOf('week')
    endDate = moment(startDay).week(startDay.week() + 5).endOf 'week'
    data = {'startDay': startDay, 'endDate': endDate, 'now': now}

    if @parent.options.miniMode
      @$el.html @templateMini(data)
    else
      @$el.html @template(data)
    @
