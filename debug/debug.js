
/*
   Proposal:
    1 - do not use console.log - will not work in IE from start. Use only function log() - which will check if function console.log exists
    2 - global catching js errors for developing process + sending some technical information  about js error(browser type , platform) to email
        + showing custom error notification area for user .
*/

(function() {
  var custom_error_notifier, notifier_area, root,
    __slice = Array.prototype.slice;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.debuging = {
    enabled: true,
    catch_errors: true,
    mail_notifier: true,
    mail_url_notifier: 'some_url_to_mail_notifier',
    show_notifier_area: true
  };

  root.log = function() {
    var argument;
    argument = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    if (window.console && window.console.log && debuging.enabled) {
      return argument.forEach(function(n) {
        return console.log(n);
      });
    }
  };

  /*
    global catching js errors function.
  
      https://developer.mozilla.org/en/DOM/window.onerror
      http://msdn.microsoft.com/en-us/library/cc197053(v=vs.85).aspx
      http://dev.opera.com/articles/view/better-error-handling-with-window-onerror/
      http://www.w3.org/wiki/DOM/window.onerror
      http://www.quirksmode.org/dom/events/error.html
  */

  if (debuging.catch_errors && debuging.enabled) {
    root.window.onerror = function(message, url, line) {
      var error;
      error = 'Message: ' + message + '<br/>Url: ' + url + '<br/> At line: ' + line + '<br/>CodeName: ' + navigator.appCodeName + '<br/>AppName: ' + navigator.appName + '<br/>Version: ' + navigator.appVersion + '<br/>Platform: ' + navigator.platform + '<br/>User-agent header sent: ' + navigator.userAgent + "<br/>Cookies enabled: " + navigator.cookieEnabled;
      custom_error_notifier(error);
      return true;
    };
  }

  custom_error_notifier = function(message) {
    if (debuging.mail_notifier) {
      $.post(debuging.mail_url_notifier, {
        msg: message
      });
    }
    if (debuging.show_notifier_area) return notifier_area();
  };

  notifier_area = function() {
    if ($('#error_notifier').length > 0) return;
    $('body').append('<div id="error_notifier" style="position:fixed;top:0px;background-color:#dfdfdf;">Ooops error occurred.<br/>\
     The message was send to our team to fix it it shortest time</div>');
    setTimeout(function() {
      return $('#error_notifier').remove();
    }, 5000);
  };

}).call(this);
