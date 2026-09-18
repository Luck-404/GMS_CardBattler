//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BURSTING_METEOR
// FUNCTION: Resolves Bursting Meteor.
//           Deals linear Magical damage to the selected target.
//           ERUPTION 5 attacks adjacent enemies for 5 MAG damage
//           and applies 2 Burn to each surviving target.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_bursting_meteor(_stct_card,_ref_caster,_ref_target){

	//================//
	//PRIMARY HIT//
	//================//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (_ref_target._val_cur_hp <= 0){
		return;
	}

	//================//
	//ERUPTION 5//
	//================//
	if (!scr_battle_trigger_eruption(_ref_target,5)){
		return;
	}

	//======================//
	//GET ADJACENT TARGETS//
	//======================//
	var _arr_targets = [
		scr_battle_get_left_target(_ref_target),
		scr_battle_get_right_target(_ref_target)
	];

	//===================//
	//ERUPTION ATTACKS//
	//===================//
	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_affected_target = _arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (_ref_affected_target._val_cur_hp <= 0){
			continue;
		}

		//================//
		//DEAL MAG DAMAGE//
		//================//
		scr_battle_damage_target(
			5,
			_ref_affected_target
		);

		//----------------//
		//VALIDATE TARGET//
		//----------------//
		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (_ref_affected_target._val_cur_hp <= 0){
			continue;
		}

		//================//
		//APPLY 2 BURN//
		//================//
		var _ref_original_target = global.ref_target_beast;

		global.ref_target_beast = _ref_affected_target;

		repeat (2){
			scr_status_apply_dot("BURN");
		}

		global.ref_target_beast = _ref_original_target;
	}
}