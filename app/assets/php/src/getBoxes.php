<?php

require("GeoTools/LatLngCollection.php");
require("GeoTools/RouteBoxer.php");
//this script will take a json string of a valid google directions response and will
//return an array of boxes. This function does not do the checking itself

//argv[1] = jsonstring
//argv[2] = radius of line between points
//we could just write
//if( $argv[2] == NULL)
//and asign a default value but we should handle that in the helper


//add all points from calculated route
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
print_r(json_encode($boxer->tojson()));

?>