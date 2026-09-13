//===============================================================================//
//
// SCRIPT: SCR_BATTLE_REPOSITION_TARGET
// FUNCTION: Swaps the battlefield positions of two allied living Beasts.
//           Prevents movement if either Beast has a reposition-locking effect.
//           Updates team order, position indexes, Minions, and Statuses,
//           then smoothly animates both Beasts between their positions.
//
// INPUTS:   _ref_beast_a - First allied battle Beast being repositioned.
//           _ref_beast_b - Second allied battle Beast being repositioned.
//           _flag_play_vfx - Whether reposition feedback VFX/SFX should play.
//           _flag_play_popup - Whether reposition notification popups should play.
// USES:     Team living-Beast lists, reposition eligibility, reposition VFX,
//           Minion positioning, Status positioning, and GUI feedback.
//
//===============================================================================//

function scr_battle_reposition_target(_ref_beast_a,_ref_beast_b,_flag_play_vfx=true,_flag_play_popup=true){

	#region VALIDATION

	//-----------------//
	//VALIDATE BEASTS//
	//-----------------//
	if (!instance_exists(_ref_beast_a) || !instance_exists(_ref_beast_b)){
		return false;
	}

	if (_ref_beast_a == _ref_beast_b){
		return false;
	}

	if (_ref_beast_a._str_team != _ref_beast_b._str_team){
		return false;
	}

	#endregion

	#region REPOSITION LOCKS

	//----------------------//
	//CHECK MOVEMENT LOCKS//
	//----------------------//
	var _flag_beast_a_can_reposition = scr_battle_can_reposition(_ref_beast_a);
	var _flag_beast_b_can_reposition = scr_battle_can_reposition(_ref_beast_b);

	if (!_flag_beast_a_can_reposition || !_flag_beast_b_can_reposition){

		if (!_flag_beast_a_can_reposition){

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"CANNOT REPOSITION",
				undefined,
				c_maroon,
				_ref_beast_a.x,
				_ref_beast_a.y - 48
			);
		}

		if (!_flag_beast_b_can_reposition){

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"CANNOT REPOSITION",
				undefined,
				c_maroon,
				_ref_beast_b.x,
				_ref_beast_b.y - 48
			);
		}

		//--------------------------//
		//DEBUG REPOSITION BLOCKED//
		//--------------------------//
		var _str_locked_beasts = "";

		if (!_flag_beast_a_can_reposition){
			_str_locked_beasts = string_upper(_ref_beast_a._ref_unit._str_beast_name);
		}

		if (!_flag_beast_b_can_reposition){

			if (_str_locked_beasts != ""){
				_str_locked_beasts += ", ";
			}

			_str_locked_beasts += string_upper(_ref_beast_b._ref_unit._str_beast_name);
		}

		scr_debug_log(
			"BATTLE",
			"REPOSITION",
			_ref_beast_a,
			string_upper(_ref_beast_a._str_team) +
			" POSITION SWAP BLOCKED" +
			" | " +
			string_upper(_ref_beast_a._ref_unit._str_beast_name) +
			" <-> " +
			string_upper(_ref_beast_b._ref_unit._str_beast_name) +
			" | LOCKED: " + _str_locked_beasts,
			"BATTLE",
			"SCR_BATTLE_REPOSITION_TARGET"
		);

		return false;

		return false;
	}

	#endregion

	#region TEAM DATA

	//--------------//
	//GET TEAM LIST//
	//--------------//
	var _list_team = undefined;

	if (_ref_beast_a._str_team == "PLAYER"){
		_list_team = obj_battle_player_controller._list_beasts_alive;
	}
	else if (_ref_beast_a._str_team == "ENEMY"){
		_list_team = obj_battle_enemy_controller._list_beasts_alive;
	}

	if (_list_team == undefined){
		return false;
	}

	//-------------------//
	//GET TEAM POSITIONS//
	//-------------------//
	var _val_beast_a_pos = ds_list_find_index(_list_team,_ref_beast_a);
	var _val_beast_b_pos = ds_list_find_index(_list_team,_ref_beast_b);

	if (_val_beast_a_pos == -1 || _val_beast_b_pos == -1){
		return false;
	}

	#endregion

	#region POSITION SWAP

	//--------------------//
	//STORE OLD POSITIONS//
	//--------------------//
	var _val_beast_a_old_x = _ref_beast_a.x;
	var _val_beast_b_old_x = _ref_beast_b.x;

	//----------------//
	//SWAP X POSITION//
	//----------------//
	_ref_beast_a.x = _val_beast_b_old_x;
	_ref_beast_b.x = _val_beast_a_old_x;

	//----------------------//
	//ANIMATE REPOSITIONING//
	//----------------------//
	scr_battle_vfx_reposition(_ref_beast_a,_val_beast_a_old_x,8);
	scr_battle_vfx_reposition(_ref_beast_b,_val_beast_b_old_x,8);

	//----------------//
	//SWAP TEAM ORDER//
	//----------------//
	ds_list_set(_list_team,_val_beast_a_pos,_ref_beast_b);
	ds_list_set(_list_team,_val_beast_b_pos,_ref_beast_a);

	//----------------//
	//UPDATE POSITIONS//
	//----------------//
	_ref_beast_a._val_pos = _val_beast_b_pos;
	_ref_beast_b._val_pos = _val_beast_a_pos;

	#endregion

	#region ATTACHMENTS

	//----------------------//
	//REPOSITION ATTACHMENTS//
	//----------------------//
	scr_minion_reposition(_ref_beast_a);
	scr_status_reposition(_ref_beast_a);

	scr_minion_reposition(_ref_beast_b);
	scr_status_reposition(_ref_beast_b);

	#endregion

	#region FEEDBACK

	//----------------//
	//REPOSITION VFX//
	//----------------//
	if (_flag_play_vfx){

		scr_battle_vfx(
			_ref_beast_a,
			spr_battle_vfx_reposition,
			undefined,
			undefined,
			0,
			0,
			1,
			0,
			snd_battle_reposition
		);

		scr_battle_vfx(
			_ref_beast_b,
			spr_battle_vfx_reposition,
			undefined,
			undefined,
			0,
			0,
			1,
			0,
			undefined
		);
	}

	//-------------//
	//SPAWN POPUPS//
	//-------------//
	if (_flag_play_popup){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"SWAPPED PLACES",
			undefined,
			c_black,
			_ref_beast_a.x + irandom_range(-32,32),
			_ref_beast_a.y - 24 + irandom_range(-32,32)
		);

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"SWAPPED PLACES",
			undefined,
			c_black,
			_ref_beast_b.x + irandom_range(-32,32),
			_ref_beast_b.y - 24 + irandom_range(-32,32)
		);
	}

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
	//LOG POSITION SWAP//
	//----------------//
	scr_debug_log(
		"BATTLE",
		"REPOSITION",
		_ref_beast_a,
		string_upper(_ref_beast_a._str_team) +
		" POSITION SWAP | " +
		string_upper(_ref_beast_a._ref_unit._str_beast_name) +
		": " +
		string(_val_beast_a_pos) +
		" -> " +
		string(_ref_beast_a._val_pos) +
		" | " +
		string_upper(_ref_beast_b._ref_unit._str_beast_name) +
		": " +
		string(_val_beast_b_pos) +
		" -> " +
		string(_ref_beast_b._val_pos) +
		" | SOURCE: " + _str_source,
		"BATTLE",
		"SCR_BATTLE_REPOSITION_TARGET"
	);

	#endregion

	return true;
}