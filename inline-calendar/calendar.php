<?php
sleep(mt_rand(0,3));
function generate_event($date, $times=1) {
    $events_names = array(
        'some event',
        'lanch with smb',
        'meeting with smb',
        'appointment',
        'dinner with',
        'meet smb',
        'release day',
    );

    $result = array();
    $names_length = count($events_names)-1;
    $id =  $date->getTimestamp();
    for( $i = 0; $i <= $times; $i++) {
        $index = $i > 0 && $i < $names_length
            ? $i
            : mt_rand(0, $names_length);

        $event= array(
            'id' => $id+1,
            'name' => $events_names[$index],
            'event_date' => $date->format('Y-m-d H:i:s')
        );
        $result[] = $event;
    }
    return $result;
}

$data = array();

if (isset($_REQUEST['startDay']) && isset($_REQUEST['endDay'])) {
    $startDate =  DateTime::createFromFormat('Y-m-d', $_REQUEST['startDay']);
    $endDate =  DateTime::createFromFormat('Y-m-d', $_REQUEST['endDay']);

    $dayInterval = new DateInterval('P'.mt_rand(1, 15).'D');
    if ( $endDate->diff($startDate)->days == 6 )
        $dayInterval = new DateInterval('P'.mt_rand(1, 3).'D');
    while ($startDate <= $endDate) {
        $data = array_merge($data, generate_event($startDate, mt_rand(1, 40)));
        $startDate->add($dayInterval);
    }
}
elseif (isset($_REQUEST['startDay']) && ! isset($_REQUEST['endDay'])) {
    $startDate =  DateTime::createFromFormat('Y-m-d', $_REQUEST['startDay']);
    $data = generate_event($startDate, mt_rand(8, 40));
}


if (ob_get_level())
{
    ob_end_clean();
}
header('Content-Type: application/json');
echo json_encode($data, JSON_PRETTY_PRINT | JSON_HEX_TAG);
