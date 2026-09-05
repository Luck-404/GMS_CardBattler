//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_CULTIVATE
// FUNCTION: Resolves Cultivate.
//           Permanently increases current HP, maximum HP, and Magnitude
//           of every Minion attached to the selected Beast.
//
//===============================================================================//

function scr_card_viridian_cultivate(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (
		!ds_exists(
			_ref_target._list_minions,
			ds_type_list
		)
	){
		return false;
	}

	//----------------//
	//GROW ALL MINIONS//
	//----------------//
	for (
		var _it_minion = 0;
		_it_minion < ds_list_size(_ref_target._list_minions);
		_it_minion++
	){

		var _ref_minion =
			ds_list_find_value(
				_ref_target._list_minions,
				_it_minion
			);

		if (!instance_exists(_ref_minion)){
			continue;
		}

		scr_grow_minion(
			_ref_minion,
			_stct_card._val_card_magnitude
		);
	}

	return true;
}