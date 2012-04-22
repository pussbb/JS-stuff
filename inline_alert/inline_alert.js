(function() {
  var defaultOptions;

  defaultOptions = {
    text: 'Oops some error occured',
    closable: true,
    append: false,
    type: 'alert-error'
  };

  $(function() {
    return $.fn.inlineAlert = function(options) {
      var alert, close;
      if (options == null) options = {};
      options = $.extend(defaultOptions, options);
      alert = $('<div></div>').addClass('alert');
      alert.addClass(options.type);
      if (options.closable) {
        close = $('<a></a>').addClass('close');
        close.attr('data-dismiss', 'alert');
        close.text('x');
        alert.append(close);
      }
      alert.append(options.text);
      if (options.append) {
        return $(this).append(alert);
      } else {
        return $(this).html(alert);
      }
    };
  });

}).call(this);
