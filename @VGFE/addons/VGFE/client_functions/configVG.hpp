class VGFE_settings {
/**
	 * Do Players have to be on the Flag build rights to be able to access the garage? 1 = true 0 = false
	 */
	playerIsInFreqJammerGroup = 1;

	/**
	 * Should the player be moved in to the vehicle when it gets spawned? 1 = true 0 = false
	 * If you choose to move the player in to the vehicle on spawn set the VirtualGarage_VehicleSpawnState = 0
	 * Or the player will be locked in the vehicle and will whine in side chat for a admin like all players do
	 */
	MovePlayerIntoVehicleOnSpawn = 0;

	/**
	 * State the vehicle will spawn in 1 = locked 0 = unlocked
	 */
	VehicleLockedOnSpawn = 1;

	/**
	 * Should a 3d marker be added to the vehicle when it spawns to help players find the vehicle 1 = true 0 = false
	 */
	3DMarkerOnSpawn = 1;

	/**
	 * How long (in seconds) should the 3D marker stay
	 */
	3DMarkerTime = 20;

	/*
	 	Reapply Damage on vehicle spawn 1 = true 0 = false
	 */
	ReapplyDamage = 1;

	/*

	*/
	saveInventory = 1;

	/*

	*/
	saveWeaponsLoadouts = 1;

};