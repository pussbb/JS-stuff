
_weekTemplate = '
<table class="table table-bordered table-striped">
  <thead>
    <tr class="week">
        <th>&nbsp;</th>
        <% startDay_ = moment(startDay) %>
        <% while (startDay_ <= endDate) {%>
            <% dateInfo = highlightDay(startDay_, now, false) %>
            <th class="day <%= dateInfo[0] %>" data-day="<%= startDay_ %>">
              <%= startDay_.format(dayInWeekFormat) %>
              <% startDay_.add("d", 1); %>
            </th>
        <% }; %>
    </tr>
  </thead>
  <tbody>
      <% nextDay = moment(now).add("d", 1); %>
      <% while (now < nextDay) { %>
          <tr class="week">
              <td class="time">
                <%= now.format(timeFormat) %>
                <% now.add("h", 1); %>
              </td>

            <td class="day"></td>
            <td class="day"></td>
            <td class="day"></td>
            <td class="day"></td>
            <td class="day"></td>
            <td class="day"></td>
            <td class="day"></td>
          </tr>
      <% }; %>
  </tbody>
  <tfoot>

  </tfoot>
</table>
'
weekTemplate = (data)->
  _.template _weekTemplate, _.extend(data, {highlightDay:highlightDay, })

eventsForDayInWeekTemplate = _.template '
<div class="week-day-events">
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
