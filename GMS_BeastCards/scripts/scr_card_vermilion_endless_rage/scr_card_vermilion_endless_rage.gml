//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_ENDLESS_RAGE
// FUNCTION: Sets the selected Beast to 5 Rage and applies Endless Rage
//           for 3 rounds.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_endless_rage(_stct_card,_ref_caster,_ref_target){

	if (_ref_target._val_cur_hp <= 0){
		return;
	}

	//================//
	//APPLY ENDLESS RAGE//
	//================//
	scr_status_apply_buff("ENDLESS_RAGE", _ref_target, _stct_card._val_card_magnitude, 3);

}