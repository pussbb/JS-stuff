// Generated by CoffeeScript 1.6.1
(function() {
  var Calendar, CalendarDay, CalendarDayEvent, CalendarDayEventsCollection, CalendarDayView, CalendarDaysCollection, CalendarException, CalendarMonthView, CalendarWeekView, calendarTemplate, monthTemplate, weekTemplate,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  calendarTemplate = _.template('\
  <div class="clalendar-js">\
    <div class="header">\
        <div class="prev">\
            <button type="button" class="btn btn-default">\
                <span class="glyphicon glyphicon-arrow-left"></span>\
            </button>\
        </div>\
        <div class="content">\
            Calendar\
\
            <div class="btn-group pull-right">\
              <button type="button" class="btn btn-danger">\
                  <span class="glyphicon glyphicon-cog"></span>\
              </button>\
              <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown">\
                <span class="caret"></span>\
              </button>\
              <ul class="dropdown-menu" role="menu">\
                <li>\
                    <a class="view-month" href="#">Month View</a>\
                </li>\
                <li>\
                    <a class="view-week" href="#">Week View</a>\
                </li>\
                <li>\
                    <a class="view-day" href="#">Day View</a>\
                </li>\
                <li class="divider"></li>\
                <li><a href="#">Comming soon</a></li>\
              </ul>\
            </div>\
\
        </div>\
        <div class="next pull-right">\
            <button type="button" class="btn btn-default">\
                <span class="glyphicon glyphicon-arrow-right"></span>\
            </button>\
        </div>\
    </div>\
    <div class="calendar-container">\
    </div>\
  </div>\
');

  monthTemplate = _.template('\
<table class="table table-bordered">\
  <thead>\
    <tr>\
        <% _.each(moment.weekdays(), function (name) {%>\
            <th>\
              <%= name %>\
            </th>\
        <% });%>\
    </tr>\
  </thead>\
  <tbody>\
  </tbody>\
  <tfoot>\
      <% i = 0; %>\
      <% while (startDay < endDate) { %>\
          <% if (i % 7 === 0) { %>\
              <tr>\
          <% } %>\
                  <td class="calendar-day">\
                      <%= startDay.format("DD-MM-YYYY") %>\
                  </td>\
          <% startDay.add("d", 1); %>\
          <% i++; %>\
          <% if (i % 7 === 0) { %>\
              </tr>\
          <% } %>\
      <% } %>\
\
  </tfoot>\
</table>\
');

  weekTemplate = _.template('\
<table class="table table-bordered">\
  <thead>\
    <tr>\
        <% startDay_ = moment(startDay); %>\
        <% while (startDay_ <= endDate) {%>\
            <th>\
              <%= startDay_.format("DD-MM-YYYY") %>\
              <% startDay_.add("d", 1); %>\
            </th>\
        <% }; %>\
    </tr>\
  </thead>\
  <tbody>\
      <tr class="week">\
        <% while (startDay <= endDate) { %>\
            <td class="day">\
              <%= startDay.format("DD-MM-YYYY") %>\
              <% startDay.add("d", 1); %>\
            </td>\
        <% }; %>\
      </tr>\
  </tbody>\
  <tfoot>\
\
  </tfoot>\
</table>\
');

  CalendarException = function(message, code) {
    var _this = this;
    this.message = message;
    this.code = code != null ? code : 10;
    this.name = "CalendarException";
    this.toString = function() {
      return "[" + _this.code + "] (" + _this.name + ") - " + _this.message;
    };
    return this;
  };

  Calendar = (function(_super) {

    __extends(Calendar, _super);

    function Calendar() {
      return Calendar.__super__.constructor.apply(this, arguments);
    }

    Calendar.VIEW_DAY = 1;

    Calendar.VIEW_WEEK = 2;

    Calendar.VIEW_MONTH = 3;

    Calendar.prototype.template = calendarTemplate;

    Calendar.prototype.events = {
      "click .header .content a.view-month": '_render_month',
      "click .header .content a.view-week": '_render_week',
      "click .header .content a.view-day": '_render_day'
    };

    Calendar.prototype.options = {
      viewType: Calendar.VIEW_WEEK,
      dayView: null,
      weekView: null,
      monthView: null,
      daysCollectionBaseURL: null,
      dayEventsCollectionBaseURL: null,
      days: [],
      weekStart: 0
    };

    Calendar.prototype.initialize = function(el, options) {
      var i, _i, _len, _ref;
      this.$el = el;
      if (_.isObject(options)) {
        this.options = _.extend(this.options, options);
      }
      if (this.options.daysCollectionBaseURL) {
        CalendarDaysCollection.baseURL = this.options.daysCollectionBaseURL;
      }
      if (this.options.dayEventsCollectionBaseURL) {
        CalendarDayEventsCollection.baseURL = this.options.dayEventsCollectionBaseURL;
      }
      this.options.daysCollection = new CalendarDaysCollection(this.options.days);
      if (!this.options.dayView) {
        this.options.dayView = new CalendarDayView({});
      }
      if (!this.options.weekView) {
        this.options.weekView = new CalendarWeekView;
      }
      if (!this.options.monthView) {
        this.options.monthView = new CalendarMonthView;
      }
      this.render();
      this.container = $('div.calendar-container', this.$el);
      _ref = ['dayView', 'weekView', 'monthView'];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        i = _ref[_i];
        this.options[i].$el = this.container;
      }
      return this.refresh();
    };

    Calendar.prototype.render = function() {
      this.$el.html(this.template());
      return this;
    };

    Calendar.prototype.clear = function() {
      this.container.html('');
      return this;
    };

    Calendar.prototype.refresh = function(date) {
      switch (this.options.viewType) {
        case Calendar.VIEW_DAY:
          this._render_day(date);
          break;
        case Calendar.VIEW_WEEK:
          this._render_week(date);
          break;
        case Calendar.VIEW_MONTH:
          this._render_month(date);
          break;
        default:
          throw CalendarException('Not supported view type', 34);
      }
      return this;
    };

    Calendar.prototype._render_month = function(date) {
      this.clear();
      this.options.viewType = Calendar.VIEW_MONTH;
      this.options.monthView.refresh(date);
      return this;
    };

    Calendar.prototype._render_day = function(date) {
      this.clear();
      this.options.viewType = Calendar.VIEW_DAY;
      this.options.dayView.refresh(date);
      return this;
    };

    Calendar.prototype._render_week = function(date) {
      this.clear();
      this.options.viewType = Calendar.VIEW_WEEK;
      this.options.weekView.refresh(date);
      return this;
    };

    Calendar.prototype.option = function(name, value) {
      if (!value) {
        return this.options[name];
      }
      return this.options[name] = value;
    };

    return Calendar;

  })(Backbone.View);

  $(function() {
    var vv;
    $.fn.Calendar = function(options) {
      var $res, args, result;
      args = Array.prototype.slice.call(arguments, 1);
      result = [];
      $res = this.each(function() {
        var $el, obj, result_;
        $el = $(this);
        obj = $el.data('Calendar');
        if (!obj) {
          obj = new Calendar($el, options);
          $el.data('Calendar', obj);
          return;
        }
        if (jQuery.type(options) === !'string') {
          return;
        }
        if (!jQuery.isFunction(obj[options])) {
          result_ = obj[options];
        } else {
          result_ = obj[options].apply(obj, args);
        }
        return result.push(result_);
      });
      if (!result.length) {
        return $res;
      }
      if (result.length === 1) {
        result = result[0];
      }
      return result;
    };
    vv = $('div.calendar').Calendar({
      'viewType': Calendar.VIEW_WEEK,
      'daysCollectionBaseURL': 'ddsfds'
    });
    console.log(vv);
    vv.Calendar('hello', 'Hi');
    return console.log(vv.Calendar('options'));
  });

  CalendarDay = (function(_super) {

    __extends(CalendarDay, _super);

    function CalendarDay() {
      return CalendarDay.__super__.constructor.apply(this, arguments);
    }

    CalendarDay.prototype.url = function() {
      return "" + CalendarDaysCollection.baseURL + "/" + this.id;
    };

    return CalendarDay;

  })(Backbone.Model);

  CalendarDaysCollection = (function(_super) {

    __extends(CalendarDaysCollection, _super);

    function CalendarDaysCollection() {
      return CalendarDaysCollection.__super__.constructor.apply(this, arguments);
    }

    CalendarDaysCollection.prototype.model = CalendarDay;

    CalendarDaysCollection.baseURL = null;

    CalendarDaysCollection.prototype.url = function() {
      return "" + CalendarDaysCollection.baseURL;
    };

    return CalendarDaysCollection;

  })(Backbone.Collection);

  CalendarDayEvent = (function(_super) {

    __extends(CalendarDayEvent, _super);

    function CalendarDayEvent() {
      return CalendarDayEvent.__super__.constructor.apply(this, arguments);
    }

    CalendarDayEvent.prototype.url = function() {
      return "" + CalendarDayEventsCollection.baseURL + "/" + this.id;
    };

    return CalendarDayEvent;

  })(Backbone.Model);

  CalendarDayEventsCollection = (function(_super) {

    __extends(CalendarDayEventsCollection, _super);

    function CalendarDayEventsCollection() {
      return CalendarDayEventsCollection.__super__.constructor.apply(this, arguments);
    }

    CalendarDayEventsCollection.prototype.model = CalendarDayEvent;

    CalendarDayEventsCollection.baseURL = null;

    CalendarDayEventsCollection.prototype.url = function() {
      return "" + CalendarDayEventsCollection.baseURL;
    };

    return CalendarDayEventsCollection;

  })(Backbone.Collection);

  CalendarDayView = (function(_super) {

    __extends(CalendarDayView, _super);

    function CalendarDayView() {
      return CalendarDayView.__super__.constructor.apply(this, arguments);
    }

    CalendarDayView.prototype.template = monthTemplate;

    CalendarDayView.prototype.refresh = function(date) {
      var endDate, now, startDay;
      now = moment(date).hours(12);
      startDay = moment(now).date(-1);
      endDate = moment(startDay).week(startDay.week() + 5).endOf('week');
      return this.$el.html(this.template({
        'startDay': startDay,
        'endDate': endDate
      }));
    };

    return CalendarDayView;

  })(Backbone.View);

  CalendarMonthView = (function(_super) {

    __extends(CalendarMonthView, _super);

    function CalendarMonthView() {
      return CalendarMonthView.__super__.constructor.apply(this, arguments);
    }

    CalendarMonthView.prototype.template = monthTemplate;

    CalendarMonthView.prototype.refresh = function(date) {
      var endDate, now, startDay;
      now = moment(date).hours(12);
      startDay = moment(now).date(-1);
      endDate = moment(startDay).week(startDay.week() + 5).endOf('week');
      return this.$el.html(this.template({
        'startDay': startDay,
        'endDate': endDate
      }));
    };

    return CalendarMonthView;

  })(Backbone.View);

  CalendarWeekView = (function(_super) {

    __extends(CalendarWeekView, _super);

    function CalendarWeekView() {
      return CalendarWeekView.__super__.constructor.apply(this, arguments);
    }

    CalendarWeekView.prototype.template = weekTemplate;

    CalendarWeekView.prototype.refresh = function(date) {
      var endDate, now, startDay;
      now = moment(date).hours(12);
      startDay = moment(now).startOf('week');
      endDate = moment(startDay).endOf('week');
      return this.$el.html(this.template({
        'startDay': startDay,
        'endDate': endDate
      }));
    };

    return CalendarWeekView;

  })(Backbone.View);

}).call(this);
