//===============================================================================//
//
// SCRIPT: SCR_REPOSITION_BEAST
// FUNCTION: Moves a living Beast forward or backward within its own team.
//           Negative movement moves toward the front.
//           Positive movement moves toward the back.
//           Stops at the front/back edge of the formation.
//           Respects statuses that prevent repositioning.
//
//===============================================================================//

function scr_reposition_beast(_ref_beast,_val_move_amount){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (_val_move_amount == 0){
		return false;
	}

	//----------------------//
	//CHECK MOVEMENT LOCK//
	//----------------------//
	if (!scr_can_reposition(_ref_beast)){

		scr_spawn_popup_scrolling(
			"TEXT",
			"CANNOT REPOSITION",
			undefined,
			c_maroon,
			_ref_beast.x,
			_ref_beast.y - 48
		);

		return false;
	}

	//--------------//
	//GET TEAM LIST//
	//--------------//
	var _list_team =
		undefined;

	if (_ref_beast._str_team == "PLAYER"){

		_list_team =
			obj_battle_player_controller
				._list_beasts_alive;
	}
	else if (_ref_beast._str_team == "ENEMY"){

		_list_team =
			obj_battle_enemy_controller
				._list_beasts_alive;
	}

	if (_list_team == undefined){
		return false;
	}

	//--------------------//
	//GET CURRENT POSITION//
	//--------------------//
	var _val_current_pos =
		ds_list_find_index(
			_list_team,
			_ref_beast
		);

	if (_val_current_pos == -1){
		return false;
	}

	//-------------------//
	//GET NEW POSITION//
	//-------------------//
	var _val_new_pos =
		clamp(
			_val_current_pos + _val_move_amount,
			0,
			ds_list_size(_list_team) - 1
		);

	if (_val_new_pos == _val_current_pos){
		return false;
	}

	//----------------//
	//GET SWAP TARGET//
	//----------------//
	var _ref_swap_target =
		ds_list_find_value(
			_list_team,
			_val_new_pos
		);

	if (!instance_exists(_ref_swap_target)){
		return false;
	}

	//----------------------//
	//CHECK OTHER BEAST LOCK//
	//----------------------//
	if (!scr_can_reposition(_ref_swap_target)){

		scr_spawn_popup_scrolling(
			"TEXT",
			"CANNOT REPOSITION",
			undefined,
			c_maroon,
			_ref_swap_target.x,
			_ref_swap_target.y - 48
		);

		return false;
	}

	//----------------//
	//SWAP X POSITION//
	//----------------//
	var _val_temp_x =
		_ref_beast.x;

	_ref_beast.x =
		_ref_swap_target.x;

	_ref_swap_target.x =
		_val_temp_x;

	//----------------//
	//SWAP TEAM ORDER//
	//----------------//
	ds_list_set(
		_list_team,
		_val_current_pos,
		_ref_swap_target
	);

	ds_list_set(
		_list_team,
		_val_new_pos,
		_ref_beast
	);

	//------------------//
	//UPDATE POSITIONS//
	//------------------//
	_ref_beast._val_pos =
		_val_new_pos;

	_ref_swap_target._val_pos =
		_val_current_pos;

	//----------------------//
	//REPOSITION ATTACHMENTS//
	//----------------------//
	scr_reposition_minions(
		_ref_beast
	);

	scr_reposition_statuses(
		_ref_beast
	);

	scr_reposition_minions(
		_ref_swap_target
	);

	scr_reposition_statuses(
		_ref_swap_target
	);

	return true;
}