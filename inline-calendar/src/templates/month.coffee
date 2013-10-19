
monthTemplate = _.template '
<table class="table table-bordered table-fixed">
  <thead>
    <tr>
        <% _.each(moment.weekdays(), function (name) {%>
            <th>
              <%= name %>
            </th>
        <% });%>
    </tr>
  </thead>
  <tbody>
  </tbody>
  <tfoot>
      <% i = 0; %>
      <% month = now.month() %>
      <% date = moment() %>
      <% while (startDay < endDate) { %>
          <% if (i % 7 === 0) { %>
              <tr>
          <% } %>
                  <% cssclass = "" %>
                  <% dateInfo = "" %>
                  <% if(month !== startDay.month()) { %>
                      <% cssclass = " grey " %>
                  <% } %>
                  <% if( _.contains([0,6], startDay.day())) { %>
                      <% cssclass += " label-warning " %>
                  <% } %>
                  <% if( startDay.isSame(date, "day") ) { %>
                      <% cssclass += " label-success " %>
                      <% dateInfo = "Today" %>
                  <% } %>
                  <td class="calendar-day <%= cssclass %>" data-day="<%= startDay %>">
                      <span class="day">
                        <a href="#">
                            <%= startDay.format("DD") %>
                        </a>
                      </span>
                      <span>
                          <b> <%= dateInfo %> </b>
                      </span>
                  </td>
          <% startDay.add("d", 1); %>
          <% i++; %>
          <% if (i % 7 === 0) { %>
              </tr>
          <% } %>
      <% } %>

  </tfoot>
</table>
'
