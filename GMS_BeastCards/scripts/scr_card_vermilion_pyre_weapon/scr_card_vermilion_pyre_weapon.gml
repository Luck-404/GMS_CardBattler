//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_PYRE_WEAPON
// FUNCTION: Applies Pyre Weapon to the selected Beast for 2 rounds.
//           Its Attacks apply 1 Burn to each affected enemy Beast.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_pyre_weapon(_stct_card,_ref_caster,_ref_target){

	if (_ref_target._val_cur_hp <= 0){
		return;
	}

	//================//
	//APPLY PYRE WEAPON//
	//================//
	scr_status_apply_buff("PYRE_WEAPON", _ref_target, 1, 2);

}