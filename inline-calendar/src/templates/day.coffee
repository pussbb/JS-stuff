
dayTemplate = _.template '
<table class="table table-bordered">
  <thead>
    <tr>
    </tr>
  </thead>
  <tbody>
      <% nextDay = moment(now).add("d", 1); %>
      <% while (now < nextDay) { %>
        <tr class="week">
            <td class="time">
              <%= now.format("HH") %>
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
