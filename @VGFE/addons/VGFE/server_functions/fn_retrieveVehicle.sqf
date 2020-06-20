/*
	VGFE_fnc_retrieveVehicle 
	Copyright 2020 by Ghostrider-GRG-
*/

params["_vgfe","_key","_player"];

/* we can only process one client request at a time so add a check for a pendiing request to access VG */
waitUntil{MyVGFEstate == 1};

/* Tell the server a request is pending */
MyVGFEstate = 0;

private _vgfeSlot = [];
private _index = -1;
if !(EPOCH_VehicleSlots isEqualTo []) then 
{
	/* Get vehicle data from VG */
	{
		if (_key == (_x select 0)) exitWith {_vgfeSlot = _x; _index = _forEachIndex};
	} forEach _vgfe;
	private _vgfeSlot = _vgfe select _index;
	_vgfeSlot params["_key","_accessPoint","_vehicleData"];
	_vehicleData params ["_className","_location","_condition","_inventory","_textures","_loadout","_nickname","_vehicleLockState"];
	_location params ["_posATL","_vectorUpDir"];	

	/*
		The code below was adapted from files in epoch_server.
		Credit: EpodhMod Development Team 
		https://github.com/EpochModTeam/Epoch
	*/	
		/* Spawn and configure the vehicle */
	
	// [type, position, markers, placement, special]: 
	private _vehicle = createVehicle[_classname,_posATL,[],20,"NONE"];
	if !(isNull _vehicle) then 
	{
		_vehicle allowDamage false;
		_vehicle call EPOCH_server_setVToken;

		//  The initial spawn includes a safety factor of 20 meters; lets reposition the vehicle where the player left it 
		// (and cross our fingers nothing goes boom)

		// Set position and orientation first just in case the vehicle is near something on repositioning
		_vehicle setVectorDirAndUp _vectorUpDir;
		_vehicle setPosATL _posATL;

		_vehicle setVariable ["BIS_enableRandomization", false];
		private _slot = EPOCH_VehicleSlots deleteAt 0;
		missionNamespace setVariable ['EPOCH_VehicleSlotCount', count EPOCH_VehicleSlots, true];	
		private _lockOwner = getPlayerUID _player;
		private _playerGroup = _player getVariable["GROUP", ""];
		if (_playerGroup isEqualTo "") then {
			_lockOwner = _playerGroup;
		};
		_vehicle setVariable["VEHICLE_TEXTURE", _textures];

		// Set slot used by vehicle
		_vehicle setVariable["VEHICLE_SLOT", _slot, true];

		// Lock vehicle for owner
		private _locked = _vehicleLockState in [1,2,3];
		if (_locked && _lockOwner != "") then {
			private _vehLockHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _slot];
			["VehicleLock", _vehLockHiveKey, EPOCH_vehicleLockTime, [_lockOwner]] call EPOCH_fnc_server_hiveSETEX;
		} else {
			private _vehLockHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _slot];
			["VehicleLock", _vehLockHiveKey] call EPOCH_fnc_server_hiveDEL;
		};

		// new Dynamicsimulation
		if([configFile >> "CfgEpochServer", "vehicleDynamicSimulationSystem", true] call EPOCH_fnc_returnConfigEntry)then
		{
			_vehicle enableSimulationGlobal false; // turn it off until activated by dynamicSim
			_vehicle enableDynamicSimulation true;
		};

		private _serverSettingsConfig = configFile >> "CfgEpochServer";
		// Remove restricted weapons 
		private _removeweapons = [_serverSettingsConfig, "removevehweapons", []] call EPOCH_fnc_returnConfigEntry;
		if !(_removeweapons isequalto []) then {
			{
				_vehicle removeWeaponGlobal _x;
			} foreach _removeweapons;
		};
		//Remove restricted magazines
		private _removemagazinesturret = [_serverSettingsConfig, "removevehmagazinesturret", []] call EPOCH_fnc_returnConfigEntry;
		if !(_removemagazinesturret isequalto []) then {
			{
				_vehicle removeMagazinesTurret _x;
			} foreach _removemagazinesturret;
		};
		// Disable Termal Equipment
		private _disableVehicleTIE = [_serverSettingsConfig, "disableVehicleTIE", true] call EPOCH_fnc_returnConfigEntry;
		if (_disableVehicleTIE) then {
			_vehicle disableTIEquipment true;
		};

		// SAVE VEHICLE
		_vehicle call EPOCH_server_save_vehicle;

		// Event Handlers
		_vehicle call EPOCH_server_vehicleInit;

		// Add to A3 remains collector
		addToRemainsCollector[_vehicle];	

		_vehicle setVariable["VEHICLE_TEXTURE", _textures];

		// new Dynamicsimulation
		if([configFile >> "CfgEpochServer", "vehicleDynamicSimulationSystem", true] call EPOCH_fnc_returnConfigEntry)then
		{
			_vehicle enableSimulationGlobal false; // turn it off until activated by dynamicSim
			_vehicle enableDynamicSimulation true;
		};

		/*
			Functions specifice to VG - configure the vehicle now that it is added to the Epoch persistant vehicle system.
		*/
		_vehicle allowDamage true;
		// Restore vehicle fuel and damage
		_condition params ["_fuel","_damage","_hpd"];
		_vehicle setFuel _fuel;
		_vehicle setDamage _damage;
		_hpd params ["_hitpoints","_hpDamage"];
		{
//			_vehicle setHitPointDamage [_x, _hpDamage select _forEachIndex];
			_vehicle setHitIndex [_foreachindex, _hpDamage select _forEachIndex];
		} forEach _hitpoints;
		_vehicle allowDamage false;

		// Set Vehicle skins
		{
			_vehicle setObjectTextureGlobal [ _forEachIndex, format["%1",_textures select _forEachIndex] ];
		}forEach _textures;

		// Restore turret and pylon ammo
		[_vehicle,_loadout] call VGFE_fnc_setVehicleLoadout;

		// Restore any nickname information on license plate 
		_vehicle setVariable["GRG_nickName",_nickname,true];
		_vehicle setPlateNumber _nickname;

		// Setup vehicle inventory
		[_vehicle,_inventory] call EPOCH_server_cargoFill;
		
		_vehicle allowDamage true;

		private _moveIntoVehicle = getNumber(missionConfigFile >> "CfgVGFE" >> "movePlayerToDriver");
		private _lockOnRetrieval = getNumber(missionConfigFile >> "CfgVGFE" >> "lockOnRetrieval");
		//diag_log format["_fnc_retrieveVehicle: _moveIntoVehicle = %1 | _lockOnRetrieval = %2 | _vehicleLockState = %3",_moveIntoVehicle,_lockOnRetrieval,_vehicleLockState];
		if (_moveIntoVehicle == 1) then 
		{
			_vehicle setOwner (owner _player);
			[_player,_vehicle] remoteExec["moveInDriver", (owner _player)];
			_vehicle lock 0;
		} else {
			if (_lockOnRetrieval == 1) then 
			{
				_vehicle lock 2;
			} else {
				_vehicle lock _vehicleLockState;
			};
		};
	
		/* Vehicle successfully spawned, update the VG */
		_vgfe deleteAt _index;
		MyVGFE = _vgfe;
		(owner _player) publicvariableclient "MyVGFE";
		private _playerUID = getPlayerUID _player;

		/* pull this from configs */ 
		private _expiresAt = getNumber(missionConfigFile >> "CfgVGFE" >> "vgfeExpiresAt");
		["VGFE_DATA",_playerUID,_expiresAt,_vgfe] call EPOCH_fnc_server_hiveSETEX;
		private _displayName = getText(configFile >> "CfgVehicles" >> _className >> "displayName");
		private _m = format["%1 has been retrieved from the garage",_displayName];
		[_m] remoteExec["systemChat",owner _player];
		[_m] remoteExec["diag_log",owner _player];
		[_m,5] remoteExec["EPOCH_Message",owner _player];
		[_vehicle] remoteExec["VGFE_fnc_client_vehicleRetrieved",owner _player];
	} else {
		private _displayName = getText(configFile >> "CfgVehicles" >> _className >> "displayName");
		_m = format["Unable to retrieve %1 from the garage",_displayName];
		[_m] remoteExec["systemChat",owner _player];
		[_m] remoteExec["diag_log",owner _player];
		[_m] remoteExec["EPOCH_Message",owner _player];		
	};
} else {
	/*
		Insufficient slots to spawn permenant vehicle
	*/
	["Insufficient Room on Server to Retrieve Vehicle"] remoteExec["systemChat",owner _player];
	["Insufficient Room on Server to Retrieve Vehicle: Contact Server Owner",5] remoteExec["Epoch_Message",owner player];
	["Insufficient Room on Server to Retrieve Vehicle: Contact Server Owner"] remoteExec["diag_log",owner _player];
};

MyVGFEstate = 1;

