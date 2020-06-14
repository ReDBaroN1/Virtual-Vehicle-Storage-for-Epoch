


params["_ctrl"];
private _display = uiNamespace getVariable["VirtualGarageDialog",""];
private _ctrl = (_display displayCtrl 1500);
private _index = lbCurSel 1500;
private _key = lbValue [1500,_index];
diag_log format["_fnc_client_retrieveVehicle: _index = %3 | _key = %1 | MyVGFE = %2",_key,MyVGFE,_index];
["retrieve",[MyVGFE,_key,player]] remoteExec["VGFE_fnc_handleClientRequest",2];
closeDialog 0;		
systemChat "VGFE_fnc_clientRetrieveVehicle Called";