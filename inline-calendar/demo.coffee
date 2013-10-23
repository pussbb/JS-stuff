miniCalendar = null
calendar = null
calendars = null

create_calendars = ()->
  miniCalendar = $('div.mini-calendar').Calendar {miniMode:true}
  calendar = $('div.calendar').Calendar()
  calendars = $('div.mini-calendar, div.calendar').Calendar()

$ ->
  create_calendars()

  actionsDemoForm = $('form[name="actions-demo"]')
  option_sel = "select[name=\"langs\"] option[value=\"#{calendar.Calendar('option', 'lang')}\"]"
  $(option_sel, actionsDemoForm).prop 'selected', 'selected'
  $('select[name="langs"]', actionsDemoForm).on 'change', (e)->
    e.preventDefault()
    calendars.Calendar 'option', 'lang', $(e.target).val()

  option_sel = "select[name=\"viewType\"] option[value=\"#{calendar.Calendar('option', 'viewType')}\"]"
  $(option_sel, actionsDemoForm).prop 'selected', 'selected'
  $('select[name="viewType"]', actionsDemoForm).on 'change', (e)->
    e.preventDefault()
    calendar.Calendar 'option', 'viewType', parseInt($(e.target).val(),10)

  miniCalendar.on 'dayclicked', (e, date)->
    calendar.Calendar 'changeViewTo', 1, date

  $('button#destroy', actionsDemoForm).on 'click', (e)->
    e.preventDefault()
    $el = $(e.target)
    if $el.hasClass 'create'
      create_calendars()
      $el.html 'Destroy'
      $el.removeClass 'create'
    else
      calendars.Calendar 'destroy'
      $el.html 'Create'
      $el.addClass 'create'
