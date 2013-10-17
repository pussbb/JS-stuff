

class CalendarDay extends Backbone.Model
  url: () -> "#{CalendarDaysCollection.baseURL}/#{@id}"


class CalendarDaysCollection extends Backbone.Collection
  model: CalendarDay
  @baseURL: null
  url: ()-> "#{CalendarDaysCollection.baseURL}"
