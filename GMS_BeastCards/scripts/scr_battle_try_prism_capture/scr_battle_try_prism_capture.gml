//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRY_PRISM_CAPTURE
// FUNCTION: Attempts to capture a living enemy battle Beast with a Prism.
//           Pays the Prism and Mana costs, rolls the final tame chance,
//           clones successful captures, and removes them from active battle.
//
// INPUTS:   _stct_prism_item - Inventory Prism struct being consumed.
//           _ref_target_beast - Living enemy battle Beast targeted for capture.
// USES:     Prism data, player Mana, Inventory, Party/Ranch, capture helpers,
//           GUI feedback, and capture audio.
//
//===============================================================================//

function scr_battle_try_prism_capture(_stct_prism_item,_ref_target_beast){

	#region VALIDATION

	//----------------//
	//VALIDATE PRISM//
	//----------------//
	if (!is_struct(_stct_prism_item)){
		return false;
	}

	var _stct_prism_info = scr_inventory_get_prism_info(_stct_prism_item._str_item_id);

	if (!is_struct(_stct_prism_info)){
		audio_play_sound(snd_gui_error,0,false);
		scr_gui_spawn_popup_error("INVALID PRISM",60);
		return false;
	}

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target_beast)){
		return false;
	}

	if (_ref_target_beast._str_team != "ENEMY"){
		audio_play_sound(snd_gui_error,0,false);
		scr_gui_spawn_popup_error("INVALID TARGET",60);
		return false;
	}

	if (_ref_target_beast._val_cur_hp <= 0 || _ref_target_beast._str_list != "ALIVE"){
		audio_play_sound(snd_gui_error,0,false);
		scr_gui_spawn_popup_error("INVALID TARGET",60);
		return false;
	}

	//--------------//
	//VALIDATE MANA//
	//--------------//
	if (obj_battle_player_controller._val_cur_mana < _stct_prism_info._val_mana_cost){
		audio_play_sound(snd_gui_error,0,false);
		scr_gui_spawn_popup_error("NOT ENOUGH MANA",60);
		return false;
	}

	#endregion

	#region CAPTURE COSTS

	//---------------//
	//CONSUME PRISM//
	//---------------//
	if (!scr_inventory_remove_item(_stct_prism_item,1)){
		audio_play_sound(snd_gui_error,0,false);
		scr_gui_spawn_popup_error("NO PRISM",60);
		return false;
	}

	//----------//
	//SPEND MANA//
	//----------//
	obj_battle_player_controller._val_cur_mana -= _stct_prism_info._val_mana_cost;

	#endregion

	#region CAPTURE ROLL

	//-------------------//
	//ROLL TAME CHANCE//
	//-------------------//
	var _val_tame_chance = scr_battle_get_prism_tame_chance(_stct_prism_item._str_item_id,_ref_target_beast);
	var _val_capture_roll = irandom_range(1,100);

	if (_val_capture_roll > _val_tame_chance){
		audio_play_sound(snd_battle_capture_fail,0,false);
		scr_gui_spawn_popup_error("BROKE FREE",60);
		return false;
	}

	#endregion

	#region CAPTURE BEAST

	//--------------------//
	//CLONE CAPTURED BEAST//
	//--------------------//
	var _stct_captured_beast = scr_battle_clone_beast_for_capture(_ref_target_beast);

	if (!is_struct(_stct_captured_beast)){
		audio_play_sound(snd_battle_capture_fail,0,false);
		scr_gui_spawn_popup_error("CAPTURE FAILED",60);
		return false;
	}

	//----------------------//
	//ADD TO PARTY OR RANCH//
	//----------------------//
	scr_party_add_beast(_stct_captured_beast);

	//----------------------//
	//REMOVE ENEMY FROM PLAY//
	//----------------------//
	scr_battle_mark_enemy_captured_as_dead(_ref_target_beast);

	#endregion

	#region FEEDBACK

	//---------------//
	//CAPTURE POPUP//
	//---------------//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"TAMED",
		undefined,
		c_lime,
		_ref_target_beast.x,
		_ref_target_beast.y - 48
	);

	//--------------//
	//CAPTURE AUDIO//
	//--------------//
	audio_play_sound(_ref_target_beast._ref_unit._snd_beast_cry,0,false);
	audio_play_sound(snd_battle_capture_success,0,false);

	#endregion

	return true;
}