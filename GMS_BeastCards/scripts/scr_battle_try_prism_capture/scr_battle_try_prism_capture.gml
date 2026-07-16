//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRY_PRISM_CAPTURE
// FUNCTION: Attempts to capture an enemy battle beast with a prism.
//           Spends mana, consumes one prism, rolls tame chance,
//           saves a cloned beast struct, and marks the enemy as dead on success.
//
//===============================================================================//

function scr_battle_try_prism_capture(_stct_prism_item,_ref_target_beast){

	if (_stct_prism_item == undefined){
		return false;
	}

	if (!instance_exists(_ref_target_beast)){
		return false;
	}

	if (_ref_target_beast._str_team != "ENEMY"){
		audio_play_sound(snd_error,0,false);
		scr_spawn_popup_error("INVALID TARGET",60);
		return false;
	}

	if (_ref_target_beast._val_cur_hp <= 0 || _ref_target_beast._str_list != "ALIVE"){
		audio_play_sound(snd_error,0,false);
		scr_spawn_popup_error("INVALID TARGET",60);
		return false;
	}

	var _stct_prism_info = scr_get_prism_info(_stct_prism_item._str_item_id);

	if (_stct_prism_info == undefined){
		audio_play_sound(snd_error,0,false);
		scr_spawn_popup_error("INVALID PRISM",60);
		return false;
	}

	if (obj_battle_player_controller._val_cur_mana < _stct_prism_info._val_mana_cost){
		audio_play_sound(snd_error,0,false);
		scr_spawn_popup_error("NOT ENOUGH MANA",60);
		return false;
	}

	//—------------------------------------------------------------------------------//
	// PAY COSTS
	//—------------------------------------------------------------------------------//
	if (!scr_remove_item_from_inventory(_stct_prism_item,1)){
		audio_play_sound(snd_error,0,false);
		scr_spawn_popup_error("NO PRISM",60);
		return false;
	}

	obj_battle_player_controller._val_cur_mana -= _stct_prism_info._val_mana_cost;

	//—------------------------------------------------------------------------------//
	// ROLL CAPTURE
	//—------------------------------------------------------------------------------//
	var _val_chance = scr_get_prism_tame_chance(_stct_prism_item._str_item_id,_ref_target_beast);
	var _val_roll = irandom_range(1,100);

	if (_val_roll > _val_chance){
		audio_play_sound(snd_tame_fail,0,false);
		scr_spawn_popup_error("BROKE FREE",60);

		return false;
	}

	//—------------------------------------------------------------------------------//
	// CLONE BEAST BEFORE ENEMY IS MARKED DEAD
	//—------------------------------------------------------------------------------//
	var _stct_captured_beast = scr_clone_beast_for_capture(_ref_target_beast);

	if (_stct_captured_beast == undefined){
		audio_play_sound(snd_tame_fail,0,false);
		scr_spawn_popup_error("CAPTURE FAILED",60);
		return false;
	}

	//—------------------------------------------------------------------------------//
	// ADD COPY TO PARTY OR RANCH
	//—------------------------------------------------------------------------------//
	scr_add_beast_to_party(_stct_captured_beast);

	//—------------------------------------------------------------------------------//
	// MARK ENEMY AS DEAD BUT DO NOT DESTROY IT
	//—------------------------------------------------------------------------------//
	scr_battle_mark_enemy_captured_as_dead(_ref_target_beast);

	scr_spawn_popup_scrolling(
		"TEXT",
		"TAMED",
		undefined,
		c_lime,
		_ref_target_beast.x,
		_ref_target_beast.y - 48
	);
	
	audio_play_sound(_ref_target_beast._ref_unit._snd_beast_cry,0,false);
		audio_play_sound(snd_tame_success,0,false);
	return true;
}