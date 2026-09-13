//===============================================================================//
//
// SCRIPT: SCR_BATTLE_HAS_TEAM_COMBATANTS
// FUNCTION: Returns whether a battle team has any living combatants remaining.
//           Both active and Banished Beasts count as living combatants for
//           battle-end detection.
//
// INPUT:    _str_team - Battle team being checked.
// USES:     Player or enemy complete Beast list and each Beast's battle state.
//
//===============================================================================//

function scr_battle_has_team_combatants(_str_team){

	#region TEAM DATA

	//---------------//
	//GET TEAM LIST//
	//---------------//
	var _list_beasts;

	if (_str_team == "PLAYER"){
		_list_beasts = obj_battle_player_controller._list_beasts;
	}
	else if (_str_team == "ENEMY"){
		_list_beasts = obj_battle_enemy_controller._list_beasts;
	}
	else{
		return false;
	}

	var _ct_beasts = ds_list_size(_list_beasts);

	#endregion

	#region COMBATANT CHECK

	//------------------//
	//CHECK COMBATANTS//
	//------------------//
	for (var _it_beast = 0; _it_beast < _ct_beasts; _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beasts,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._val_cur_hp <= 0){
			continue;
		}

		if (_ref_beast._str_list == "ALIVE" || _ref_beast._str_list == "BANISHED"){
			return true;
		}
	}

	#endregion

	return false;
}