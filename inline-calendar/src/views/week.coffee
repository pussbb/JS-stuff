
class CalendarWeekView extends Backbone.View

  template: weekTemplate

  refresh: (date)->
    now = moment(date).hours(12)
    startDay = moment(now).startOf 'week'
    endDate = moment(startDay).endOf 'week'
    @$el.html @template({'startDay': startDay, 'endDate': endDate})
