/*
	VGFE_fnc_client_onLbSelChangedLocalVehicleList 
	Copyright Ghostrider-GRG-
*/
private _display = uiNamespace getVariable["VirtualGarageDialog",""];	
private _ctrl = (_display displayCtrl 1501);
private _index = lbCurSel 1501;
systemChat format["_ctrl = %1 | _index = %2",_ctrl,_index];
private _netID = _ctrl lbData _index;  //  object
private _className = typeOf (objectFromNetId _netId);  //  description based on classname
systemChat format["_veh = %1 | _vehType = %2",_veh,_vehType];
private _ctrlVehDescription = (_display displayCtrl 1001);
private _ctrlVehicleNickname = (_display displayCtrl 1009);
_ctrlVehDescription ctrlSetStructuredText parseText getText(conifgFile >> "CfgVehicles" >> _className >> "displayName");
_ctrlVehicleNickname ctrlSetText format["Plate: %1",getPlateNumber(objectFromNetId _netID)];
private _picture = getText(configFile >> "CfgVehicles" >> _className >> "editorPreview");
private _ctrl = (_display displayCtrl 1200);  // Where we display pictures of things
_ctrl ctrlSetText _picture;		
if !(VGFE_activeList isEqualTo "local") then 
{
	VGFE_activeList = "local";
	private _ctrl = (_display displayCtrl 1600);
	_ctrl ctrlSetText "STORE";
	_ctrl ctrlSetToolTip "Press to Store the Selected Vehicle";
	_ctrl buttonSetAction "[] call VGFE_fnc_client_StoreVehicle;";
	//systemChat "Focus set for Local Vehicles List";
	{
		ctrlShow[_x,true];					
	} forEach [1009,1600];
};