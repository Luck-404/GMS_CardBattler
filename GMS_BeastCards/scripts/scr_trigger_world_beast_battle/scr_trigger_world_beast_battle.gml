//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_WORLD_BEAST_BATTLE
// FUNCTION: Starts a battle from a visible wild beast.
//           Guarantees the touched beast appears in enemy slot 0.
//           Rolls remaining enemies from the beast's home battle-zone pool.
//
//===============================================================================//

function scr_trigger_world_beast_battle(_ref_world_beast){

	if (!instance_exists(_ref_world_beast)){
		exit;
	}

	if (_ref_world_beast._ref_unit == undefined){
		exit;
	}

	var _arr_pool = [];

	if (instance_exists(_ref_world_beast._ref_home) && variable_instance_exists(_ref_world_beast._ref_home,"_arr_encounter_beasts")){
		_arr_pool = _ref_world_beast._ref_home._arr_encounter_beasts;
	}
	else{
		_arr_pool = [_ref_world_beast._ref_unit._str_beast_name];
	}

	global.val_last_player_x = obj_player.x;
	global.val_last_player_y = obj_player.y;
	global.rm_last_player = room;

	global.arr_last_enemy_pool = _arr_pool;
	global.stct_forced_enemy_unit = _ref_world_beast._ref_unit;

	audio_play_sound(snd_battle_trigger,0,false);
	
	scr_toggle_player_movement("STOP");

	obj_player.visible = false;

	scr_trigger_transition(rm_battle);
}