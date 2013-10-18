
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
      <% while (startDay < endDate) { %>
          <% if (i % 7 === 0) { %>
              <tr>
          <% } %>
                  <td class="calendar-day <% if(month !== startDay.month()){%> grey <%}%>" data-day="<%= startDay %>">
                      <span class="day">
                        <a href="#">
                            <%= startDay.format("DD") %>
                        </a>
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
