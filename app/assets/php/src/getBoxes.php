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
$points = $argv[1]
$collection = new GeoTools\LatLngCollection($points);

$boxer = new GeoTools\RouteBoxer();

//calculate boxes with 10km distance from the line between points
$boxes = $boxer->box($collection, $distance = $argv[2]);

//boxes now contain an array of LatLngBounds
print_r(json_encode($boxer->tojson()));

?>