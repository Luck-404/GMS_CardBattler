//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRY_PRISM_CAPTURE
// FUNCTION: Attempts to capture a living enemy battle Beast with a Prism.
//           Pays the Prism and Mana costs, logs the capture attempt and roll,
//           clones successful captures, adds them to the Party/Ranch, and
//           removes the captured enemy from active battle.
//
// ARGUMENTS: _stct_prism_item is the Inventory Prism struct being consumed.
//            _ref_target_beast is the living enemy Beast targeted for capture.
// RETURNS: True when the Beast is successfully captured; otherwise false.
//
//===============================================================================//

function scr_battle_try_prism_capture(_stct_prism_item,_ref_target_beast){

	#region VALIDATION

	//================//
	//VALIDATE PRISM//
	//================//
	if (!is_struct(_stct_prism_item)){
		return false;
	}

	var _stct_prism_info = scr_inventory_get_prism_info(
		_stct_prism_item._str_item_id
	);

	if (!is_struct(_stct_prism_info)){

		scr_debug_log(
			"BATTLE",
			"CAPTURE",
			undefined,
			"CAPTURE FAILED | REASON: INVALID PRISM" +
			" | ITEM ID: " + string(_stct_prism_item._str_item_id),
			"ERROR",
			"SCR_BATTLE_TRY_PRISM_CAPTURE"
		);

		audio_play_sound(snd_gui_error,0,false);
		scr_gui_spawn_popup_error("INVALID PRISM",60);

		return false;
	}

	//================//
	//VALIDATE TARGET//
	//================//
	if (!instance_exists(_ref_target_beast)){
		return false;
	}

	if (_ref_target_beast._str_team != "ENEMY"){

		audio_play_sound(snd_gui_error,0,false);
		scr_gui_spawn_popup_error("INVALID TARGET",60);

		return false;
	}

	if (
		_ref_target_beast._val_cur_hp <= 0 ||
		_ref_target_beast._str_list != "ALIVE"
	){

		audio_play_sound(snd_gui_error,0,false);
		scr_gui_spawn_popup_error("INVALID TARGET",60);

		return false;
	}

	//--------------//
	//VALIDATE UNIT//
	//--------------//
	if (!is_struct(_ref_target_beast._ref_unit)){

		scr_debug_log(
			"BATTLE",
			"CAPTURE",
			_ref_target_beast,
			"CAPTURE FAILED | REASON: TARGET HAS INVALID BEAST DATA",
			"ERROR",
			"SCR_BATTLE_TRY_PRISM_CAPTURE"
		);

		audio_play_sound(snd_gui_error,0,false);
		scr_gui_spawn_popup_error("INVALID TARGET",60);

		return false;
	}

	//================//
	//VALIDATE MANA//
	//================//
	if (obj_battle_player_controller._val_cur_mana < _stct_prism_info._val_mana_cost){

		scr_debug_log(
			"BATTLE",
			"CAPTURE",
			_ref_target_beast,
			"CAPTURE BLOCKED" +
			" | TARGET: " +
			string_upper(_ref_target_beast._ref_unit._str_beast_name) +
			" | REASON: NOT ENOUGH MANA" +
			" | REQUIRED: " +
			string(_stct_prism_info._val_mana_cost) +
			" | CURRENT: " +
			string(obj_battle_player_controller._val_cur_mana),
			"BATTLE",
			"SCR_BATTLE_TRY_PRISM_CAPTURE"
		);

		audio_play_sound(snd_gui_error,0,false);
		scr_gui_spawn_popup_error("NOT ENOUGH MANA",60);

		return false;
	}

	#endregion

	#region CAPTURE DATA

	//================//
	//TARGET DATA//
	//================//
	var _stct_target_unit = _ref_target_beast._ref_unit;

	var _str_beast_name = string_upper(
		_stct_target_unit._str_beast_name
	);

	var _val_beast_level = _stct_target_unit._val_beast_level;

	var _val_target_hp = _ref_target_beast._val_cur_hp;
	var _val_target_max_hp = _ref_target_beast._val_max_hp;

	//================//
	//CAPTURE CHANCE//
	//================//
	var _val_tame_chance = scr_battle_get_prism_tame_chance(
		_stct_prism_item._str_item_id,
		_ref_target_beast
	);

	//================//
	//MANA DATA//
	//================//
	var _val_mana_before = obj_battle_player_controller._val_cur_mana;

	#endregion

	#region CAPTURE COSTS

	//================//
	//CONSUME PRISM//
	//================//
	if (!scr_inventory_remove_item(_stct_prism_item,1)){

		scr_debug_log(
			"BATTLE",
			"CAPTURE",
			_ref_target_beast,
			"CAPTURE BLOCKED" +
			" | TARGET: " + _str_beast_name +
			" | REASON: PRISM NOT AVAILABLE" +
			" | PRISM: " +
			string_upper(_stct_prism_info._str_item_name),
			"BATTLE",
			"SCR_BATTLE_TRY_PRISM_CAPTURE"
		);

		audio_play_sound(snd_gui_error,0,false);
		scr_gui_spawn_popup_error("NO PRISM",60);

		return false;
	}

	//================//
	//SPEND MANA//
	//================//
	obj_battle_player_controller._val_cur_mana -= _stct_prism_info._val_mana_cost;

	var _val_mana_after = obj_battle_player_controller._val_cur_mana;

	#endregion

	#region CAPTURE ATTEMPT

	//================//
	//DEBUG ATTEMPT//
	//================//
	scr_debug_log(
		"BATTLE",
		"CAPTURE",
		_ref_target_beast,
		"CAPTURE ATTEMPT" +
		" | TARGET: " + _str_beast_name +
		" | LEVEL: " + string(_val_beast_level) +
		" | HP: " +
		string(_val_target_hp) +
		"/" +
		string(_val_target_max_hp) +
		" | PRISM: " +
		string_upper(_stct_prism_info._str_item_name) +
		" | CHANCE: " +
		string(_val_tame_chance) +
		"%" +
		" | GUARANTEED: " +
		(_stct_prism_info._flag_guaranteed ? "YES" : "NO") +
		" | MANA: " +
		string(_val_mana_before) +
		" -> " +
		string(_val_mana_after),
		"BATTLE",
		"SCR_BATTLE_TRY_PRISM_CAPTURE"
	);

	#endregion

	#region CAPTURE ROLL

	//================//
	//ROLL CAPTURE//
	//================//
	var _val_capture_roll = irandom_range(1,100);

	//================//
	//FAILED CAPTURE//
	//================//
	if (_val_capture_roll > _val_tame_chance){

		scr_debug_log(
			"BATTLE",
			"CAPTURE",
			_ref_target_beast,
			"CAPTURE FAILED" +
			" | TARGET: " + _str_beast_name +
			" | LEVEL: " + string(_val_beast_level) +
			" | PRISM: " +
			string_upper(_stct_prism_info._str_item_name) +
			" | ROLL: " +
			string(_val_capture_roll) +
			"/" +
			string(_val_tame_chance),
			"BATTLE",
			"SCR_BATTLE_TRY_PRISM_CAPTURE"
		);

		audio_play_sound(snd_battle_capture_fail,0,false);
		scr_gui_spawn_popup_error("BROKE FREE",60);

		return false;
	}

	#endregion

	#region CAPTURE BEAST

	//======================//
	//CLONE CAPTURED BEAST//
	//======================//
	var _stct_captured_beast = scr_battle_clone_beast_for_capture(
		_ref_target_beast
	);

	if (!is_struct(_stct_captured_beast)){

		scr_debug_log(
			"BATTLE",
			"CAPTURE",
			_ref_target_beast,
			"CAPTURE FAILED AFTER SUCCESSFUL ROLL" +
			" | TARGET: " + _str_beast_name +
			" | ROLL: " +
			string(_val_capture_roll) +
			"/" +
			string(_val_tame_chance) +
			" | REASON: CAPTURE CLONE FAILED",
			"ERROR",
			"SCR_BATTLE_TRY_PRISM_CAPTURE"
		);

		audio_play_sound(snd_battle_capture_fail,0,false);
		scr_gui_spawn_popup_error("CAPTURE FAILED",60);

		return false;
	}

	//======================//
	//ADD TO PARTY OR RANCH//
	//======================//
	var _flag_added = scr_party_add_beast(_stct_captured_beast);

	if (!_flag_added){

		scr_debug_log(
			"BATTLE",
			"CAPTURE",
			_ref_target_beast,
			"CAPTURE FAILED AFTER SUCCESSFUL ROLL" +
			" | TARGET: " + _str_beast_name +
			" | UID: " +
			string(_stct_captured_beast._uid_beast) +
			" | REASON: PARTY/RANCH ADD FAILED",
			"ERROR",
			"SCR_BATTLE_TRY_PRISM_CAPTURE"
		);

		audio_play_sound(snd_battle_capture_fail,0,false);
		scr_gui_spawn_popup_error("CAPTURE FAILED",60);

		return false;
	}

	//================//
	//GET DESTINATION//
	//================//
	var _str_destination = "UNKNOWN";

	if (
		ds_exists(global.list_player_party,ds_type_list) &&
		ds_list_find_index(
			global.list_player_party,
			_stct_captured_beast
		) != -1
	){
		_str_destination = "PARTY";
	}
	else if (
		ds_exists(global.list_player_ranch,ds_type_list) &&
		ds_list_find_index(
			global.list_player_ranch,
			_stct_captured_beast
		) != -1
	){
		_str_destination = "RANCH";
	}

	//========================//
	//REMOVE ENEMY FROM PLAY//
	//========================//
	scr_battle_mark_enemy_captured_as_dead(_ref_target_beast);

	#endregion

	#region DEBUG SUCCESS

	//================//
	//CAPTURE SUCCESS//
	//================//
	scr_debug_log(
		"BATTLE",
		"CAPTURE",
		_ref_target_beast,
		"CAPTURE SUCCESS" +
		" | TARGET: " + _str_beast_name +
		" | LEVEL: " + string(_val_beast_level) +
		" | PRISM: " +
		string_upper(_stct_prism_info._str_item_name) +
		" | ROLL: " +
		string(_val_capture_roll) +
		"/" +
		string(_val_tame_chance) +
		" | UID: " +
		string(_stct_captured_beast._uid_beast) +
		" | HP: " +
		string(_stct_captured_beast._val_beast_hp_cur) +
		"/" +
		string(_stct_captured_beast._val_beast_hp_max) +
		" | DESTINATION: " +
		_str_destination,
		"BATTLE",
		"SCR_BATTLE_TRY_PRISM_CAPTURE"
	);

	#endregion

	#region FEEDBACK

	//================//
	//CAPTURE POPUP//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"TAMED",
		undefined,
		c_lime,
		_ref_target_beast.x,
		_ref_target_beast.y - 48
	);

	//================//
	//CAPTURE AUDIO//
	//================//
	audio_play_sound(
		_ref_target_beast._ref_unit._snd_beast_cry,
		0,
		false
	);

	audio_play_sound(
		snd_battle_capture_success,
		0,
		false
	);

	#endregion

	return true;
}