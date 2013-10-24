<?php
sleep(mt_rand(1,8));
function generate_event($date, $times=1) {
    $event= array(
            'id' => $date->getTimestamp(),
            'name' => 'some event '.$date->getTimestamp(),
            'event_date' => $date->format('Y-m-d H:i:s')
    );
    $result = array();
    for( $i = 0; $i <= $times; $i++) {
        $event['id'] = $event['id'] + 1;
        $result[] = $event;
    }
    return $result;
}

$data = array();

if (isset($_REQUEST['startDay']) && isset($_REQUEST['endDay'])) {
    $startDate =  DateTime::createFromFormat('Y-m-d', $_REQUEST['startDay']);
    $endDate =  DateTime::createFromFormat('Y-m-d', $_REQUEST['endDay']);

    $dayInterval = new DateInterval('P'.mt_rand(1, 15).'D');
    while ($startDate <= $endDate) {
        $data = array_merge($data, generate_event($startDate, mt_rand(1, 40)));
        $startDate->add($dayInterval);
    }
}
elseif (isset($_REQUEST['startDay']) && ! isset($_REQUEST['endDay'])) {
    $startDate =  DateTime::createFromFormat('Y-m-d', $_REQUEST['startDay']);
    $data = generate_event($startDate, mt_rand(1, 40));
}


if (ob_get_level())
{
    ob_end_clean();
}
header('Content-Type: application/json');
echo json_encode($data, JSON_PRETTY_PRINT | JSON_HEX_TAG);
