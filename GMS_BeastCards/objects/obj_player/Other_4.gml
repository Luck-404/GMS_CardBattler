
//===============================================================================//
// ROOM START: OBJ_PLAYER
// FUNCTION: Initializes overworld room state and prevents encounters
//           for the first 180 frames after entering each room.
//===============================================================================//

if (room != rm_battle){

	//================//
	//OVERWORLD SETUP//
	//================//

	_flag_camera_created = false;

	scr_overworld_spawn_companion_beast();

	if (global.flag_game_just_started == true){
		global.flag_game_just_started = false;
		exit;	
	}

	//======================//
	//ROOM ENTRY BATTLE LOCK//
	//======================//
	if (!instance_exists(obj_battle_wait)){

		var _ref_encounter_wait = instance_create_layer(
			x,
			y,
			"ily_fx",
			obj_battle_wait
		);

		_ref_encounter_wait._ct_life = 180;
	}
}