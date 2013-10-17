
class CalendarWeekView extends Backbone.View

  template: weekTemplate

  refresh: (now)->
    startDay = moment(now).startOf 'week'
    endDate = moment(startDay).endOf 'week'
    @$el.html @template({'startDay': startDay, 'endDate': endDate})
