

params["_vehicle"];
//diag_log format["_fnc_client_vehicleRetrieved: _vehicle = %1",_vehicle];
VGFE_Vehicle = _vehicle;
_show3DMarker = getNumber (missionconfigfile >> "CfgVGFE" >> "use3Dmarker");
if(_show3DMarker == 1) then
{
	VGFE_show3Dicon = true;
	VGFE_3DmarkerDisplayTime = getNumber (missionconfigfile >> "CfgVGFE" >> "3DmarkerDisplayTime");
	VGFE_3DmarkerStartTime = diag_tickTime;
	_bbr = boundingBoxReal _vehicle;
	private _p1 = _bbr select 0;
	private _p2 = _bbr select 1;

	private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));	
	VGFE_pos = getPosATL _vehicle;
	VGFE_pos set[2, (VGFE_pos select 2) + _maxHeight];
	//diag_log format["_fnc_cleint_vehicleRetrieved: VGFE_pos = %1",VGFE_pos];
	VGVE_3DiconHandle = addMissionEventHandler ["Draw3D", {
		if (diag_tickTime - VGFE_3DmarkerStartTime > VGFE_3DmarkerDisplayTime) then {
			removeMissionEventHandler ["Draw3D", VGVE_3DiconHandle];
			VGFE_show3Dicon = false;
		};
		drawIcon3D ["\A3\ui_f\data\map\Markers\Military\arrow2_ca.paa", [0,0.8,0,1], VGFE_pos, 1, 1, 180, "Retrieved Vehicle", 1, 0.05];
	}];
};
