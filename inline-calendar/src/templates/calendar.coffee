

calendarTemplate =  _.template '
  <div class="clalendar-js">
    <div class="header">
    </div>
    <div class="calendar-container">
    </div>
  </div>
'

calendarHeaderTemplate = _.template '
<div class="prev">
    <button type="button" class="btn btn-default">
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
    <button type="button" class="btn btn-default">
        <span class="glyphicon glyphicon-arrow-right"></span>
    </button>
</div>
'

changeMonthYear = _.template '
<div class="btn-group">
<form class="form-inline" role="form">
  <div class="form-group">
    <select name="month" class="form-control">
        <% _.each(moment.months(), function(name, key){ %>
            <option
            <% if ( now.month() === key ) { %>
              selected="selected"
            <% } %>
            value="<%= key %>">
                <%= name %>
            </option>
        <% }) %>
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
