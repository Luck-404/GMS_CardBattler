//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_PHOENIX_REBIRTH
// FUNCTION: Grants Phoenix Rebirth to the selected Beast for the remainder
//           of battle.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_phoenix_rebirth(_stct_card,_ref_caster,_ref_target){

	if (
		_ref_target._str_list != "ALIVE" ||
		_ref_target._val_cur_hp <= 0
	){
		return;
	}

	//=====================//
	//GRANT PHOENIX REBIRTH//
	//=====================//
	scr_status_apply_buff("PHOENIX_REBIRTH", _ref_target, _stct_card._val_card_magnitude);

}