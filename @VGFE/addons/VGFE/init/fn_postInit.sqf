diag_log "VGFE: post-Initialization for Virtual VehicleStorage for Epoch";

onPlayerConnected {}; // seems this is needed or addMissionEventHandler "PlayerConnected" does not work. as of A3 1.60
addMissionEventHandler ["PlayerConnected", 
{
    _this call VGFE_fnc_onPlayerJoined;
}];

diag_log "VGFE: post-initialization complete: Added onPlayerConnected event handler";

(["VGFE_TRIES", "tries"] call EPOCH_fnc_server_hiveGETRANGE) params [["_status",-1],["_tries",[-1]]];
diag_log format["VGFE: post-initialization: _tries = %1 | _status = %2",_tries,_status];
if (_status == 0) then 
{
    ["VGFE_TRIES","tries",5000000,[0]] call EPOCH_fnc_server_hiveSETEX;
};
if (_status == 1) then 
{
    ["VGFE_TRIES","tries",5000000,[1]] call EPOCH_fnc_server_hiveSETEX;
};
if (_status == -1) then 
{
    ["VGFE_TRIES","tries",5000000,[-1]] call EPOCH_fnc_server_hiveSETEX;
};
["VGFE_RANDOM","ITEMS",500,[random(365)]] call EPOCH_fnc_server_hiveSETEX;
