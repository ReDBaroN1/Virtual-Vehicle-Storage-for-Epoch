/*
	Merge this with \epoch_config\Configs\CfgActionMenu_self\CfgActionMenu_self.hpp
*/
//  Virtual Garage / Hanger / Dock
class VGFE_Garage
{
	condition = "dyna_AtHome and (getNumber(missionConfigFile >> 'CfgVGFE' >> 'useDynamenu') == 0)";
	action = "['player'] call VGFE_fnc_client_accessVehicleGarage";
	icon = "\A3\EditorPreviews_F_Exp\Data\CfgVehicles\Land_Addon_05_F.jpg";
	toolTip = "Access the Virtual Garage";
};