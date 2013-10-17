
class CalendarDayView extends Backbone.View
  template: monthTemplate

  refresh: (date)->
    now = moment(date).hours(12)
    startDay = moment(now).date(-1)
    endDate = moment(startDay).week(startDay.week() + 5).endOf 'week'
    @$el.html @template({'startDay': startDay, 'endDate': endDate})
