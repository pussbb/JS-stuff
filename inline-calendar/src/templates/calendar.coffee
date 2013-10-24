

calendarTemplate =  _.template '
  <div class="clalendar-js">
    <div class="header">
    </div>
    <div class="loading hidden">
        Loading...
    </div>
    <div class="calendar-container">
    </div>
  </div>
'

calendarHeaderTemplate = _.template '
<div class="prev">
    <button type="button" class="btn  prev btn-default">
        <span class="glyphicon glyphicon-arrow-left"></span>
    </button>
</div>
<div class="content">
    <div class="title"></div>
    <div class="clearfix"></div>
    <div class="btn-group pull-right">
      <button type="button" class="btn btn-default view-3">
          Month View
      </button>
      <button type="button" class="btn btn-default view-2">
          Week View
      </button>
      <button type="button" class="btn btn-default view-1">
          Day View
      </button>
    </div>

</div>
<div class="next pull-right">
    <button type="button" class="btn next btn-default">
        <span class="glyphicon glyphicon-arrow-right"></span>
    </button>
</div>
'

calendarHeaderMiniTemplate = _.template '
<div class="content mini">
    <div class="title"></div>
</div>
<div class="pull-right">
    <button type="button" class="btn prev btn-default">
        <span class="glyphicon glyphicon-arrow-left"></span>
    </button>
    <button type="button" class="btn next btn-default">
        <span class="glyphicon glyphicon-arrow-right"></span>
    </button>
</div>
'


changeMonthYear = _.template '
<div class="btn-group">
<form class="form-inline" name="change_month_year" role="form">
  <div class="form-group">
    <select name="month" class="form-control">
        <% months = moment(now).startOf("year").startOf("month")%>
        <% currentMonth = now.month() %>
        <% for( i = months.month(); i <= 11; i++ ) { %>
            <option
            <% if ( currentMonth === i ) { %>
              selected="selected"
            <% } %>
            value="<%= i %>">
                <%= months.format("MMMM") %>
            </option>
            <% months.add("M", 1) %>
        <% } %>
    </select>
  </div>
  <div class="form-group">
    <select name="year" class="form-control">
        <% startYear = moment().subtract("y", 20)%>
        <% endYear = moment().add("y", 10) %>
        <% year = now.year() %>
        <% while(startYear <= endYear) {%>
            <% value = startYear.year() %>
            <option
            <% if ( year  === value ) { %>
              selected="selected"
            <% } %>
            value="<%= value %>">
                <%= value %>
            </option>
            <% startYear.add("y", 1) %>
        <% } %>
    </select>
  </div>
  <button type="submit" class="btn btn-success">Done</button>
</form>
</div>
'
