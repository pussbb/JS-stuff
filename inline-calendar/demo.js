// Generated by CoffeeScript 1.6.3
(function() {
  var calendar, calendars, create_calendars, miniCalendar, url;

  miniCalendar = null;

  calendar = null;

  calendars = null;

  url = './calendar.php';

  create_calendars = function() {
    miniCalendar = $('div.mini-calendar').Calendar({
      miniMode: true,
      dayEventsCollectionBaseURL: url
    });
    calendar = $('div.calendar').Calendar({
      dayEventsCollectionBaseURL: url
    });
    return calendars = $('div.mini-calendar, div.calendar').Calendar();
  };

  $(function() {
    var actionsDemoForm, option_sel;
    create_calendars();
    actionsDemoForm = $('form[name="actions-demo"]');
    option_sel = "select[name=\"langs\"] option[value=\"" + (calendar.Calendar('option', 'lang')) + "\"]";
    $(option_sel, actionsDemoForm).prop('selected', 'selected');
    $('select[name="langs"]', actionsDemoForm).on('change', function(e) {
      e.preventDefault();
      return calendars.Calendar('option', 'lang', $(e.target).val());
    });
    option_sel = "select[name=\"viewType\"] option[value=\"" + (calendar.Calendar('option', 'viewType')) + "\"]";
    $(option_sel, actionsDemoForm).prop('selected', 'selected');
    $('select[name="viewType"]', actionsDemoForm).on('change', function(e) {
      e.preventDefault();
      return calendar.Calendar('option', 'viewType', parseInt($(e.target).val(), 10));
    });
    miniCalendar.on('dayclicked', function(e, date) {
      return calendar.Calendar('changeViewTo', 1, date);
    });
    return $('button#destroy', actionsDemoForm).on('click', function(e) {
      var $el;
      e.preventDefault();
      $el = $(e.target);
      if ($el.hasClass('create')) {
        create_calendars();
        $el.html('Destroy');
        return $el.removeClass('create');
      } else {
        calendars.Calendar('destroy');
        $el.html('Create');
        return $el.addClass('create');
      }
    });
  });

}).call(this);
