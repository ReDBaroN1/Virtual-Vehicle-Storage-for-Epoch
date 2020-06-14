


params["_ctrl"];
private _index = lbCurSel 1501;
private _key = lbValue [1501,_index];
// params["_index","_vgfe","_player"];
diag_log format["_fnc_client_retrieveVehicle: _key = %1 | MyVGFE = %2",_key,MyVGFE];
["retrieve",[MyVGFE,_key,player]] remoteExec["VGFE_fnc_handleClientRequest",2];
closeDialog 0;		
systemChat "VGFE_fnc_clientRetrieveVehicle Called";