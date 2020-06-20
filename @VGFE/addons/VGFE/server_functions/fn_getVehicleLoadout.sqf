/*
	VGFE_fnc_getVehicleLoadout 
	Copyright 2020 by Ghostrider-GRG-
*/
	
params["_vehicle"];
private "_loadout";
private _saveLoadout = getNumber(missionConfigFile >> "CfgVFGF" >> "saveIventory");
if (_saveLoadout == 1) then 
{
	private _turretLoadout = [];
	private _mags = magazinesAllTurrets _vehicle;
	private _pylonnames = "true" configClasses (configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "pylons") apply {configName _x};
	private _pylonLoadouts = [];
	private _pylonMagazines = getPylonMagazines _vehicle;
	{
		private _pylonWeapon = _pylonMagazines select _forEachIndex;
		private _pylonAmmoCount = _vehicle ammoOnPylon _x;
		_pylonLoadouts pushback [_x,_pylonWeapon,floor(_pylonAmmoCount/2)];
	} forEach _pylonNames;
	diag_log format["_fnc_getVehicleLoadout: _turretLoadout = %1",_turretLoadout];
	diag_log format["_fnc_getVehicleLoadout: _pylonLoadouts = ?%1",_pylonLoadouts];
	_loadout = [_turretLoadout,_pylonLoadouts];
} else {
	_loadout = [[],[]];
};
_loadout
