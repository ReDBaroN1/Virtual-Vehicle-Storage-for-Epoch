/*
	VGFE_fnc_client_getLocalVehicles 
	Copyright 2020 by Ghostrider-GRG-
*/

params["_types","_object"];
private _vehicles = [];
private "_v";
private _searchDistance = getNumber(missionConfigfile >> "CfgVGFE" >> "vehicleSearchDistance");
private _v = nearestObjects[getPosATL player,_types,_searchDistance];
diag_log format["_fnc_client_getLocalVehicles: _v = %1 | _searchDistance = %2",_v, _searchDistance];
{
	if (local _x) then {_vehicles pushBack _x};
} forEach _v;	
diag_log format["_fnc_client_getLocalVehicles: returning _vehicles = %1",_vehicles];
_vehicles	