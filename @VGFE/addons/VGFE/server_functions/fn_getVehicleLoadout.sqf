


params["_vehicle"];
private _magazinesAmmoLoadout = magazinesAmmoFull _vehicle;
private _pylonAmmoAllowedRaw = _vehicle getCompatiblePylonMagazines 0;  // all pylon ammmo on vehicle
private _pylonammoallowed = [];
{
	{
		_pylonammoallowed pushBackUnique _x;
	} forEach _x;
} forEach _pylonAmmoAllowedRaw;

private _turretLoadout = [];
private _mags = magazinesAllTurrets _vehicle;
{ 
	_x params["_magazine","_turret","_rounds"];
	if !(_magazine in _pylonAmmoAllowed) then {_turretLoadout pushBack _x};	
} forEach _mags;
private _pylonnames = "true" configClasses (configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "pylons") apply {configName _x};
private _pylonLoadouts = [];
private _pylonMagazines = getPylonMagazines _vehicle;
{
	private _pylonWeapon = _pylonMagazines select _forEachIndex;
	private _pylonAmmoCount = _vehicle ammoOnPylon _x;
	_pylonLoadouts pushback [_x,_pylonWeapon,_pylonAmmoCount];
} forEach _pylonNames;
_loadout = [_turretLoadout,_pylonLoadouts];
_loadout