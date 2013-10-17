

calendarTemplate =  _.template '
  <div class="clalendar-js">
    <div class="header">
        <div class="prev">
            <button type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-arrow-left"></span>
            </button>
        </div>
        <div class="content">
            <span class="title">
            </span>

            <div class="btn-group pull-right">
              <button type="button" class="btn btn-default view-month">
                  Month View
              </button>
              <button type="button" class="btn btn-default view-week">
                  Week View
              </button>
              <button type="button" class="btn btn-default view-day">
                  Day View
              </button>
            </div>

        </div>
        <div class="next pull-right">
            <button type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-arrow-right"></span>
            </button>
        </div>
    </div>
    <div class="calendar-container">
    </div>
  </div>
'
