//===============================================================================//
//
// SCRIPT: SCR_BATTLE_REPOSITION_BEAST
// FUNCTION: Moves a living Beast forward or backward within its own team.
//           Negative movement moves toward the front and positive movement
//           moves toward the back. Stops at formation edges and respects
//           reposition-locking effects on both involved Beasts.
//
// INPUTS:   _ref_beast - Battle Beast being repositioned.
//           _val_move_amount - Number of formation positions to move.
// USES:     Team living-Beast lists, reposition eligibility, reposition VFX,
//           Minion positioning, Status positioning, and GUI feedback.
//
//===============================================================================//

function scr_battle_reposition_beast(_ref_beast,_val_move_amount){

	#region VALIDATION

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (_val_move_amount == 0){
		return false;
	}

	//-------------------//
	//CHECK BEAST LOCK//
	//-------------------//
	if (!scr_battle_can_reposition(_ref_beast)){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"CANNOT REPOSITION",
			undefined,
			c_maroon,
			_ref_beast.x,
			_ref_beast.y - 48
		);
		
		//--------------------------//
		//DEBUG REPOSITION BLOCKED//
		//--------------------------//
		scr_debug_log(
			"BATTLE",
			"REPOSITION",
			_ref_beast,
			string_upper(_ref_beast._str_team) + " " +
			string_upper(_ref_beast._ref_unit._str_beast_name) +
			" COULD NOT REPOSITION" +
			" | POSITION: " + string(_ref_beast._val_pos) +
			" | REASON: REPOSITION LOCK",
			"BATTLE",
			"SCR_BATTLE_REPOSITION_BEAST"
		);
		
		return false;
	}

	#endregion

	#region TEAM DATA

	//--------------//
	//GET TEAM LIST//
	//--------------//
	var _list_team = undefined;

	if (_ref_beast._str_team == "PLAYER"){
		_list_team = obj_battle_player_controller._list_beasts_alive;
	}
	else if (_ref_beast._str_team == "ENEMY"){
		_list_team = obj_battle_enemy_controller._list_beasts_alive;
	}

	if (_list_team == undefined){
		return false;
	}

	var _ct_team = ds_list_size(_list_team);

	//--------------------//
	//GET CURRENT POSITION//
	//--------------------//
	var _val_current_pos = ds_list_find_index(_list_team,_ref_beast);

	if (_val_current_pos == -1){
		return false;
	}

	//----------------//
	//GET NEW POSITION//
	//----------------//
	var _val_new_pos = clamp(
		_val_current_pos + _val_move_amount,
		0,
		_ct_team - 1
	);

	if (_val_new_pos == _val_current_pos){
		return false;
	}

	#endregion

	#region SWAP TARGET

	//----------------//
	//GET SWAP TARGET//
	//----------------//
	var _ref_swap_target = ds_list_find_value(_list_team,_val_new_pos);

	if (!instance_exists(_ref_swap_target)){
		return false;
	}

	//-----------------------//
	//CHECK SWAP TARGET LOCK//
	//-----------------------//
	if (!scr_battle_can_reposition(_ref_swap_target)){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"CANNOT REPOSITION",
			undefined,
			c_maroon,
			_ref_swap_target.x,
			_ref_swap_target.y - 48
		);

		//--------------------------//
		//DEBUG REPOSITION BLOCKED//
		//--------------------------//
		scr_debug_log(
			"BATTLE",
			"REPOSITION",
			_ref_beast,
			string_upper(_ref_beast._str_team) + " " +
			string_upper(_ref_beast._ref_unit._str_beast_name) +
			" COULD NOT REPOSITION" +
			" | BLOCKED BY: " +
			string_upper(_ref_swap_target._ref_unit._str_beast_name) +
			" | REASON: REPOSITION LOCK",
			"BATTLE",
			"SCR_BATTLE_REPOSITION_BEAST"
		);

		return false;
	}

	#endregion

	#region POSITION SWAP

	//--------------------//
	//STORE OLD POSITIONS//
	//--------------------//
	var _val_beast_old_x = _ref_beast.x;
	var _val_swap_old_x = _ref_swap_target.x;

	//----------------//
	//SWAP X POSITION//
	//----------------//
	_ref_beast.x = _val_swap_old_x;
	_ref_swap_target.x = _val_beast_old_x;

	//----------------------//
	//ANIMATE REPOSITIONING//
	//----------------------//
	scr_battle_vfx_reposition(_ref_beast,_val_beast_old_x,8);
	scr_battle_vfx_reposition(_ref_swap_target,_val_swap_old_x,8);

	//----------------//
	//SWAP TEAM ORDER//
	//----------------//
	ds_list_set(_list_team,_val_current_pos,_ref_swap_target);
	ds_list_set(_list_team,_val_new_pos,_ref_beast);

	//----------------//
	//UPDATE POSITIONS//
	//----------------//
	_ref_beast._val_pos = _val_new_pos;
	_ref_swap_target._val_pos = _val_current_pos;

	#endregion

	#region REPOSITION STATUS TRIGGERS

	//-------------------------//
	//TRIGGER MOVED BEAST//
	//-------------------------//
	scr_status_trigger_reposition_effects(
		_ref_beast
	);

	//-------------------------//
	//TRIGGER SWAPPED BEAST//
	//-------------------------//
	scr_status_trigger_reposition_effects(
		_ref_swap_target
	);

	#endregion

	#region ATTACHMENTS

	//----------------------//
	//REPOSITION ATTACHMENTS//
	//----------------------//
	scr_minion_reposition(_ref_beast);
	scr_status_reposition(_ref_beast);

	scr_minion_reposition(_ref_swap_target);
	scr_status_reposition(_ref_swap_target);

	#endregion

	#region FEEDBACK

	//------------------//
	//REPOSITION VFX/SFX//
	//------------------//
	scr_battle_vfx(
		undefined,
		spr_battle_vfx_reposition,
		_ref_beast.x,
		_ref_beast.y,
		0,
		0,
		1,
		0,
		snd_battle_reposition
	);

	scr_battle_vfx(
		undefined,
		spr_battle_vfx_reposition,
		_ref_swap_target.x,
		_ref_swap_target.y,
		0,
		0,
		1,
		0,
		undefined
	);

	#endregion

	#region DEBUG

	//----------------//
	//GET SOURCE//
	//----------------//
	var _str_source = "SYSTEM";

	if (
		instance_exists(global.ref_cast_card) &&
		is_struct(global.ref_cast_card._ref_card)
	){
		_str_source = string_upper(global.ref_cast_card._ref_card._str_card_name);
	}

	//----------------//
	//GET DIRECTION//
	//----------------//
	var _str_direction = "BACKWARD";

	if (_val_new_pos < _val_current_pos){
		_str_direction = "FORWARD";
	}

	//----------------------//
	//LOG REPOSITION RESULT//
	//----------------------//
	scr_debug_log(
		"BATTLE",
		"REPOSITION",
		_ref_beast,
		string_upper(_ref_beast._str_team) + " " +
		string_upper(_ref_beast._ref_unit._str_beast_name) +
		" MOVED " + _str_direction +
		" | POSITION: " +
		string(_val_current_pos) +
		" -> " +
		string(_val_new_pos) +
		" | SWAPPED WITH: " +
		string_upper(_ref_swap_target._ref_unit._str_beast_name) +
		" | SOURCE: " + _str_source,
		"BATTLE",
		"SCR_BATTLE_REPOSITION_BEAST"
	);

	#endregion

	return true;
}