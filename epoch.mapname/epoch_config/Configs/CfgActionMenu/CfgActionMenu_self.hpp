/*
	Merge this with \epoch_config\Configs\CfgActionMenu_self\CfgActionMenu_self.hpp
*/
//  Virtual Garage / Hanger / Dock
class VGFE_Garage
{
	condition = "dyna_AtHome && (getNumber(missionConfigFile >> 'CfgVGFE' >> 'useDynamenu') == 0)";
	action = "['jammer'] call VGFE_fnc_client_accessVehicleGarage";
	icon = "\A3\Soft_F_Exp\Offroad_01\Data\UI\map_Offroad_01_gen_CA.paa";
	toolTip = "Access the Virtual Garage";
};
