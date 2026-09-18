//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_AVALANCHE_STRIKE
// FUNCTION: Resolves Avalanche Strike.
//
//           Deals physical damage to two targets.
//           Normally hits the front two living enemy Beasts.
//           If Taunt redirects the primary target, hits the Taunter
//           and one adjacent Beast instead.
//
//===============================================================================//

function scr_card_cerulean_avalanche_strike(_stct_card,_ref_caster,_ref_target){

	//================//
	//GET FRONT TWO//
	//================//
	var _arr_targets = scr_battle_get_front_two_targets(_ref_target);

	var _ref_front_target =
		array_length(_arr_targets) > 0 ? _arr_targets[0] : undefined;

	var _ref_second_target =
		array_length(_arr_targets) > 1 ? _arr_targets[1] : undefined;

	//=======================//
	//DAMAGE PRIMARY TARGET//
	//=======================//
	if (instance_exists(_ref_front_target)){

		scr_battle_damage_target(
			_stct_card._val_card_magnitude,
			_ref_front_target
		);
	}

	//=========================//
	//DAMAGE SECONDARY TARGET//
	//=========================//
	if (instance_exists(_ref_second_target)){

		scr_battle_damage_target(
			_stct_card._val_card_magnitude,
			_ref_second_target
		);
	}
}