(function() {

  $(function() {
    var defaults, options;
    $.fn.language_chooser = function(options) {};
    defaults = {
      success: null,
      extraData: null,
      changed: null,
      sendRequest: true,
      data: {}
    };
    options = $.extend(defaults, options);
    return $(this).change(function() {
      var form, tr_url;
      if (options.changed) options.changed();
      if (!options.sendRequest) return;
      options.data.language = null;
      form = $(this).closest('form');
      tr_url = url_base + $(this).data('tr_url');
      if (options.extraData) {
        options.data = $.extend(options.data, options.extraData());
      }
      if (!options.data.language) options.data.language = $(this).val();
      $('input,textarea,button', form).each(function() {
        return $(this).attr('disabled', 'disabled');
      });
      return $.ajax({
        url: tr_url,
        type: 'POST',
        dataType: 'json',
        data: options.data,
        success: function(data) {
          if (options.success) return options.success(data, form);
        },
        complete: function() {
          $('input,textarea,button', form).each(function() {});
          return $(this).removeAttr('disabled');
        }
      });
    });
  });

}).call(this);
