




params["_id","_uid","_name","_jip","_owner"];
diag_log format["_fnc_onPlayerJoined: _id = %1 | _uid = %2 | _name = %3 | _jip = %4 | _owner = %5 | time = %6",_id,_uid,_name,_jip,_owner,diag_tickTime];
["VGFE_PLAYER_NAME",_uid,_name] call EPOCH_fnc_server_hiveSET;
["VGFE_playerConnectLog",format["player UID %1 connected to VG at server time %2",_uid,diag_tickTime]] call EPOCH_fnc_server_hiveLog;
["VGFE_PLAYER_DAMAGE",_uid,20000,random(100)] call EPOCH_fnc_server_hiveSETEX;
["VGFE_PLAYER_LOGS",format["key1:%1",_uid],100000,random(365)] call EPOCH_fnc_server_hiveSETEX;

private _querry = (["VGFE_DATA", _uid] call EPOCH_fnc_server_hiveGETRANGE);
_querry params ["_status",["_vgfe",[]]];
diag_log format["_fnc_onPlayerJoined: _status = %1 | _vgfe = %2",_status,_vgfe];
if ((_querry select 0) == 1 && (_querry select 1) isEqualType []) then 
{
	/*  all good */
} else {
	/*  some sort of error occured */
	_vgfe = [];
};

diag_log format["_fnc_onPlayerJoined: HIVE queried for VGFE |_uid = %3 | status = %2 | _vgfe = %1 | isPlayer _owner %4",_vgfe,_status,_uid, _owner];

private _expiresAt = getNumber(missionConfigFile >> "CfgVGFE" >> "vgfeExpires");
if (_expiresAt == 0) then {_expiresAt = 1000000};
diag_log format["_fnc_onPlayerJoined: _expiresAt = %1",_expiresAt];

private _querry2 = (["VGFE_KEY",_uid] call EPOCH_fnc_server_hiveGETRANGE);
_querry2 params["_status",["_vgfeKeyArray",[0]]];
private "_vgfeKey";
diag_log format["_fnc_onPlayerJoined: _status = %1 |_querry2 = %2 | _vgfeKeyArray = %3",_status,_querry2,_vgfeKeyArray];
if (_status == 1 && _vgfeKeyArray isEqualType []) then 
{
	if (_vgfeKeyArray isEqualTo []) then 
	{
		_vgfeKey = 0;
		diag_log format["_fnc_onPlayerJoined: _vgfeKey | _vgfeKeyArray isEqualTo []"];
	} else {
	    _vgfeKey = _vgfeKeyArray select 0;
		diag_log format["_fnc_onPlayerJoined: _vgfeKey set to %1 | _vgfeKeyArray isEqualTo %2",_vgfeKey,_vgfeKeyArray];
	};

} else {
	_vgfeKey = 0;	
};
diag_log format["_fnc_onPlayerJoined: HIVE queried for _vgfeKey | isNil _vgfeKey = %3 | _status = %2 | _vgfeKey = %1",_vgfeKey,_status,isNil "_vgfeKey"];

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