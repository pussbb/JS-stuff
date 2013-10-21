
_weekTemplate = '
<table class="table table-bordered">
  <thead>
    <tr>
        <% startDay_ = moment(startDay); %>
        <% while (startDay_ <= endDate) {%>
            <% dateInfo = highlightDay(startDay_, now, false) %>
            <th class="day <%= dateInfo[0] %>" >
              <%= startDay_.format("dd. DD MMMM") %>
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
weekTemplate = (data)->
  _.template _weekTemplate, _.extend(data, {highlightDay:highlightDay, })
