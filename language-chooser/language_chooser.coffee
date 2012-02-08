$ ->

  $.fn.language_chooser = (options) ->

  defaults = {
    success: null, #callback function
    extraData: null, #function that returns object
    changed: null, #callback function select item changed
    sendRequest: true,
    data: {},
  }

  options = $.extend defaults, options

  $(this).change () ->
    options.changed() if options.changed
    return if ! options.sendRequest

    options.data.language = null
    form = $(this).closest('form')
    tr_url = url_base + $(this).data 'tr_url'
    if options.extraData
      options.data = $.extend options.data, options.extraData()
    options.data.language = $(this).val() if ! options.data.language

    $('input,textarea,button',form).each () ->
      $(this).attr 'disabled', 'disabled'

    $.ajax(
      url: tr_url,
      type: 'POST',
      dataType: 'json',
      data: options.data,
      success: (data)->
        options.success data, form if options.success
      complete: () ->
        $('input,textarea,button',form).each () ->
        $(this).removeAttr 'disabled'
    )
