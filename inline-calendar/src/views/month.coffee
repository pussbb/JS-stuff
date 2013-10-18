
class CalendarMonthView extends Backbone.View

  template: monthTemplate

  refresh: (now)->
    startDay = moment(now).startOf('month').startOf('week')
    endDate = moment(startDay).week(startDay.week() + 5).endOf 'week'
    @$el.html @template({'startDay': startDay, 'endDate': endDate})
