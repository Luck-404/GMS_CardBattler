//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_LURKING_VISIONS
// FUNCTION: Applies Focus for 3 rounds.
//           Summons 1 random Cerulean Minion on the caster.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_lurking_visions(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATE BEASTS//
	//================//
	if (
		!instance_exists(_ref_caster) ||
		!instance_exists(_ref_target)
	){
		return;
	}

	if (
		_ref_caster._val_cur_hp <= 0 ||
		_ref_target._val_cur_hp <= 0
	){
		return;
	}

	//================//
	//APPLY FOCUS//
	//================//
	scr_status_apply_debuff("FOCUS", _ref_target, 3);


	//=======================//
	//SUMMON CERULEAN MINION//
	//=======================//
	scr_card_summon_focus_minion(
		_stct_card,
		_ref_caster,
		"CERULEAN"
	);
}