
dayTemplate = _.template '
<table class="table table-bordered table-striped" data-day="<%= now %>">
  <thead>
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

            </td>
        </tr>
      <% }; %>
  </tbody>
  <tfoot>

  </tfoot>
</table>
'
eventsForDayInDayTemplate = _.template '
<div class="day-events">
    <ul class="events">
        <% _.each(events, function(event) {%>
            <li>
              <a href="#">
                  <%= event.getTitle() %>
              </a>
            </li>
        <% }); %>
    </ul>
</div>
'
