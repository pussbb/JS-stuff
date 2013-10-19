// Generated by CoffeeScript 1.6.3
(function() {
  var AbstractCalendarView, CalendarDayEvent, CalendarDayEventsCollection, CalendarDayView, CalendarException, CalendarHeaderView, CalendarMonthView, CalendarView, CalendarWeekView, calendarHeaderTemplate, calendarTemplate, changeMonthYear, dayTemplate, monthTemplate, weekTemplate, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  calendarTemplate = _.template('\
  <div class="clalendar-js">\
    <div class="header">\
    </div>\
    <div class="calendar-container">\
    </div>\
  </div>\
');

  calendarHeaderTemplate = _.template('\
<div class="prev">\
    <button type="button" class="btn btn-default">\
        <span class="glyphicon glyphicon-arrow-left"></span>\
    </button>\
</div>\
<div class="content">\
    <div class="title"></div>\
    <div class="clearfix"></div>\
    <div class="btn-group pull-right">\
      <button type="button" class="btn btn-default view-3">\
          Month View\
      </button>\
      <button type="button" class="btn btn-default view-2">\
          Week View\
      </button>\
      <button type="button" class="btn btn-default view-1">\
          Day View\
      </button>\
    </div>\
\
</div>\
<div class="next pull-right">\
    <button type="button" class="btn btn-default">\
        <span class="glyphicon glyphicon-arrow-right"></span>\
    </button>\
</div>\
');

  changeMonthYear = _.template('\
<div class="btn-group">\
<form class="form-inline" name="change_month_year" role="form">\
  <div class="form-group">\
    <select name="month" class="form-control">\
        <% _.each(moment.months(), function(name, key){ %>\
            <option\
            <% if ( now.month() === key ) { %>\
              selected="selected"\
            <% } %>\
            value="<%= key %>">\
                <%= name %>\
            </option>\
        <% }) %>\
    </select>\
  </div>\
  <div class="form-group">\
    <select name="year" class="form-control">\
        <% startYear = moment().subtract("y", 20)%>\
        <% endYear = moment().add("y", 10) %>\
        <% year = now.year() %>\
        <% while(startYear <= endYear) {%>\
            <% value = startYear.year() %>\
            <option\
            <% if ( year  === value ) { %>\
              selected="selected"\
            <% } %>\
            value="<%= value %>">\
                <%= value %>\
            </option>\
            <% startYear.add("y", 1) %>\
        <% } %>\
    </select>\
  </div>\
  <button type="submit" class="btn btn-success">Done</button>\
</form>\
</div>\
');

  dayTemplate = _.template('\
<table class="table table-bordered">\
  <thead>\
    <tr>\
    </tr>\
  </thead>\
  <tbody>\
      <% nextDay = moment(now).add("d", 1); %>\
      <% while (now < nextDay) { %>\
        <tr class="week">\
            <td class="time">\
              <%= now.format("HH") %>\
              <% now.add("h", 1); %>\
            </td>\
            <td>\
                somthing\
            </td>\
        </tr>\
      <% }; %>\
  </tbody>\
  <tfoot>\
\
  </tfoot>\
</table>\
');

  monthTemplate = _.template('\
<table class="table table-bordered table-fixed">\
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
      <% month = now.month() %>\
      <% date = moment() %>\
      <% while (startDay < endDate) { %>\
          <% if (i % 7 === 0) { %>\
              <tr>\
          <% } %>\
                  <% cssclass = "" %>\
                  <% dateInfo = "" %>\
                  <% if(month !== startDay.month()) { %>\
                      <% cssclass = " grey " %>\
                  <% } %>\
                  <% if( _.contains([0,6], startDay.day())) { %>\
                      <% cssclass += " label-warning " %>\
                  <% } %>\
                  <% if( startDay.isSame(date, "day") ) { %>\
                      <% cssclass += " label-success " %>\
                      <% dateInfo = "Today" %>\
                  <% } %>\
                  <td class="calendar-day <%= cssclass %>" data-day="<%= startDay %>">\
                      <span class="day">\
                        <a href="#">\
                            <%= startDay.format("DD") %>\
                        </a>\
                      </span>\
                      <span>\
                          <b> <%= dateInfo %> </b>\
                      </span>\
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

  AbstractCalendarView = (function(_super) {
    __extends(AbstractCalendarView, _super);

    function AbstractCalendarView() {
      _ref = AbstractCalendarView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    AbstractCalendarView.prototype.parent = null;

    AbstractCalendarView.prototype.initialize = function($el, parent) {
      this.$el = $el;
      this.parent = parent != null ? parent : this;
      return this;
    };

    return AbstractCalendarView;

  })(Backbone.View);

  CalendarView = (function(_super) {
    __extends(CalendarView, _super);

    function CalendarView() {
      _ref1 = CalendarView.__super__.constructor.apply(this, arguments);
      return _ref1;
    }

    CalendarView.VIEW_DAY = 1;

    CalendarView.VIEW_WEEK = 2;

    CalendarView.VIEW_MONTH = 3;

    CalendarView.availableViews = [CalendarView.VIEW_DAY, CalendarView.VIEW_WEEK, CalendarView.VIEW_MONTH];

    CalendarView.prototype.template = calendarTemplate;

    CalendarView.prototype.options = {
      viewType: CalendarView.VIEW_WEEK,
      dayView: null,
      weekView: null,
      monthView: null,
      dayEventsCollectionBaseURL: null,
      dayEventsCollection: null
    };

    CalendarView.prototype.initialize = function($el, options) {
      var data, klass, option, views, _ref2;
      this.$el = $el;
      this.moment = moment().hours(12);
      if (_.isObject(options)) {
        this.options = _.extend(this.options, options);
      }
      if (this.options.dayEventsCollectionBaseURL) {
        CalendarDayEventsCollection.baseURL = this.options.dayEventsCollectionBaseURL;
      }
      if (_.isObject(this.options.dayEventsCollection) && this.options.dayEventsCollection instanceof CalendarDayEventsCollection) {
        this.collection = this.options.dayEventsCollection;
      } else {
        data = _.isArray(((_ref2 = this.options.dayEventsCollection) != null ? _ref2 : this.options.dayEventsCollection) | []);
        this.collection = this.options.dayEventsCollection = new CalendarDayEventsCollection(data);
      }
      this.render();
      this.container = $('div.calendar-container', this.$el);
      views = {
        'dayView': CalendarDayView,
        'weekView': CalendarWeekView,
        'monthView': CalendarMonthView
      };
      for (option in views) {
        klass = views[option];
        if (!this.options[option]) {
          this.options[option] = new klass(this.container, this);
        } else {
          this.options[option].$el = this.container;
          this.options[option].parent = this;
        }
      }
      return this.refresh();
    };

    CalendarView.prototype.render = function() {
      this.$el.html(this.template());
      this.header = new CalendarHeaderView($('.header', this.$el), this);
      return this;
    };

    CalendarView.prototype.clear = function() {
      this.container.html('');
      return this;
    };

    CalendarView.prototype.refresh = function(date) {
      this.clear();
      if (date) {
        this.moment = moment(date).hours(12);
        if (!this.moment.isValid()) {
          throw CalendarException("Invalid date", 69);
        }
      }
      switch (this.options.viewType) {
        case CalendarView.VIEW_DAY:
          this.options.dayView.refresh(this.moment);
          break;
        case CalendarView.VIEW_WEEK:
          this.options.weekView.refresh(this.moment);
          break;
        case CalendarView.VIEW_MONTH:
          this.options.monthView.refresh(this.moment);
          break;
        default:
          throw CalendarException('Not supported view type', 34);
      }
      this.header.activateButton(this.options.viewType);
      return this;
    };

    CalendarView.prototype.changeViewTo = function(type, date) {
      if (type == null) {
        type = CalendarView.VIEW_MONTH;
      }
      if (__indexOf.call(CalendarView.availableViews, type) < 0) {
        throw CalendarException('Not supported view type', 34);
      }
      this.options.viewType = type;
      return this.refresh(date);
    };

    CalendarView.prototype.option = function(name, value) {
      if (!value) {
        return this.options[name];
      }
      switch (name) {
        case 'viewType':
          return this.changeViewTo(value);
        default:
          return this.options[name] = value;
      }
    };

    return CalendarView;

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
          obj = new CalendarView($el, options);
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
    return vv = $('div.calendar').Calendar({
      'viewType': CalendarView.VIEW_MONTH
    });
  });

  CalendarDayView = (function(_super) {
    __extends(CalendarDayView, _super);

    function CalendarDayView() {
      _ref2 = CalendarDayView.__super__.constructor.apply(this, arguments);
      return _ref2;
    }

    CalendarDayView.prototype.template = dayTemplate;

    CalendarDayView.prototype.refresh = function(now) {
      now.hours(0);
      this.parent.header.setTitle(now.format('dddd DD MMMM YYYY'));
      return this.$el.html(this.template({
        'now': now
      }));
    };

    return CalendarDayView;

  })(AbstractCalendarView);

  CalendarHeaderView = (function(_super) {
    __extends(CalendarHeaderView, _super);

    function CalendarHeaderView() {
      _ref3 = CalendarHeaderView.__super__.constructor.apply(this, arguments);
      return _ref3;
    }

    CalendarHeaderView.prototype.template = calendarHeaderTemplate;

    CalendarHeaderView.prototype.changeMonthYearTemplate = changeMonthYear;

    CalendarHeaderView.prototype.events = {
      'click .content button[class*="view-"]': '_change_view_event_handler',
      'click .prev button': '_previuos_event_handler',
      'click .next button': '_next_event_handler',
      'dblclick .content .changable': '_header_title_dblclick_event_handler',
      'submit form[name="change_month_year"]': '_change_month_year_event_handler'
    };

    CalendarHeaderView.prototype.initialize = function($el, parent) {
      this.$el = $el;
      this.parent = parent != null ? parent : this;
      return this.render();
    };

    CalendarHeaderView.prototype.render = function() {
      this.$el.html(this.template());
      this.title = $('.content .title', this.$el);
      return this;
    };

    CalendarHeaderView.prototype.activateButton = function(name) {
      this.$('.content button[class*="view-"]', this.$el).removeClass('btn-primary');
      return this.$(".content button.view-" + name, this.$el).addClass('btn-primary');
    };

    CalendarHeaderView.prototype.setTitle = function(title, changable) {
      if (changable == null) {
        changable = false;
      }
      this.title.html(title);
      if (changable) {
        return this.title.addClass('changable');
      } else {
        return this.title.removeClass('changable');
      }
    };

    CalendarHeaderView.prototype._change_view_event_handler = function(e) {
      var $btn, i, _i, _len, _ref4;
      $btn = $(e.target);
      _ref4 = CalendarView.availableViews;
      for (_i = 0, _len = _ref4.length; _i < _len; _i++) {
        i = _ref4[_i];
        if ($btn.hasClass("view-" + i)) {
          this.parent.changeViewTo(i);
          return;
        }
      }
    };

    CalendarHeaderView.prototype._previuos_event_handler = function() {
      switch (this.parent.options.viewType) {
        case CalendarView.VIEW_DAY:
          this.parent.moment.subtract('days', 2);
          break;
        case CalendarView.VIEW_WEEK:
          this.parent.moment.subtract('w', 1);
          break;
        case CalendarView.VIEW_MONTH:
          this.parent.moment.subtract('M', 1);
          break;
        default:
          throw CalendarException('Not supported view type', 34);
      }
      return this.parent.refresh();
    };

    CalendarHeaderView.prototype._next_event_handler = function() {
      switch (this.parent.options.viewType) {
        case CalendarView.VIEW_DAY:
          this.parent.moment.startOf('day').add('h', 12);
          break;
        case CalendarView.VIEW_WEEK:
          this.parent.moment.add('w', 1);
          break;
        case CalendarView.VIEW_MONTH:
          this.parent.moment.add('M', 1);
          break;
        default:
          throw CalendarException('Not supported view type', 34);
      }
      return this.parent.refresh();
    };

    CalendarHeaderView.prototype._header_title_dblclick_event_handler = function() {
      return this.title.html(this.changeMonthYearTemplate({
        'now': this.parent.moment
      }));
    };

    CalendarHeaderView.prototype._change_month_year_event_handler = function(e) {
      var $form, i, _i, _len, _ref4;
      e.preventDefault();
      $form = $(e.target);
      _ref4 = ['month', 'year'];
      for (_i = 0, _len = _ref4.length; _i < _len; _i++) {
        i = _ref4[_i];
        this.parent.moment.set(i, parseInt($("select[name='" + i + "']", $form).val(), 10));
      }
      return this.parent.refresh();
    };

    return CalendarHeaderView;

  })(AbstractCalendarView);

  CalendarMonthView = (function(_super) {
    __extends(CalendarMonthView, _super);

    function CalendarMonthView() {
      _ref4 = CalendarMonthView.__super__.constructor.apply(this, arguments);
      return _ref4;
    }

    CalendarMonthView.prototype.template = monthTemplate;

    CalendarMonthView.prototype.events = {
      'click .calendar-day .day a': '_view_day_event_handler'
    };

    CalendarMonthView.prototype._view_day_event_handler = function(e) {
      e.preventDefault();
      return this.parent.changeViewTo(CalendarView.VIEW_DAY, $(e.target).closest('td').data('day'));
    };

    CalendarMonthView.prototype.refresh = function(now) {
      var endDate, startDay;
      this.parent.header.setTitle(now.format('MMMM YYYY'), true);
      startDay = moment(now).startOf('month').startOf('week');
      endDate = moment(startDay).week(startDay.week() + 5).endOf('week');
      return this.$el.html(this.template({
        'startDay': startDay,
        'endDate': endDate,
        'now': now
      }));
    };

    return CalendarMonthView;

  })(AbstractCalendarView);

  CalendarWeekView = (function(_super) {
    __extends(CalendarWeekView, _super);

    function CalendarWeekView() {
      _ref5 = CalendarWeekView.__super__.constructor.apply(this, arguments);
      return _ref5;
    }

    CalendarWeekView.prototype.template = weekTemplate;

    CalendarWeekView.prototype.refresh = function(now) {
      var endDate, startDay;
      this.parent.header.setTitle(now.format('MMMM gggg'), true);
      startDay = moment(now).startOf('week');
      endDate = moment(startDay).endOf('week');
      return this.$el.html(this.template({
        'startDay': startDay,
        'endDate': endDate
      }));
    };

    return CalendarWeekView;

  })(AbstractCalendarView);

  CalendarDayEvent = (function(_super) {
    __extends(CalendarDayEvent, _super);

    function CalendarDayEvent() {
      _ref6 = CalendarDayEvent.__super__.constructor.apply(this, arguments);
      return _ref6;
    }

    CalendarDayEvent.prototype.url = function() {
      return "" + CalendarDayEventsCollection.baseURL + "/" + this.id;
    };

    return CalendarDayEvent;

  })(Backbone.Model);

  CalendarDayEventsCollection = (function(_super) {
    __extends(CalendarDayEventsCollection, _super);

    function CalendarDayEventsCollection() {
      _ref7 = CalendarDayEventsCollection.__super__.constructor.apply(this, arguments);
      return _ref7;
    }

    CalendarDayEventsCollection.prototype.model = CalendarDayEvent;

    CalendarDayEventsCollection.baseURL = null;

    CalendarDayEventsCollection.prototype.url = function() {
      return "" + CalendarDayEventsCollection.baseURL;
    };

    return CalendarDayEventsCollection;

  })(Backbone.Collection);

}).call(this);
