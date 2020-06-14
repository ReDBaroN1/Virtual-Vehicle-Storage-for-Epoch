



	VGFE_activeList = "";
    waituntil {typeof player in ['Epoch_Male_F','Epoch_Female_F']};
    waituntil {!isNil 'MyVGArray'};
    waituntil {uisleep 2; alive player};
	player addAction["VGFE","call VGFE_fnc_clientDisplayVirtualVehicleStorage.sqf"];