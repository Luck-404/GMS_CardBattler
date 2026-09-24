//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CRASHING_WAVE
// FUNCTION: Resolves Crashing Wave.
//           Deals linear physical damage to the selected target
//           and its adjacent Beasts.
//
// ARGUMENTS: _stct_card is the Crashing Wave card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_crashing_wave(_stct_card,_ref_caster,_ref_target){

	//================//
	//GET ADJACENT BEASTS//
	//================//
	var _ref_left_target = scr_battle_get_left_target(_ref_target);
	var _ref_right_target = scr_battle_get_right_target(_ref_target);

	//================//
	//DAMAGE LEFT//
	//================//
	if (
		instance_exists(_ref_left_target) &&
		_ref_left_target._val_cur_hp > 0
	){
		scr_battle_damage_target(
			"LINEAR",
			_ref_caster,
			_ref_left_target,
			_stct_card._val_card_magnitude,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);
	}

	//================//
	//DAMAGE TARGET//
	//================//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){
		scr_battle_damage_target(
			"LINEAR",
			_ref_caster,
			_ref_target,
			_stct_card._val_card_magnitude,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);
	}

	//================//
	//DAMAGE RIGHT//
	//================//
	if (
		instance_exists(_ref_right_target) &&
		_ref_right_target._val_cur_hp > 0
	){
		scr_battle_damage_target(
			"LINEAR",
			_ref_caster,
			_ref_right_target,
			_stct_card._val_card_magnitude,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);
	}
}