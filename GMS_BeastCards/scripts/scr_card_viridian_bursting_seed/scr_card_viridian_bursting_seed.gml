//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BURSTING_SEED
// FUNCTION: Resolves Bursting Seed.
//           Applies Armorbreak for 2 rounds and Vulnerable for 1 round.
//           METABOLIZE 3 consumes exactly 3 Poison to increase both
//           Status durations by 1 round.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_bursting_seed(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//SET LIFETIMES//
	//================//
	var _val_armorbreak_lifetime = 2;
	var _val_vulnerable_lifetime = 1;

	//================//
	//CHECK POISON//
	//================//
	var _ref_poison = scr_status_check(
		"POISON",
		_ref_target
	);

	if (
		_ref_poison != -1 &&
		instance_exists(_ref_poison) &&
		_ref_poison._ct_status_stacks >= 3
	){

		//================//
		//METABOLIZE 3//
		//================//
		var _ct_poison_consumed = scr_battle_trigger_metabolize(
			_ref_target,
			3
		);

		if (_ct_poison_consumed == 3){
			_val_armorbreak_lifetime += 1;
			_val_vulnerable_lifetime += 1;
		}
	}

	//================//
	//APPLY ARMORBREAK//
	//================//
	scr_status_apply_debuff(
		"ARMORBREAK",
		_val_armorbreak_lifetime
	);

	//================//
	//APPLY VULNERABLE//
	//================//
	scr_status_apply_debuff(
		"VULNERABLE",
		_val_vulnerable_lifetime
	);
}