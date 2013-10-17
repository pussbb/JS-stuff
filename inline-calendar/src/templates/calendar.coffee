

calendarTemplate =  _.template '
  <div class="clalendar-js">
    <div class="header">
        <div class="prev">
            <button type="button" class="btn btn-default">
                <span class="glyphicon glyphicon-arrow-left"></span>
            </button>
        </div>
        <div class="content">
            Calendar

            <div class="btn-group pull-right">
              <button type="button" class="btn btn-danger">
                  <span class="glyphicon glyphicon-cog"></span>
              </button>
              <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown">
                <span class="caret"></span>
              </button>
              <ul class="dropdown-menu" role="menu">
                <li>
                    <a class="view-month" href="#">Month View</a>
                </li>
                <li>
                    <a class="view-week" href="#">Week View</a>
                </li>
                <li>
                    <a class="view-day" href="#">Day View</a>
                </li>
                <li class="divider"></li>
                <li><a href="#">Comming soon</a></li>
              </ul>
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
