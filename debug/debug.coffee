  ###
   Proposal:
    1 - do not use console.log - will not work in IE from start. Use only function log() - which will check if function console.log exists
    2 - global catching js errors for developing process + sending some technical information  about js error(browser type , platform) to email
        + showing custom error notification area for user .
   ###
  root = exports ? this
  root.debuging =
    enabled: true
    catch_errors: true
    mail_notifier: true
    mail_url_notifier: 'some_url_to_mail_notifier'
    show_notifier_area: true

  root.log = (argument...) ->
      if window.console and window.console.log and debuging.enabled
        argument.forEach (n) ->
          console.log n

  ###
  global catching js errors function.

    https://developer.mozilla.org/en/DOM/window.onerror
    http://msdn.microsoft.com/en-us/library/cc197053(v=vs.85).aspx
    http://dev.opera.com/articles/view/better-error-handling-with-window-onerror/
    http://www.w3.org/wiki/DOM/window.onerror
    http://www.quirksmode.org/dom/events/error.html
  ###
  if debuging.catch_errors and debuging.enabled
    root.window.onerror = (message, url, line) ->
      error = 'Message: '+ message + '<br/>Url: ' + url + '<br/> At line: ' + line +
              '<br/>CodeName: ' + navigator.appCodeName + '<br/>AppName: ' + navigator.appName +
              '<br/>Version: ' + navigator.appVersion + '<br/>Platform: ' + navigator.platform +
              '<br/>User-agent header sent: ' + navigator.userAgent +
              "<br/>Cookies enabled: " + navigator.cookieEnabled
      custom_error_notifier error
      # to prevent browser error handling -> return true
      return true

  custom_error_notifier = (message) ->
    if debuging.mail_notifier
      $.post(
        debuging.mail_url_notifier
        msg: message
      )
    if debuging.show_notifier_area
        notifier_area()

  notifier_area = () ->
    if $('#error_notifier').length > 0
      return
    # rewrite in future
    $('body').append('<div id="error_notifier" style="position:fixed;top:0px;background-color:#dfdfdf;">Ooops error occurred.<br/>
     The message was send to our team to fix it it shortest time</div>');
    setTimeout(
      () ->
        $('#error_notifier').remove()
      5000
    )
    return

