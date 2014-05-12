
<?php
//this script will take a json string of a valid google directions response and will
//return an array of boxes. This function does not do the checking itself

//argv[1] = jsonstring
//argv[2] = radius of line between points
//we could just write
//if( $argv[2] == NULL)
//and asign a default value but we should handle that in the helper

$parsed_json = json_decode($argv[1], true);



$polyline = $parsed_json['routes'][0]['overview_polyline']['points'];

$routepoints = decodePolylineToArray($polyline);

$collection = new LatLngCollection($routepoints);

$boxer = new RouteBoxer();

//calculate boxes with 10km distance from the line between points
$boxes = $boxer->box($collection, $distance = $argv[2]);

foreach($boxes as $row){

$southWestLtd = $row->southWest->latitude;
$southWestLng = $row->southWest->longitude;
$northEastLtd = $row->northEast->latitude;
$northEastLng = $row->northEast->longitude;

$query = "SELECT * FROM markers WHERE Latitude > $southWestLtd AND Latitude < $northEastLtd AND Longitude > $southEastLng AND Longitude < $norhtEastLng";
}

?>