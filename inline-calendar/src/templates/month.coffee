
monthTemplate = _.template '
<table class="table table-bordered">
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
      <% while (startDay < endDate) { %>
          <% if (i % 7 === 0) { %>
              <tr>
          <% } %>
                  <td class="calendar-day">
                      <%= startDay.format("DD-MM-YYYY") %>
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
