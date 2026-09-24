//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_RELENTLESS
// FUNCTION: Heals the caster for 10 HP.
//           Spending 5 Rage grants Exhaust prevention for 2 rounds.
//           Grants 1 Boost stack for 3 rounds regardless of Rage.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_relentless(_stct_card,_ref_caster,_ref_target){

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}

	//================//
	//HEAL CASTER//
	//================//
	scr_battle_heal_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_caster
	);
	
	//================//
	//CHECK RAGE//
	//================//
	var _ct_rage = 0;

	var _ref_rage = scr_status_check(
		"RAGE",
		_ref_caster
	);

	if (
		_ref_rage != -1 &&
		instance_exists(_ref_rage)
	){
		_ct_rage = _ref_rage._ct_status_stacks;
	}

	//================//
	//SPEND 5 RAGE//
	//================//
	if (_ct_rage >= 5){

		var _ct_rage_spent = scr_status_consume_rage(
			_ref_caster,
			5
		);

		if (_ct_rage_spent == 5){

			//=======================//
			//PREVENT CARD EXHAUST//
			//=======================//
			scr_status_apply_buff("RELENTLESS", _ref_caster, 1, 2);

		}
	}

	//================//
	//GAIN BOOST//
	//================//


	scr_status_apply_buff("BOOST", _ref_caster, 25, 3);

}