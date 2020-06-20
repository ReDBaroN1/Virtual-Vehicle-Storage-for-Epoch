params["_vehicle","_condition"];

_vehicle allowDamage true;
diag_log format["_vehicle = %1 | _condition = %2",_vehicle,_condition];
_condition params["_fuel","_damage","_vehicleHitPoints"];
diag_log format["_fuel = %1 | _damage = %2 | _vehicleHitPoints = %3",_fuel,_damage,_vehicleHitPoints];
private _reapplyFuel = getNumber(missionConfigFile >> "CfgVGFE" >> "reapplyFuel");
if (_reapplyFuel == 1) then 
{
	_vehicle setFuel _fuel;
};

private _reapplyDamage = getNumber(missionConfigFile >> "CfgVGFE" >> "reapplyDamage"); 
if (_reapplyDamage == 1) then
{
	_vehicle setDamage _damage;
	{
		_vehicle setHitPointDamage [_x select 0, _x select 1];
	}forEach _vehicleHitPoints;
};
