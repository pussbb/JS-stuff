

highlightDay = (day, now, sameMonth=true)->
  cssClass = ""
  dateInfo = ""
  if sameMonth
    if not day.isSame now, 'month'
      cssClass = " grey "
  if day.day() in [0,6]
    cssClass += " weekend"
  if day.isSame(today, "day")
    cssClass += " today "
    dateInfo = "Today"
  [cssClass, dateInfo]

_monthTemplate = '
<table class="table table-bordered table-fixed">
  <thead>
    <tr>
        <% startOfWeek = moment(startDay).startOf("week") %>
        <% endOfWeek = moment(startDay).endOf("week") %>
        <% while(startOfWeek<=endOfWeek) { %>
            <th>
              <%= startOfWeek.format("dddd") %>
              <% startOfWeek.add("d",1) %>
            </th>
        <% } %>
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
                  <% dateInfo = highlightDay(startDay, now) %>
                  <td class="day expanded-day <%= dateInfo[0] %>" data-day="<%= startDay %>">
                      <span class="date">
                        <a href="#">
                            <%= startDay.format("DD") %>
                        </a>
                      </span>
                      <span>
                          <b> <%= dateInfo[1] %> </b>
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

_monthTemplateMini = '
<table class="table table-bordered table-fixed">
  <thead>
    <tr>
        <% startOfWeek = moment(startDay).startOf("week") %>
        <% endOfWeek = moment(startDay).endOf("week") %>
        <% while(startOfWeek<=endOfWeek) { %>
            <th>
              <%= startOfWeek.format("dd") %>
              <% startOfWeek.add("d",1) %>
            </th>
        <% } %>
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
                  <% dateInfo = highlightDay(startDay, now) %>
                  <td class="day <%= dateInfo[0] %>" data-day="<%= startDay %>">
                      <span class="date">
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

monthTemplate = (data)->
  _.template _monthTemplate,_.extend(data, {highlightDay:highlightDay})

monthTemplateMini = (data)->
  _.template _monthTemplateMini, _.extend(data, {highlightDay:highlightDay})
