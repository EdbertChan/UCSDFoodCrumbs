
<?php
require("GeoTools/RouteBoxer.php");
require("GeoTools/LatLngCollection.php");
$points = [
    [48.167, 17.104],
    [48.399, 17.586],
    [48.908, 18.049],
    [49.22253, 18.734436],
    [48.728115, 21.255798],
];

$collection = new GeoTools\LatLngCollection($points);
$boxer = new GeoTools\RouteBoxer();

//calculate boxes with 10km distance from the line between points
$boxes = $boxer->box($collection, $distance = 10);

//boxes now contain an array of LatLngBounds

//literally have to return string that is printed to STDOUT. Maybe
//we can parse this some way?

echo (json_encode($boxes[0]));


?>