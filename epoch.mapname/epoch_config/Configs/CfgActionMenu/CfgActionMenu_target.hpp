/*
	Merge this with \epoch_config\Configs\CfgActionMenu_self\CfgActionMenu_target.hpp
*/
//  Virtual Garage / Hanger / Dock
class VGFE_GarageAtJammer 
{
	condition = "dyna_AtHome && dyna_cursorTargetType in (call EPOCH_JammerClasses) && (damage dyna_cursorTarget < 1) && (getNumber(missionConfigFile >> 'CfgVGFE' >> 'useDynamenu') == 0)";
	action = "['jammer'] call VGFE_fnc_client_accessVehicleGarage";
	//icon = "\A3\EditorPreviews_F_Exp\Data\CfgVehicles\Land_Addon_05_F.jpg";
	icon = "\A3\Soft_F_Exp\Offroad_01\Data\UI\map_Offroad_01_gen_CA.paa";
	toolTip = "Access the Virtual Garage";
};
class VGFE_Hanger
{
	condition = "(dyna_cursorTargetType isEqualTo getText(missionConfigFile >> 'CfgVGFE' >> 'virtualHangerObject')) and (getNumber(missionConfigFile >> 'CfgVGFE' >> 'useDynamenu') == 0)";
	action = "['hanger'] call VGFE_fnc_client_accessVehicleGarage";
	icon = "\A3\Air_F_EPC\Plane_CAS_01\Data\UI\Map_Plane_CAS_01_CA.paa";
	tooltip = "Access the Virtual Hanger";
};
class VGFE_Dock  
{
	condition = "(dyna_cursorTargetType isEqualTo getText(missionConfigFile >> 'CfgVGFE' >> 'virtualDockObject')) and (getNumber(missionConfigFile >> 'CfgVGFE' >> 'useDynamenu') == 0)";
	action = "['dock'] call VGFE_fnc_client_accessVehicleGarage";
	icon = "\A3\boat_f\Boat_Armed_01\data\ui\map_boat_armed_01_minigun.paa";
	tooltip = "Access the Virtual Dock";
};
