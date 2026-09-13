//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_TRIGGER_WILD_BEAST_BATTLE
// FUNCTION: Starts a battle from a visible wild Beast.
//           Guarantees the touched Beast appears in enemy slot 0.
//           Stores return state and logs the visible-wild encounter source.
//
// ARGUMENTS: _ref_world_beast is the visible wild Beast initiating combat.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_overworld_trigger_wild_beast_battle(_ref_world_beast){

	//================//
	//VALIDATE BEAST//
	//================//
	if (!instance_exists(_ref_world_beast)){
		return;
	}

	if (!is_struct(_ref_world_beast._stct_unit)){
		return;
	}

	if (!instance_exists(obj_player)){
		return;
	}

	//================//
	//GET ENCOUNTER POOL//
	//================//
	var _arr_pool = [];

	if (
		instance_exists(_ref_world_beast._ref_home) &&
		variable_instance_exists(_ref_world_beast._ref_home,"_arr_encounter_beasts")
	){
		_arr_pool = _ref_world_beast._ref_home._arr_encounter_beasts;
	}
	else{
		_arr_pool = [_ref_world_beast._stct_unit._str_beast_name];
	}

	//================//
	//STORE SOURCE DATA//
	//================//
	var _str_source_room = string_upper(room_get_name(room));
	var _val_source_x = round(obj_player.x);
	var _val_source_y = round(obj_player.y);

	var _str_beast_name = string_upper(_ref_world_beast._stct_unit._str_beast_name);
	var _val_beast_level = _ref_world_beast._stct_unit._val_beast_level;

	//================//
	//STORE BATTLE STATE//
	//================//
	global.val_last_player_x = obj_player.x;
	global.val_last_player_y = obj_player.y;

	global.rm_last_player = room;

	global.arr_last_enemy_pool = _arr_pool;
	global.stct_forced_enemy_unit = _ref_world_beast._stct_unit;

	//================//
	//DEBUG BATTLE ENTRY//
	//================//
	scr_debug_log(
		"BATTLE",
		"ENTRY",
		_ref_world_beast,
		"PLAYER ENTERED BATTLE FROM " + _str_source_room +
		" (" + string(_val_source_x) + "," + string(_val_source_y) + ")" +
		" | TRIGGER: VISIBLE WILD" +
		" | FORCED ENEMY: " + _str_beast_name +
		" (LVL " + string(_val_beast_level) + ")",
		"TRANSITION",
		"SCR_OVERWORLD_TRIGGER_WILD_BEAST_BATTLE"
	);

	//================//
	//LOCK PLAYER//
	//================//
	scr_player_set_movement_state("STOP");

	obj_player.visible = false;

	//================//
	//START BATTLE//
	//================//
	audio_play_sound(snd_overworld_encounter_trigger,0,false);

	scr_transition_trigger(rm_battle);
}