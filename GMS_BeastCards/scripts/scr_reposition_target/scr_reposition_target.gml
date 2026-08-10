//===============================================================================//
//
// SCRIPT: SCR_REPOSITION_TARGET
// FUNCTION: Swaps the battlefield positions of two allied living Beasts.
//           Prevents movement if either Beast has a reposition-locking status.
//           Updates team order, position indexes, minions, and statuses.
//
//===============================================================================//
function scr_reposition_target(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE BEASTS//
	//----------------//
	if (
		!instance_exists(_ref_caster) ||
		!instance_exists(_ref_target)
	){
		return false;
	}

	if (_ref_caster == _ref_target){
		return false;
	}

	if (_ref_caster._str_team != _ref_target._str_team){
		return false;
	}

	//----------------------//
	//CHECK MOVEMENT LOCKS//
	//----------------------//
	var _flag_caster_can_reposition =
		scr_can_reposition(
			_ref_caster
		);

	var _flag_target_can_reposition =
		scr_can_reposition(
			_ref_target
		);

	if (
		!_flag_caster_can_reposition ||
		!_flag_target_can_reposition
	){

		if (!_flag_caster_can_reposition){

			scr_spawn_popup_scrolling(
				"TEXT",
				"CANNOT REPOSITION",
				undefined,
				c_maroon,
				_ref_caster.x,
				_ref_caster.y - 48
			);
		}

		if (!_flag_target_can_reposition){

			scr_spawn_popup_scrolling(
				"TEXT",
				"CANNOT REPOSITION",
				undefined,
				c_maroon,
				_ref_target.x,
				_ref_target.y - 48
			);
		}

		return false;
	}

	//--------------//
	//GET TEAM LIST//
	//--------------//
	var _list_team =
		undefined;

	if (_ref_caster._str_team == "PLAYER"){

		_list_team =
			obj_battle_player_controller
				._list_beasts_alive;
	}
	else if (_ref_caster._str_team == "ENEMY"){

		_list_team =
			obj_battle_enemy_controller
				._list_beasts_alive;
	}

	if (_list_team == undefined){
		return false;
	}

	//-------------------//
	//GET TEAM POSITIONS//
	//-------------------//
	var _val_caster_pos =
		ds_list_find_index(
			_list_team,
			_ref_caster
		);

	var _val_target_pos =
		ds_list_find_index(
			_list_team,
			_ref_target
		);

	if (
		_val_caster_pos == -1 ||
		_val_target_pos == -1
	){
		return false;
	}

	//----------------//
	//SWAP X POSITION//
	//----------------//
	var _val_temp_x =
		_ref_caster.x;

	_ref_caster.x =
		_ref_target.x;

	_ref_target.x =
		_val_temp_x;

	//----------------//
	//SWAP TEAM ORDER//
	//----------------//
	ds_list_set(
		_list_team,
		_val_caster_pos,
		_ref_target
	);

	ds_list_set(
		_list_team,
		_val_target_pos,
		_ref_caster
	);

	//------------------//
	//UPDATE POSITIONS//
	//------------------//
	_ref_target._val_pos =
		_val_caster_pos;

	_ref_caster._val_pos =
		_val_target_pos;

	//----------------------//
	//REPOSITION ATTACHMENTS//
	//----------------------//
	scr_reposition_minions(
		_ref_target
	);

	scr_reposition_statuses(
		_ref_target
	);

	scr_reposition_minions(
		_ref_caster
	);

	scr_reposition_statuses(
		_ref_caster
	);

	//-------------//
	//SPAWN POPUPS//
	//-------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"SWAPPED PLACES",
		undefined,
		c_black,
		_ref_caster.x + irandom_range(-32,32),
		_ref_caster.y - 24 + irandom_range(-32,32)
	);

	scr_spawn_popup_scrolling(
		"TEXT",
		"SWAPPED PLACES",
		undefined,
		c_black,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);

	return true;
}