
$ ->
  miniCalendar = $('div.mini-calendar').Calendar {miniMode:true}
  calendar = $('div.calendar').Calendar()
  calendars = $('div.mini-calendar, div.calendar').Calendar()

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
    #alert date
    calendar.Calendar 'changeViewTo', 1, date
