

/*

*/


private "_vehTypes";
switch (MyVFGFstorageMode) do 
{
	case "player": {_vehTypes = ["Car","Tank","Air","Ship"]};
	case "garage": {_vehTypes = ["Car","Tank","Air","Ship"]};
	case "hanger": {_vehTypes = ["Air"]};
	case "dock": {_vehTypes = ["Ship"]};
};
private _localVehicles = [_vehTypes,MyVFGFstorageMode] call VGFE_fnc_client_getLocalVehicles;

{
	ctrlShow[_x,false];
} forEach [1000,1005,1006,1007,1009,1600,1500,1501,2];

private _display = uiNamespace getVariable["VirtualGarageDialog",""];
private _ctrl = (_display displayCtrl 1001);
_ctrl ctrlSetText "LOADING";
for "_i" from 1 to 20 do 
{
	(_display displayCtrl 1008) progressSetPosition (_i/20);
	uiSleep 0.05;
	switch (_i) do 
	{
		case 4: {_ctrl ctrlSetText "LOADING .";};
		case 8: {_ctrl ctrlSetText "LOADING . .";};
		case 12: {_ctrl ctrlSetText "LOADING . . . ";};
		case 16: {_ctrl ctrlSetText "LOADING . . . .";};
		case 20: {_ctrl ctrlSetText "LOADED";};
	};
};

uiSleep 0.5;
_ctrl ctrlSetText "Select a Vehicle";

{
	ctrlShow[_x,true];
} forEach [1000,1005,1006,1007,1500,1501,2];

ctrlShow[1008,false];

/*
for "_i" from 1 to 10 do 
{
	private _ctrl = (_display displayCtrl 1500);
	private _index = lbAdd[1500,format["Stored Vehicle %1",_i]];
	_ctrl lbSetData[_index,format["_localVehicle%1",_i]];
	_ctrl lbSetTooltip[_index,"Select Vehicle To Retrieve"];
	_index = lbAdd[1501,format["Local Vehicle %1",_i]];
	private _ctrl2 = (_display displayCtrl 1501);
	_ctrl2 lbSetData[_index,format["_storedVehicle%1",_i]];
	_ctrl2 lbSetTooltip[_index,"Select Vehicle to Store"];
};
*/
private _ctrl = (_display displayCtrl 1500);
{
	_x params ["_key","_vehicleData"];
	diag_log format["_fnc_client_onVirtualGarageDialogLoad: _key = %1 | _vehicleData = %2",_key,_vehicleData];
	private _className = _vehicleData select 0;
	private _index = _ctrl lbAdd getText(configFile >> "CfgVehicles" >> _className >> "displayName");
	_ctrl lbSetValue [_index,_key];
	_ctrl lbSetTooltip [_index,"Select Vehicle To Retrive"];
} forEach MyVGFE;

private _ctrl2 = (_display displayCtrl 1501);
{
	private _index = _ctrl2 lbAdd getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
	_ctrl2 lbSetData[_index,netID _x];
	_ctrl2 lbSetTooltip[_index,"Select Vehicle to Store"];
} forEach _localVehicles;
MyVGFELocalVehicles = _localVehicles;
switch (MyVFGFstorageMode) do 
{
	case 'garage': {};
	case 'hanger': {
		//picture at 1200 
		// Title at 1005
		private _ctrl = (_display displayCtrl 1007);
		_ctrl ctrlSetText "Virtual Hanger Vehicle Storage";
		_ctrl = (_display displayCtrl 1200);
		_ctrl ctrlSetText "\A3\EditorPreviews_F\Data\CfgVehicles\Land_Hangar_F.jpg";
	};
	case 'dock': {
		private _ctrl = (_display displayCtrl 1007);
		_ctrl ctrlSetText "Virtual Dock Vehicle Storage";
		_ctrl = (_display displayCtrl 1200);
		_ctrl ctrlSetText "\A3\EditorPreviews_F_Destroyer\Data\CfgVehicles\Land_Destroyer_01_Boat_Rack_01_F.jpg";
	};
};
private _m = format["Dialog Opened, Populated and Ready for End User | MyVGFEkey = %1",MyVGFEkey];
systemChat _m;
diag_log _m;