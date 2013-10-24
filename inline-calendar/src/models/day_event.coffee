
class CalendarDayEvent extends Backbone.Model
  url: () -> "#{CalendarDayEventsCollection.baseURL}/#{@id}"

  initialize: ->
    @set 'event_date', moment(@get('event_date'))

class CalendarDayEventsCollection extends Backbone.Collection
  model: CalendarDayEvent
  @baseURL: null
  xhr: null

  url: ()-> "#{CalendarDayEventsCollection.baseURL}"

  fetch: ->
    @xhr.abort() if @xhr
    @xhr = super
    console.log @xhr
    @xhr.done ()=> @xhr = null
    return @xhr


