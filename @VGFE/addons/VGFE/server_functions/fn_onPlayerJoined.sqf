




params["_id","_uid","_name","_jip","_owner"];
["VGFE_logs","key1",100,random(365)] call EPOCH_fnc_server_hiveSETEX;
(["VGFE_DATA", _uid] call EPOCH_fnc_server_hiveGETRANGE) params ["_status",["_vgfe",-1]];
diag_log format["_fnc_onPlayerJoined: HIVE queried for VGFE |_uid = %3 | status = %2 | _vgfe = %1",_vgfe,_status,_uid];
private _expiresAt = getNumber(missionConfigFile >> "CfgVGFE" >> "vgfeExpires");
if (_expiresAt == 0) then {_expiresAt = 1000000};
diag_log format["_fnc_onPlayerJoined: _expiresAt = %1",_expiresAt];
if (_status == 1) then 
{
	_vgfe = [];
	["VGFE_DATA", _uid, _expiresAt, _vgfe] call EPOCH_fnc_server_hiveSETEX;	
	diag_log format["_fnc_onPlayerJoined: HIVE updated for _vgfe | _uid = %1 | _vgfe %2",_uid,_vgfe];
};
(["VGFE_KEY",_uid] call EPOCH_fnc_server_hiveGETRANGE) params ["_status",["_vgfeKey",[-1]]];
diag_log format["_fnc_onPlayerJoined: HIVE queried for _vgfeKey | _status = %2 | _vgfeKey = %1",_vgfeKey,_status];
if (_status == 1 && _vgfe isEqualType []) then 
{
	_vgfeKey = 0;
	["VGFE_KEY",_uid,_expiresAt,[_vgfeKey]] call EPOCH_fnc_server_hiveSETEX;
	diag_log format["_fnc_onPlayerJoined: HIVE updated for VGFEkey | _uid %1 | _key %2",_uid,_vgfeKey];
};
MyVGFE = _vgfe;
MyVGFEkey = _vgfeKey;
MyVGFEstate = 1;
diag_log format["<Initialized VGFE_Server for player named %1 | uid %2 at time %3 | MyVGFE %4 | MyVGFEkey %5",_name,_uid,diag_tickTime,MyVGFE,MyVGFEkey];

/*
**EPOCH_fnc_server_hiveLog**

Removes the specified key.

_Uses Hive Call: **700**_

_Input: Key Prefix, Message_

_Returns: Nothing_

```
// get reference to player and get playerUID to use as unique key
_playerUID = getPlayerUID _playerObject;

// Log to database, This data can be access via the database and can be found with the key "MyCustomLog-LOG"
['MyCustomLog', format["%1 (%2) at %3", _playerObject, _playerUID, getPosATL _playerObject]] call EPOCH_fnc_server_hiveLog;
*/
["VGFE_playerConnectLog",format["player UID %1 connected to VG at server time %2",_uid,diag_tickTime]] call EPOCH_fnc_server_hiveLog;

{
	_owner publicVariableClient _x;
} forEach [
	 "MyVGFE",
	 "MyVGFEkey",
	"VGFE_fnc_client_getLocalVehicles",
	//"VGFE_fnc_clientonMouseExitLocalVehiclesList",
	//"VGFE_fnc_clientGetLocalVehicles",
	"VGFE_fnc_client_getNearbyJammers",
	"VGFE_fnc_client_isBuildOwner",
	"VGFE_fnc_client_onLbSelChangedLocalVehicleList",
	"VGFE_fnc_client_onLbSelChangedStoredVehicleList",
	"VGFE_fnc_client_setFocusOnLocalVehicleList",
	"VGFE_fnc_client_setFocusOnStoredVehicleList",
	"VGFE_fnc_client_storeVehicle",
    "VGFE_fnc_client_displayVirtualVehicleStorage",
	"VGFE_fnc_client_init",
	"VGFE_fnc_client_log",
	"VGFE_fnc_client_retrieveVehicle",
	"VGFE_fnc_client_onVirtualGarageDialogLoad",
	"VGFE_fnc_client_accessVehicleGarage"
];