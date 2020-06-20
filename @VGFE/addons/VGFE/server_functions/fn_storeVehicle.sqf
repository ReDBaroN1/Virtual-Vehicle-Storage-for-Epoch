/*
	VGFE_fnc_storeVehicle 
	Copyright 2020 by Ghostrider-GRG-
*/

params["_vgfe","_vgfeKey","_accessPoint","_vehicle","_player"];

/* we can only process one client request at a time so add a check for a pendiing request to access VG */
waitUntil{MyVGFEstate == 1};

/* Tell the server a request is pending */
MyVGFEstate = 0;

//private _p = ["_vgfe","_vgfeKey","_vehicle","_player"];

private _vehSlot = _vehicle getVariable ["VEHICLE_SLOT", "ABORT"];
if !(_vehSlot isEqualTo "ABORT") then 
{  //  So we do not store temporary vehicles
	_vgfeKey = _vgfeKey + 1;

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

	_vgfe pushBack [_vgfeKey,_accessPoint,_vehicleData];
	MyVGFE = _vgfe;
	MyVGFEkey = _vgfeKey;
	(owner _player) publicVariableClient "MyVGFE";
	(owner _player) publicVariableClient "MyVGFEkey";
	private _expiresAt = getNumber(missionConfigFile >> "CfgVGFE" >> "vgfeExpiresAt");
	//diag_log format["_fnc_storeVehicle: _expiresAt = %1 | typeName _expiresAt = %2",_expiresAt, typeName _expiresAt];
	["VGFE_DATA", getPlayerUID _player, _expiresAt, MyVGFE] call EPOCH_fnc_server_hiveSETEX;
	["VGFE_KEY",getPlayerUID _player,_expiresAt,[MyVGFEkey]] call EPOCH_fnc_server_hiveSETEX;

	deleteVehicle _vehicle;	

	private _storageCost = getNumber(missionConfigFile >> "CfgVGFE" >> "storageCost");
	if (_storageCost > 0) then 
	{
		[_player,(_storageCost * -1)] call EPOCH_server_effectCrypto;
	};

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


