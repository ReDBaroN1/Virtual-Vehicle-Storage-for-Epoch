/*
	VGFE_fnc_client_setFocusOnLocalVehicleList 
	Copyright 2020 by Ghostrider-GRG-
*/
params["_ctrl"];
_ctrl ctrlSetStructuredText parseText "STORE";
_ctrl ctrlSetToolTip "Press to Store the Selected Vehicle";
_ctrl buttonSetAction "[] call VGFE_fnc_client_StoreVehicle;";
//[] call VGFE_fnc_client_onLbSelChangedLocalVehicleList;
systemChat "Focus set for Local Vehicles List";