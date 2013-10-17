
class CalendarDayEvent extends Backbone.Model
  url: () -> "#{CalendarDayEventsCollection.baseURL}/#{@id}"

class CalendarDayEventsCollection extends Backbone.Collection
  model: CalendarDayEvent
  @baseURL: null
  url: ()-> "#{CalendarDayEventsCollection.baseURL}"
