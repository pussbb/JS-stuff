###
  script ....
  based on twitter bootstrap progress bars styles
###
root = exports ? this

$ ->
  defaultOptions = {
    clearContent: true,
    active: true, # according twitter boostrap class active animate the stripes left to right.
    striped: true, # Similar to the solid colors, we have varied striped progress bars.
    type: null # progress-info, progress-success, progress-warning, progress-danger
    min: 0, # in persernts
    max: 100,
    step: 10,
    timeout: 1000, # miliseconds
  }

  $.fn.pseudoAjaxLoadingProgress = (options = {})->
    options = $.extend true, defaultOptions, options
    #clear content of element where we will show our progress bar
    $(this).html '' if options.clearContent
    progressContainer = $('<div></div>').addClass 'progress'
    progressBar = $('<div></div>').addClass('bar').css 'width', "#{options.min}%"

    progressContainer.addClass 'active' if options.active
    progressContainer.addClass 'progress-striped' if options.striped

    progressContainer.append progressBar
    $(this).append progressContainer
    #return
    currentVal = options.min
    interval = setInterval ()->
        clearInterval interval if ! progressBar.length
        currentVal = currentVal + options.step
        currentVal = options.min if currentVal > options.max
        progressBar.css 'width', "#{currentVal}%"
      ,
      options.timeout
