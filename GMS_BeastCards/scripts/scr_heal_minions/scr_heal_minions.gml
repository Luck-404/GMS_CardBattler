//===============================================================================//
//
// SCRIPT: SCR_HEAL_MINIONS
// FUNCTION: Restores 1 HP to every living Minion attached to the supplied
//           team's living Beasts.
//           Healing cannot exceed the Minion's maximum HP.
//
//===============================================================================//
function scr_heal_minions(_list_beasts){

	if (_list_beasts == undefined){
		return;
	}

	//----------------//
	//CHECK EACH BEAST//
	//----------------//
	for (
		var _it_beast = 0;
		_it_beast < ds_list_size(_list_beasts);
		_it_beast++
	){

		var _ref_beast =
			ds_list_find_value(
				_list_beasts,
				_it_beast
			);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		//-----------------//
		//CHECK EACH MINION//
		//-----------------//
		for (
			var _it_minion = 0;
			_it_minion < ds_list_size(_ref_beast._list_minions);
			_it_minion++
		){

			var _ref_minion =
				ds_list_find_value(
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

			//------------//
			//RESTORE 1 HP//
			//------------//
			_ref_minion._val_cur_hp =
				min(
					_ref_minion._val_cur_hp + 1,
					_ref_minion._val_max_hp
				);
		}
	}
}