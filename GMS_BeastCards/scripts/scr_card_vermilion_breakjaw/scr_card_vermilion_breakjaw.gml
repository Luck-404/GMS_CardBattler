//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BREAKJAW
// FUNCTION: Resolves Breakjaw.
//           Deals linear Physical damage to the selected target.
//           If the caster had at least 3 Rage when attacking,
//           Stuns the surviving target for 1 round.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_breakjaw(_stct_card,_ref_caster,_ref_target){

	//================//
	//CHECK 3 RAGE//
	//================//
	var _flag_rage_threshold = false;
	var _ref_rage = scr_status_check("RAGE",_ref_caster);

	if (
		_ref_rage != -1 &&
		instance_exists(_ref_rage) &&
		_ref_rage._ct_status_stacks >= 3
	){
		_flag_rage_threshold = true;
	}

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

	if (!instance_exists(_ref_target)){
		return;
	}

	if (_ref_target._val_cur_hp <= 0){
		return;
	}

	//================//
	//STUN AT 3 RAGE//
	//================//
	if (_flag_rage_threshold){

		scr_status_apply_cc("STUN", _ref_target, 1);

	}
}