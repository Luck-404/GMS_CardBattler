//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOOD_FEUD
// FUNCTION: Applies Focus for 3 rounds.
//           Summons 1 random Vermilion Minion on the caster.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_blood_feud(_stct_card,_ref_caster,_ref_target){

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


	//========================//
	//SUMMON VERMILION MINION//
	//========================//
	scr_card_summon_focus_minion(
		_stct_card,
		_ref_caster,
		"VERMILION"
	);
}