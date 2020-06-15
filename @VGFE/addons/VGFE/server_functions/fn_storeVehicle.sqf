/*
	VGFE_fnc_storeVehicle 
	Copyright 2020 by Ghostrider-GRG-
*/

params["_vgfe","_vgfeKey","_vehicle","_player"];

/* we can only process one client request at a time so add a check for a pendiing request to access VG */
waitUntil{MyVGFEstate == 1};

/* Tell the server a request is pending */
MyVGFEstate = 0;

private _p = ["_vgfe","_vgfeKey","_vehicle","_player"];
{
	diag_log format["_fnc_storeVehicle: _this %1 = %2",_forEachIndex,_x];
} forEach _this;
private _vehSlot = _vehicle getVariable ["VEHICLE_SLOT", "ABORT"];
if !(_vehSlot isEqualTo "ABORT") then 
{  //  So we do not store temporary vehicles
	_vgfeKey = _vgfeKey + 1;
	/*  tie this to configs at some point */
	private _expiresAt = getNumber(missionConfigFile >> "CfgVGFE" >> "vgfeExpires");
	private _className = typeOf _vehicle;
	private _location = [getPosATL _vehicle, [vectorDir _vehicle, vectorUp _vehicle]];
	private _condition = [_vehicle] call VGFE_fnc_getVehicleCondition;
	private _inventory = [_vehicle] call EPOCH_server_CargoSave;
	private _textures = getObjectTextures _vehicle;
	private _loadout = [_vehicle] call VGFE_fnc_getVehicleLoadout;
	private _nickname = getPlateNumber _vehicle;
	private _vehicleLockState = locked _vehicle;
	private _vehicleData = [_className,_location,_condition,_inventory,_textures,_loadout,_nickname,_vehicleLockState];
	//(["VGkey", _uid] call EPOCH_fnc_server_hiveGETRANGE) params [["_key",-1]];

	_vgfe pushBack [_vgfeKey,_vehicleData];
	private _expiresAt = getNumber(missionConfigFile >> "CfgVGFE" >> "vgfeExpires");
	["VGFE_DATA", getPlayerUID _player, _expiresAt, _vgfe] call EPOCH_fnc_server_hiveSETEX;
	["VGFE_KEY",getPlayerUID _player,_expiresAt,[_vgfeKey]] call EPOCH_fnc_server_hiveSETEX;


	diag_log format["_fnc_storeVehilcle: key set to = %1",_vgfeKey];
	MyVGFE = _vgfe;
	MyVGFEkey = _vgfeKey;
	(owner _player) publicVariableClient "MyVGFE";
	(owner _player) publicVariableClient "MyVGFEkey";
	diag_log format["_fnc_storeVehicle: _MyVGFEkey %1 | MyVGFE %2",MyVGFEkey,MyVGFE];
	deleteVehicle _vehicle;	

	/*
		The code below was adapted from files in epoch_server.
		Credit: EpodhMod Development Team 
		https://github.com/EpochModTeam/Epoch
	*/

	private _vehHiveKey = format ["%1:%2", (call EPOCH_fn_InstanceID), _vehSlot];
	["Vehicle", _vehHiveKey] call EPOCH_fnc_server_hiveDEL;
	EPOCH_VehicleSlots pushBackUnique _vehSlot;
	missionNamespace setVariable ['EPOCH_VehicleSlotCount', count EPOCH_VehicleSlots, true];
	[format["Vehicle Stored | _key updated to %1",MyVGFEkey]] remoteExec["systemChat",owner _player];
	["Vehicle Stored",5] remoteExec["Epoch_Message",owner player];
	[format["Vehicle Stored | _key updated to %1",MyVGFEkey]] remoteExec["diag_log",owner _player];
};

/* tell the server the VG is ready to handle other requests */
MyVGFEstate = 1;


