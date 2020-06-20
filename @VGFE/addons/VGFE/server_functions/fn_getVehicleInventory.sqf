params["_vehicle"];
private "_inventory";
private _saveInventory = getNumber(missionConfigFile >> "CfgVGFE" >> "saveIventory");
if (_saveIventory) then {
	_inventory = [_vehicle] call EPOCH_server_CargoSave;
} else {
	_inventory = [];
};
_inventory