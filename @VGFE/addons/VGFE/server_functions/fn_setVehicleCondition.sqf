

params["_vehicle","_condition"];
_condition params ["_fuel","_damage","_hpd"];
_vehicle setFuel _fuel;
_vehicle setDamage _damage;
_hpd params ["_hitpoints","_hpDamage"];
{
	_vehicle setHitPointDamage [_x, _hpDamage select _forEachIndex];
} forEach _hitpoints;