
class CalendarDayView extends Backbone.View
  template: dayTemplate

  refresh: (now)->
    now.hours(0)
    @$el.html @template({'now': now})
