


params["_vgfe","_key","_player"];
diag_log format["_fnc_retrieveVehicle: _key = %1 | _vgfe = %2",_key,_vgfe];
private _vgfeSlot = [];
private _index = -1;
if !(EPOCH_VehicleSlots isEqualTo []) then 
{
	/* Get vehicle data from VG */
	{
		if (_key == (_x select 0)) exitWith {_vgfeSlot = _x; _index = _forEachIndex};
	} forEach _vgfe;
	diag_log format["_fnc_retrieveVehicle: _key = %1 | _index = %2 | _vgfeSlot = %3",_key,_index,_vgfeSlot];
	private _vehicleData = _vgfe deleteAt _index;
	private _vehicle = _vgfe deleteAt _index;
	MyVGFE = _vgfe;
	(owner _player) publicvariableclient "MyVGFE";

	private _playerUID = getPlayerUID _player;
	/* pull this from configs */ 
	private _expiresAt = getNumber(missionConfigFile >> "CfgVGFE" >> "vgfeExpires");

	["VGFE_DATA",_playerUID,_expiresAt,_vgfe] call EPOCH_fnc_server_hiveSETEX;

	/* Spawn and configure the vehicle */
	_vehicleData params ["_className","_location","_condition","_inventory","_textures","_loadout","_nickname","_vehicleLockState"];
	_location params ["_posATL","_vectorUpDir"];

	/*
		spawn vehicle and set it up 
	*/
	// [type, position, markers, placement, special]: 
	private _vehicle = createVehicle[_classname,_posATL,[],20,"NONE"];
	_vehicle call EPOCH_server_setVToken;
	[_vehicle,_condition] call VGFE_fnc_setVehicleCondition;
	[_vehicle,_inventory] call VGFE_fnc_setVehicleInventory;
	[_vehicle,_textures] call VGFE_fnc_setVehicleInventory;
	[_vehicle,_loadout] call VGFE_fnc_setVehicleLoadout;
	[_vehicle,_nickname] call VGFE_fnc_setVehicleNickname;
	_vehicle lock _vehicleLockState;
	_vehicle allowDamage true;
	_vehicle enableRopeAttach true;
	_vehicle setSlingload true;
	_vehicle enableSimulationGlobal true;
	private _isPersistant = true;

	/*
		The code below was adapted from files in epoch_server.
		Credit: EpodhMod Development Team 
		https://github.com/EpochModTeam/Epoch
	*/

	_vehslot = EPOCH_VehicleSlots select 0;
	EPOCH_VehicleSlots = EPOCH_VehicleSlots - [_vehslot];
	missionNamespace setVariable ['EPOCH_VehicleSlotCount', count EPOCH_VehicleSlots, true];	
	_lockOwner = getPlayerUID _player;
	_playerGroup = _player getVariable["GROUP", ""];
	if (_playerGroup isEqualTo "") then {
		_lockOwner = _playerGroup;
	};
	_vehicle setVariable["VEHICLE_TEXTURE", _textures];

	// Set slot used by vehicle
	_vehicle setVariable["VEHICLE_SLOT", _slot, true];

	// Lock vehicle for owner
	if (_locked && _lockOwner != "") then {
	_vehLockHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _slot];
	["VehicleLock", _vehLockHiveKey, EPOCH_vehicleLockTime, [_lockOwner]] call EPOCH_fnc_server_hiveSETEX;
	} else {
	_vehLockHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _slot];
	["VehicleLock", _vehLockHiveKey] call EPOCH_fnc_server_hiveDEL;
	};

	// new Dynamicsimulation
	if([configFile >> "CfgEpochServer", "vehicleDynamicSimulationSystem", true] call EPOCH_fnc_returnConfigEntry)then
	{
		_vehicle enableSimulationGlobal false; // turn it off until activated by dynamicSim
		_vehicle enableDynamicSimulation true;
	};

	// SAVE VEHICLE
	_vehicle call EPOCH_server_save_vehicle;

	// Event Handlers
	_vehicle call EPOCH_server_vehicleInit;
} else {
	/*
		Insufficient slots to spawn permenant vehicle
	*/
};



