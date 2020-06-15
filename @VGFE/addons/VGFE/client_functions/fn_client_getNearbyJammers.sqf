/*
	VGFE_fnc_client_getNearbyJammers
	Copyright 2020 by Ghostrider-GRG-
*/
private _jammerRange = getnumber (missionConfigFile >> "CfgEpochClient" >> "buildingJammerRange");
diag_log format["_fnc_client_getNearbyJammers: _jammerRange = %1",_jammerRange];
private _freqJammers = nearestObjects[
	getPosATL player,
	[] call EPOCH_JammerClasses, 
	200
];
diag_log format["_fnc_client_getNearbyJammers: _freqJammers = %1",_freqJammers];
private _jammer = objNull;
{
	if ([player, _x] call VGFE_fnc_client_isBuildOwner) exitWith 
	{
		_jammer = _x;
		_jammerRange = getNumber(missionConfigFile >> "CfgEpochClient" >> typeOf _jammer >>  "buildingJammerRange");
		diag_log format["_fnc_client_getNearbyJammers: jamer %1 found with _jammerRange of %2",_jammer,_jammerRange];
	};
} forEach _freqJammers;
private "_return";
if (isNull _jammer) then 
{
	_return = -1;
} else {
	_return = [_jammer,_jammerRange];	
};
diag_log format["_fnc_client_getNearbyJammers: _return = %1",_return];
_return