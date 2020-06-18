

params["_vehicle"];
VGFE_spawnVehicle = _vehicle;
_show3DMarker = getNumber (missionconfigfile >> "CfgVGFE" >> "use3Dmarker");
if(_show3DMarker == 1) then
{
	VGFE_show3Dicon = true;
	VGFE_3DmarkerDisplayTime = getNumber (missionconfigfile >> "CfgVGFE" >> "3DmarkerDisplayTime");
	VGFE_3DmarkerStartTime = diag_tickTime;
	VGVE_3DiconHandle = addMissionEventHandler ["Draw3D", {
		if (diag_tickTime - VGFE_3DmarkerStartTime > VGFE_3DmarkerDisplayTime) then {
			removeMissionEventHandler ["Draw3D", VGVE_3DiconHandle];
			VGFE_show3Dicon = false;
		};
		drawIcon3D ["targetIcon.paa", [1,1,1,1], getPosATL VGFE_spawnVehicle, 1, 1, 0];
	}];
};