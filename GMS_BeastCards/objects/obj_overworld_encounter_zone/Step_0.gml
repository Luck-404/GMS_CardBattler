//===============================================================================//
//
// STEP: OBJ_OVERWORLD_ENCOUNTER_ZONE
// FUNCTION: Rolls random encounters while the player moves through the zone.
//           Stores battle-return state and logs successful grass encounters.
//           Generates plant-litter traversal effects.
//
//===============================================================================//

//================//
//VALIDATE PLAYER//
//================//
if (!instance_exists(obj_player)){
	exit;
}

if (!place_meeting(x,y,obj_player) || !obj_player._flag_player_moving){
	exit;
}

//================//
//ENCOUNTER ATTEMPT//
//================//
if (
	_ct_encounter_attempt_cooldown <= 0 &&
	!instance_exists(obj_battle_wait) &&
	!instance_exists(obj_battle_wait)
){

	var _val_encounter_roll = irandom_range(1,100);

	if (_val_encounter_roll <= _val_encounter_chance){

		//----------------//
		//SHOW FEEDBACK//
		//----------------//
		scr_gui_spawn_popup(
			"TEXT",
			"BATTLE TRIGGERED",
			undefined,
			c_black,
			obj_player.x,
			obj_player.y
		);

		//--------------------//
		//STORE SOURCE DETAILS//
		//--------------------//
		var _str_source_room = string_upper(room_get_name(room));
		var _val_source_x = round(obj_player.x);
		var _val_source_y = round(obj_player.y);

		//------------------//
		//STORE RETURN STATE//
		//------------------//
		global.val_last_player_x = obj_player.x;
		global.val_last_player_y = obj_player.y;

		global.rm_last_player = room;
		global.arr_last_enemy_pool = _arr_encounter_beasts;

		//----------------//
		//DEBUG BATTLE ENTRY//
		//----------------//
		scr_debug_log(
			"BATTLE",
			"ENTRY",
			obj_player,
			"PLAYER ENTERED BATTLE FROM " + _str_source_room +
			" (" + string(_val_source_x) + "," + string(_val_source_y) + ")" +
			" | TRIGGER: GRASS" +
			" | ENCOUNTER POOL: " + string(array_length(_arr_encounter_beasts)),
			"TRANSITION",
			"OBJ_OVERWORLD_ENCOUNTER_ZONE:STEP"
		);

		//----------------//
		//LOCK PLAYER//
		//----------------//
		scr_player_set_movement_state("STOP");

		obj_player.visible = false;

		//----------------//
		//START BATTLE//
		//----------------//
		audio_play_sound(snd_overworld_encounter_trigger,0,false);

		scr_transition_trigger(rm_battle);
	}

	_ct_encounter_attempt_cooldown = 30;
}
else if (_ct_encounter_attempt_cooldown > 0){
	_ct_encounter_attempt_cooldown--;
}

//================//
//PLANT LITTER FX//
//================//
if (_ct_scene_fx_litter_timer <= 0){

	_ct_scene_fx_litter_timer = 20;

	scr_overworld_spawn_vfx_plant_litter();
}
else{
	_ct_scene_fx_litter_timer--;
}