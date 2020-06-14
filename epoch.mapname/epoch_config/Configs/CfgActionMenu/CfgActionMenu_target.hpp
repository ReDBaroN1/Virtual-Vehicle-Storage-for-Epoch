/*
	Merge this with \epoch_config\Configs\CfgActionMenu_self\CfgActionMenu_target.hpp
*/
//  Virtual Garage / Hanger / Dock
class VGFE_GarageAtJammer 
{
	condition = "dyna_AtHome && dyna_cursorTargetType in (call EPOCH_JammerClasses) && (damage dyna_cursorTarget < 1) && (getNumber(missionConfigFile >> 'CfgVGFE' >> 'useDynamenu') == 0)";
	action = "['garage'] call VGFE_fnc_client_accessVehicleGarage";
	icon = "\A3\EditorPreviews_F_Exp\Data\CfgVehicles\Land_Addon_05_F.jpg";
	toolTip = "Access the Virtual Garage";
};
class VGFE_Hanger
{
	condition = "(dyna_cursorTargetType isEqualTo getText(missionConfigFile >> 'CfgVGFE' >> 'virtualHangerObject')) and (getNumber(missionConfigFile >> 'CfgVGFE' >> 'useDynamenu') == 0)";
	action = "['hanger'] call VGFE_fnc_client_accessVehicleGarage";
	icon = "\A3\EditorPreviews_F\Data\CfgVehicles\Land_Hangar_F.jpg";
	tooltip = "Access the Virtual Hanger";
};
class VGFE_Dock  
{
	condition = "(dyna_cursorTargetType isEqualTo getText(missionConfigFile >> 'CfgVGFE' >> 'virtualDockObject')) and (getNumber(missionConfigFile >> 'CfgVGFE' >> 'useDynamenu') == 0)";
	action = "['dock'] call VGFE_fnc_client_accessVehicleGarage";
	icon = "\A3\EditorPreviews_F_Destroyer\Data\CfgVehicles\Land_Destroyer_01_Boat_Rack_01_F.jpg";
	tooltip = "Access the Virtual Dock";
};