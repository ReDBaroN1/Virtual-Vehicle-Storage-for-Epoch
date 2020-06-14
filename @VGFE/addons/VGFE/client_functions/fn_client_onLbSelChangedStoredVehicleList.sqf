


private _display = uiNamespace getVariable["VirtualGarageDialog",""];	
private _ctrl = (_display displayCtrl 1500);
private _index = lbCurSel 1500;
systemChat format["_ctrl = %1 | _index = %2",_ctrl,_index];
private _veh = _ctrl lbData _index;  //  object
private _vehicleType = _ctrl lbText _index;  //  description based on classname
systemChat format["_veh = %1 | _vehType = %2",_veh,_vehType];
private _ctrlVehDescription = (_display displayCtrl 1001);
private _ctrlVehicleNickname = (_display displayCtrl 1009);
_ctrlVehDescription ctrlSetStructuredText parseText _vehicleType;
private _vgSlot = MyVGFE select _index;
_vgSlot params["_key","_vehicleData"];
_vehicleData params ["_className","_location","_condition","_inventory","_textures","_loadout","_nickname","_vehicleLockState"];
private _picture = getText(configFile >> "CfgVehicles" >> _className >> "editorPreview");
private _ctrl = (_display displayCtrl 1200);  // Where we display pictures of things
_ctrl ctrlSetText _picture;		
_ctrlVehicleNickname ctrlSetText format["Plate: %1",_nickname];
if!(VGFE_activeList isEqualTo "retrieve") then
{
	VGFE_activeList = "retrieve";
	private _ctrl = (_display displayCtrl 1600);
	_ctrl ctrlSetText "RETRIEVE";
	_ctrl ctrlSetToolTip "Press to Retrieve the Selected Vehicle";
	_ctrl buttonSetAction "[] call VGFE_fnc_client_RetrieveVehicle;";
	systemChat "Focus Set for Stored Vehicles List";
	{
		ctrlShow[_x,true];
	} forEach [1009,1600];
};