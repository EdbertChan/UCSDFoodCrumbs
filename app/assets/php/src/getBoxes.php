<?php

require("GeoTools/LatLngCollection.php");
require("GeoTools/RouteBoxer.php");
//this script will take a json string of a valid google directions response and will
//return an array of boxes. This function does not do the checking itself

//argv[1] = ruby array
//argv[2] = radius of line between points
//we could just write
//if( $argv[2] == NULL)
//and asign a default value but we should handle that in the helper

$points = json_decode($argv[1]);

//$points = [[34.0551021,-117.750027],[34.0228224,-117.7473442],[34.0135928,-117.4462125],[34.0119904,-117.4432661],[34.0082498,-117.4295248],[33.9994987,-117.4298536]];
$collection = new GeoTools\LatLngCollection($points);

$boxer = new GeoTools\RouteBoxer();

//calculate boxes with 10km distance from the line between points
$boxes = $boxer->box($collection, $distance = $argv[2]);

//boxes now contain an array of LatLngBounds
print_r(json_encode($boxer->tojson()));

?>