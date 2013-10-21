
dayTemplate = _.template '
<table class="table table-bordered table-striped">
  <thead>
    <tr>
    </tr>
  </thead>
  <tbody>
      <% nextDay = moment(now).add("d", 1); %>
      <% while (now < nextDay) { %>
        <tr class="day">
            <td class="time">
              <%= now.format(timeFormat) %>
              <% now.add("h", 1); %>
            </td>
            <td>
                somthing
            </td>
        </tr>
      <% }; %>
  </tbody>
  <tfoot>

  </tfoot>
</table>
'
