//===============================================================================//
//
// SCRIPT: SCR_BATTLE_HAS_CORPSE
// FUNCTION: Returns whether either battle graveyard contains
//           at least one valid unconsumed corpse.
//
//===============================================================================//

function scr_battle_has_corpse(){

	//----------------------//
	//CHECK PLAYER CORPSES//
	//----------------------//
	var _list_player_graveyard =
		obj_battle_player_controller._list_beasts_graveyard;

	for (
		var _it_corpse = 0;
		_it_corpse < ds_list_size(_list_player_graveyard);
		_it_corpse++
	){

		var _ref_corpse =
			ds_list_find_value(
				_list_player_graveyard,
				_it_corpse
			);

		if (!instance_exists(_ref_corpse)){
			continue;
		}

		if (
			_ref_corpse._str_list == "DEAD" &&
			_ref_corpse._val_cur_hp <= 0 &&
			!_ref_corpse._flag_captured &&
			!_ref_corpse._flag_corpse_consumed
		){
			return true;
		}
	}

	//---------------------//
	//CHECK ENEMY CORPSES//
	//---------------------//
	var _list_enemy_graveyard =
		obj_battle_enemy_controller._list_beasts_graveyard;

	for (
		var _it_corpse = 0;
		_it_corpse < ds_list_size(_list_enemy_graveyard);
		_it_corpse++
	){

		var _ref_corpse =
			ds_list_find_value(
				_list_enemy_graveyard,
				_it_corpse
			);

		if (!instance_exists(_ref_corpse)){
			continue;
		}

		if (
			_ref_corpse._str_list == "DEAD" &&
			_ref_corpse._val_cur_hp <= 0 &&
			!_ref_corpse._flag_captured &&
			!_ref_corpse._flag_corpse_consumed
		){
			return true;
		}
	}

	return false;
}