/*
	VGFE_fnc_client_setFocusOnStoredVehicleList 
	Copyright Ghostrider-GRG-
*/
params["_ctrl"];
private _display = uiNamespace getVariable["VirtualGarageDialog",""];
private _ctrl = (_display displayCtrl 1600);
_ctrl ctrlSetStructuredText parseText "RETRIEVE";
_ctrl ctrlSetToolTip "Press to Retrieve the Selected Vehicle";
_ctrl buttonSetAction "[] call VGFE_fnc_client_RetrieveVehicle;";
systemChat "Focus Set for Stored Vehicles List";