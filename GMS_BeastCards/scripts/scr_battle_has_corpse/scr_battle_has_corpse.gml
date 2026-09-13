//===============================================================================//
//
// SCRIPT: SCR_BATTLE_HAS_CORPSE
// FUNCTION: Returns whether either battle graveyard contains at least one valid
//           unconsumed corpse.
//
// USES:     Player and enemy battle graveyard lists and Beast corpse state.
//
//===============================================================================//

function scr_battle_has_corpse(){

	#region GRAVEYARD DATA

	//---------------------//
	//GET GRAVEYARD LISTS//
	//---------------------//
	var _arr_graveyards = [
		obj_battle_player_controller._list_beasts_graveyard,
		obj_battle_enemy_controller._list_beasts_graveyard
	];

	#endregion

	#region CORPSE CHECK

	//------------------//
	//CHECK GRAVEYARDS//
	//------------------//
	for (var _it_graveyard = 0; _it_graveyard < array_length(_arr_graveyards); _it_graveyard++){

		var _list_graveyard = _arr_graveyards[_it_graveyard];
		var _ct_corpses = ds_list_size(_list_graveyard);

		for (var _it_corpse = 0; _it_corpse < _ct_corpses; _it_corpse++){

			var _ref_corpse = ds_list_find_value(_list_graveyard,_it_corpse);

			if (!instance_exists(_ref_corpse)){
				continue;
			}

			//------------------//
			//CHECK VALID CORPSE//
			//------------------//
			if (
				_ref_corpse._str_list == "DEAD" &&
				_ref_corpse._val_cur_hp <= 0 &&
				!_ref_corpse._flag_captured &&
				!_ref_corpse._flag_corpse_consumed
			){
				return true;
			}
		}
	}

	#endregion

	return false;
}