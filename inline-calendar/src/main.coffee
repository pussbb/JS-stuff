
class Calendar extends Backbone.View

  @VIEW_DAY = 1
  @VIEW_WEEK = 2
  @VIEW_MONTH = 3

  options: {
    viewType: Calendar.VIEW_WEEK
  }

  initialize: (el, options)->
    @$el = el
    if _.isObject options
      @options = _.extend @options, options


  hello: (msg)->
      console.log msg

  option: (name, value)->
    if not value
      return @options[name]
    @options[name] = value

$ ->

  $.fn.Calendar = (options)->
    args = Array.prototype.slice.call(arguments, 1)
    result = []
    @each ()->
      $this = $(this)
      result_ = $this.get()
      data = $this.data 'Calendar'
      if ! data
        data = new Calendar $this, options
        $this.data 'Calendar', data
      if _.isString options
        if not _.isFunction data[options]
          result_ = data[options]
        else
          result_ = data[options].apply data, args
      result.push result_

    result = result[0] if result.length is 1
    result


  vv = $('div.calendar').Calendar {'ss': 'ss'}
  console.log vv
  vv = $('div.calendar').Calendar 'option', 'viewType'
  console.log vv

  vv = $('div.calendar').Calendar 'options'
  console.log vv
