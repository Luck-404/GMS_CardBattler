//===============================================================================//
//
// SCRIPT: SCR_STATUS_APPLY_ANCHOR_STONE_PASSIVE
// FUNCTION: Applies one Anchor Stone's source-bound Immovable Status
//           to every living allied Beast.
//
//===============================================================================//

function scr_status_apply_anchor_stone_passive(_ref_source_minion){

	//------------------------//
	//VALIDATE SOURCE MINION//
	//------------------------//
	if (!instance_exists(_ref_source_minion)){
		return false;
	}

	if (_ref_source_minion._val_cur_hp <= 0){
		return false;
	}

	//----------------//
	//GET ALLY LIST//
	//----------------//
	var _list_allies = (_ref_source_minion._str_team == "PLAYER") ? obj_battle_player_controller._list_beasts_alive : obj_battle_enemy_controller._list_beasts_alive;

	if (!ds_exists(_list_allies,ds_type_list)){
		return false;
	}

	var _flag_applied = false;

	//======================//
	//APPLY ANCHOR STONE//
	//======================//
	for (var _it_ally = 0;_it_ally < ds_list_size(_list_allies);_it_ally++){

		var _ref_ally = ds_list_find_value(_list_allies,_it_ally);

		if (!instance_exists(_ref_ally)){
			continue;
		}

		if (_ref_ally._val_cur_hp <= 0){
			continue;
		}

		//------------------------//
		//APPLY SOURCE-BOUND BUFF//
		//------------------------//
		var _ref_status = scr_status_buff_anchor_stone(
			"APPLY",
			undefined,
			_ref_source_minion,
			_ref_ally
		);

		if (_ref_status != undefined){
			_flag_applied = true;
		}
	}

	return _flag_applied;
}