
weekTemplate = _.template '
<table class="table table-bordered">
  <thead>
    <tr>
        <% startDay_ = moment(startDay); %>
        <% while (startDay_ <= endDate) {%>
            <th>
              <%= startDay_.format("DD-MM-YYYY") %>
              <% startDay_.add("d", 1); %>
            </th>
        <% }; %>
    </tr>
  </thead>
  <tbody>
      <tr class="week">
        <% while (startDay <= endDate) { %>
            <td class="day">
              <%= startDay.format("DD-MM-YYYY") %>
              <% startDay.add("d", 1); %>
            </td>
        <% }; %>
      </tr>
  </tbody>
  <tfoot>

  </tfoot>
</table>
'
