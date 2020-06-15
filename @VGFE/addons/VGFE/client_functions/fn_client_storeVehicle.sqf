/*
	VGFE_fnc_client_storeVehicle 
	Copyright Ghostrider-GRG-
*/
//params["_ctrl"];
private _index = lbCurSel 1501;
private _netIDveh = lbData [1501,_index];
private _veh = objectFromNetId _netIDveh;
diag_log format["_fnc_client_storeVehicle: _index = %1 | _veh = %2 | MyVGFELocalVehicles select _index = %4 | MyMyVGFE = %3",_index,_veh,MyVGFE, MyVGFELocalVehicles select _index];
["store",[MyVGFE,MyVGFEkey,_veh,player]] remoteExec["VGFE_fnc_handleClientRequest",2];
closeDialog 0;
private _m = "VGFE_fnc_clientStoreVehicle called";
systemChat _m;
diag_log _m;