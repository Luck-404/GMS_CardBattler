//===============================================================================//
//
// SCRIPT: SCR_PARTY_SET_LEVEL
// FUNCTION: Forces every Beast in the player's current Party to a given level.
//           Recalculates Maximum HP directly from HP stat and level.
//           Optionally fully heals each Beast afterward.
//
// ARGUMENTS: _val_level is the target level.
//            _flag_full_heal determines whether each Beast is fully healed.
// RETURNS: Number of Party Beasts successfully updated.
//
//===============================================================================//

function scr_party_set_level(_val_level,_flag_full_heal=true){

	//================//
	//VALIDATE PARTY//
	//================//
	if (
		!variable_global_exists("list_player_party") ||
		!ds_exists(global.list_player_party,ds_type_list)
	){
		return 0;
	}

	//================//
	//VALIDATE LEVEL//
	//================//
	var _val_target_level = clamp(floor(_val_level),1,30);
	var _ct_updated = 0;

	//================//
	//SET PARTY LEVEL//
	//================//
	for (var _it_beast = 0;_it_beast < ds_list_size(global.list_player_party);_it_beast++){

		var _stct_beast = ds_list_find_value(global.list_player_party,_it_beast);

		if (!is_struct(_stct_beast)){
			continue;
		}

		//----------------//
		//STORE OLD HP//
		//----------------//
		var _val_old_level = _stct_beast._val_beast_level;
		var _val_old_max_hp = max(1,_stct_beast._val_beast_hp_max);
		var _val_old_cur_hp = _stct_beast._val_beast_hp_cur;
		var _val_hp_ratio = clamp(_val_old_cur_hp / _val_old_max_hp,0,1);

		//================//
		//SET LEVEL//
		//================//
		_stct_beast._val_beast_level = _val_target_level;

		//================//
		//RECALCULATE HP//
		//================//
		var _val_new_max_hp = scr_beast_get_max_hp(
			_stct_beast._val_beast_hp_stat,
			_stct_beast._val_beast_level
		);

		_stct_beast._val_beast_hp_max = _val_new_max_hp;

		//================//
		//UPDATE CURRENT HP//
		//================//
		if (_flag_full_heal){
			_stct_beast._val_beast_hp_cur = _val_new_max_hp;
		}
		else{
			_stct_beast._val_beast_hp_cur = ceil(_val_new_max_hp * _val_hp_ratio);
			_stct_beast._val_beast_hp_cur = clamp(
				_stct_beast._val_beast_hp_cur,
				0,
				_val_new_max_hp
			);
		}

		_ct_updated++;

		//================//
		//DEBUG LEVEL SET//
		//================//
		scr_debug_log(
			"BEASTS",
			"LEVEL",
			undefined,
			string_upper(_stct_beast._str_beast_name) +
			" PARTY LEVEL SET" +
			" | LEVEL: " +
			string(_val_old_level) +
			" -> " +
			string(_stct_beast._val_beast_level) +
			" | HP: " +
			string(_val_old_cur_hp) +
			"/" +
			string(_val_old_max_hp) +
			" -> " +
			string(_stct_beast._val_beast_hp_cur) +
			"/" +
			string(_stct_beast._val_beast_hp_max) +
			" | HP STAT: " +
			string(_stct_beast._val_beast_hp_stat),
			"INFO",
			"SCR_PARTY_SET_LEVEL"
		);
	}

	return _ct_updated;
}