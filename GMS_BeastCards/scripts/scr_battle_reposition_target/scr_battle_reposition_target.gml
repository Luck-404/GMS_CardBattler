//===============================================================================//
//
// SCRIPT: scr_battle_reposition_target
// FUNCTION: Swaps the battlefield positions of two allied living Beasts.
//           Prevents movement if either Beast has a reposition-locking status.
//           Updates team order, position indexes, minions, and statuses.
//           Smoothly animates both Beasts between their battlefield positions.
//
//===============================================================================//

function scr_battle_reposition_target(_stct_card,_ref_caster,_ref_target,_flag_play_vfx=true,_flag_play_popup=true){

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
		scr_battle_can_reposition(
			_ref_caster
		);

	var _flag_target_can_reposition =
		scr_battle_can_reposition(
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

	//--------------------//
	//STORE OLD POSITIONS//
	//--------------------//
	var _val_caster_old_x =
		_ref_caster.x;

	var _val_target_old_x =
		_ref_target.x;

	//----------------//
	//SWAP X POSITION//
	//----------------//
	_ref_caster.x =
		_val_target_old_x;

	_ref_target.x =
		_val_caster_old_x;

	//------------------------//
	//ANIMATE REPOSITIONING//
	//------------------------//
	scr_battle_vfx_reposition(
		_ref_caster,
		_val_caster_old_x,
		8
	);

	scr_battle_vfx_reposition(
		_ref_target,
		_val_target_old_x,
		8
	);

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
	scr_minion_reposition(
		_ref_target
	);

	scr_status_reposition(
		_ref_target
	);

	scr_minion_reposition(
		_ref_caster
	);

	scr_status_reposition(
		_ref_caster
	);

	//----------------//
	//REPOSITION VFX//
	//----------------//
	if (_flag_play_vfx){

		scr_battle_vfx(
			_ref_caster,
			spr_battle_vfx_move_poof,
			undefined,
			undefined,
			0,
			0,
			1,
			0,
			snd_battle_sfx_move_poof
		);

		scr_battle_vfx(
			_ref_target,
			spr_battle_vfx_move_poof,
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
	}

	return true;
}