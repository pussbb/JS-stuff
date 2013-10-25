
class CalendarDayView extends AbstractCalendarView
  template: dayTemplate
  eventsForDayInDayTemplate: eventsForDayInDayTemplate

  refresh: (now)->
    now.startOf 'day'
    @parent.header.setTitle now.format(@parent.options.dayTitleFormat)

    @$el.html @template({'now': moment(now), 'timeFormat': @parent.options.timeFormat})
    @loadEvents now
    now = null
    @

  renderEvents: ->
    day = moment($('table:first', @$el).data('day')).format 'YYYY-MM-DD'
    dayEvents = @parent.collection.where {'_date': day}
    return if ! dayEvents.length
    $('table td[class!="time"]:first', @$el)
      .append @eventsForDayInDayTemplate({events:dayEvents})
