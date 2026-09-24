//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BEASTIAL_WRATH
// FUNCTION: Resolves Beastial Wrath.
//
//           Damages two targets and Stuns the surviving primary target.
//
//           Normally targets the front two living enemy Beasts.
//           Under Taunt, the selected Taunter becomes the primary target,
//           and an adjacent Beast remains the secondary target.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_beastial_wrath(_stct_card,_ref_caster,_ref_target){

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
			"LINEAR",
			_ref_caster,
			_ref_front_target,
			_stct_card._val_card_magnitude,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);
	}

	//=========================//
	//DAMAGE SECONDARY TARGET//
	//=========================//
	if (instance_exists(_ref_second_target)){

		scr_battle_damage_target(
			"LINEAR",
			_ref_caster,
			_ref_second_target,
			_stct_card._val_card_magnitude,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);
	}

	//=====================//
	//STUN PRIMARY TARGET//
	//=====================//
	if (
		instance_exists(_ref_front_target) &&
		_ref_front_target._str_list == "ALIVE" &&
		_ref_front_target._val_cur_hp > 0
	){

		scr_status_apply_cc("STUN", _ref_front_target);

	}
}