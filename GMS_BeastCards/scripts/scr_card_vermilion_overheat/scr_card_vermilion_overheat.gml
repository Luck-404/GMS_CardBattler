//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_OVERHEAT
// FUNCTION: Resolves Overheat.
//           Deals linear Magical damage.
//           Grants the caster 1 Rage.
//           If the caster then has at least 3 Rage, applies 2 Burn.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_overheat(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);

	//================//
	//GAIN 1 RAGE//
	//================//
	var _ref_rage = scr_status_gain_rage(
		_ref_caster,
		1
	);

	if (!instance_exists(_ref_target)){
		return;
	}

	if (_ref_target._val_cur_hp <= 0){
		return;
	}

	//================//
	//CHECK 3 RAGE//
	//================//
	if (
		!instance_exists(_ref_rage) ||
		_ref_rage._ct_status_stacks < 3
	){
		return;
	}

	//================//
	//APPLY 2 BURN//
	//================//


	repeat (2){
		scr_status_apply_dot("BURN", _ref_target);
	}

}