//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_MARKING_RUNE
// FUNCTION: Applies Focus for 3 rounds.
//           Summons 1 random Minion from all three color pools.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_uncolored_marking_rune(_stct_card,_ref_caster,_ref_target){

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


	//=====================//
	//SUMMON RANDOM MINION//
	//=====================//
	scr_card_summon_focus_minion(
		_stct_card,
		_ref_caster,
		"UNCOLORED"
	);
}