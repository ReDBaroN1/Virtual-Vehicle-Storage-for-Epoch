

params["_requestId","_payload"];
diag_log format["_fnc_handleClientRequest: _requestId = %1 | _payload = %2",_requestId,_payload];
switch (_requestID) do 
{
	case "store": {
		_payload call VGFE_fnc_storeVehicle;
	};
	case "retrieve": {
		_payload  call VGFE_fnc_retrieveVehicle;
	};
	case "nickname": {
		_payload call VGFE_fnc_setVehicleNickname;
	};
	case "test": {
		diag_log format["running with test payload = %1",_payload];
	};
};