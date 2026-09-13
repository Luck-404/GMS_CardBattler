//===============================================================================//
//
// SCRIPT: SCR_MINION_HEAL_ALL
// FUNCTION: Restores 1 HP to every damaged living Minion attached to the
//           supplied team's living Beasts.
//           Healing cannot exceed each Minion's Maximum HP.
//           Logs one summary when at least one Minion is healed.
//
// ARGUMENTS: _list_beasts is the team's living Beast list.
// RETURNS: The total HP restored across all Minions.
//
//===============================================================================//

function scr_minion_heal_all(_list_beasts){

	//--------------------//
	//VALIDATE BEAST LIST//
	//--------------------//
	if (!ds_exists(_list_beasts,ds_type_list)){
		return 0;
	}

	var _ct_minions_healed = 0;
	var _val_hp_restored = 0;
	var _str_team = "UNKNOWN";

	//================//
	//CHECK EACH BEAST//
	//================//
	for (var _it_beast = 0;_it_beast < ds_list_size(_list_beasts);_it_beast++){

		var _ref_beast = ds_list_find_value(
			_list_beasts,
			_it_beast
		);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		_str_team = string_upper(_ref_beast._str_team);

		//--------------------//
		//VALIDATE MINION LIST//
		//--------------------//
		if (!ds_exists(_ref_beast._list_minions,ds_type_list)){
			continue;
		}

		//-----------------//
		//CHECK EACH MINION//
		//-----------------//
		for (var _it_minion = 0;_it_minion < ds_list_size(_ref_beast._list_minions);_it_minion++){

			var _ref_minion = ds_list_find_value(
				_ref_beast._list_minions,
				_it_minion
			);

			if (!instance_exists(_ref_minion)){
				continue;
			}

			if (_ref_minion._val_cur_hp <= 0){
				continue;
			}

			if (_ref_minion._val_cur_hp >= _ref_minion._val_max_hp){
				continue;
			}

			//----------------//
			//STORE OLD HP//
			//----------------//
			var _val_old_hp = _ref_minion._val_cur_hp;

			//------------//
			//RESTORE 1 HP//
			//------------//
			_ref_minion._val_cur_hp = min(
				_ref_minion._val_cur_hp + 1,
				_ref_minion._val_max_hp
			);

			var _val_healed =
				_ref_minion._val_cur_hp -
				_val_old_hp;

			if (_val_healed <= 0){
				continue;
			}

			_ct_minions_healed++;
			_val_hp_restored += _val_healed;
		}
	}

	//================//
	//DEBUG HEALING//
	//================//
	if (_ct_minions_healed > 0){

		scr_debug_log(
			"MINIONS",
			"HEAL",
			undefined,
			_str_team +
			" MINIONS RESTORED HP" +
			" | MINIONS HEALED: " +
			string(_ct_minions_healed) +
			" | TOTAL HP: +" +
			string(_val_hp_restored),
			"BATTLE",
			"SCR_MINION_HEAL_ALL"
		);
	}

	return _val_hp_restored;
}