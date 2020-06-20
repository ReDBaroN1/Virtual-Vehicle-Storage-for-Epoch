params["_vehicle","_locationData"];
diag_log format["_vehicle = %1 | _locationData = %2",_vehicle,_locationData];
_locationData params["_posATL","_vectorDirUp"];	
_vehicle setPosATL _posATL;
_vehicle setVectorDirAndUp _vectorDirUp;