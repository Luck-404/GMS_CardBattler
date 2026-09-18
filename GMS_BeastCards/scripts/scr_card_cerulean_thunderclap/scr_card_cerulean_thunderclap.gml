//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_THUNDERCLAP
// FUNCTION: Resolves Thunderclap.
//           Deals linear Magical damage to the selected Beast and its immediate
//           adjacent allies, then triggers Stormstruck on each surviving Beast
//           as though it had acted.
//
// ARGUMENTS: _stct_card is the Thunderclap Card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_thunderclap(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATE TARGET//
	//================//
	if (!instance_exists(_ref_target)){
		return;
	}

	//=================//
	//GET AOE-3 TARGETS//
	//=================//
	var _arr_targets = [
		scr_battle_get_left_target(_ref_target),
		_ref_target,
		scr_battle_get_right_target(_ref_target)
	];

	//================//
	//DAMAGE TARGETS//
	//================//
	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_affected_target = _arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (
			_ref_affected_target._str_list != "ALIVE" ||
			_ref_affected_target._val_cur_hp <= 0
		){
			continue;
		}

		scr_battle_damage_target(_stct_card._val_card_magnitude,_ref_affected_target);
	}

	//=====================//
	//TRIGGER STORMSTRUCK//
	//=====================//
	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_affected_target = _arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (
			_ref_affected_target._str_list != "ALIVE" ||
			_ref_affected_target._val_cur_hp <= 0
		){
			continue;
		}

		scr_status_trigger_stormstruck_action(_ref_affected_target);
	}
}