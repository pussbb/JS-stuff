
class CalendarDayEvent extends Backbone.Model
  url: () -> "#{CalendarDayEventsCollection.baseURL}/#{@id}"

  initialize: ->
    @set 'event_date', moment(@get('event_date'))
    @set '_date', @get('event_date').format('YYYY-MM-DD')

class CalendarDayEventsCollection extends Backbone.Collection
  model: CalendarDayEvent
  @baseURL: null
  xhr: null

  url: ()-> "#{CalendarDayEventsCollection.baseURL}"

  fetch: ->
    @xhr.abort() if @xhr
    @xhr = super
    @xhr.done ()=> @xhr = null
    return @xhr


