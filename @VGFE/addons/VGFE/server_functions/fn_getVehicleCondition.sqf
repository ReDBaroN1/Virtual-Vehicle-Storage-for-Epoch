
params["_vehicle"];
private _hpd = getAllHitPointsDamage _vehicle;
private _condition = [fuel _vehicle, damage _vehicle, [_hpd select 0, _hpd select 2]];
_condition