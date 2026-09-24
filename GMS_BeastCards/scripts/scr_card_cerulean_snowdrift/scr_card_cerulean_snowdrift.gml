//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SNOWDRIFT
// FUNCTION: Resolves Snowdrift.
//           Grants the caster Armor at the end of each round for 3 rounds.
//
// ARGUMENTS: _stct_card is the Snowdrift card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_snowdrift(_stct_card,_ref_caster,_ref_target){

	//======================//
	//APPLY ARMOR OVER TIME//
	//======================//
	scr_status_apply_buff("ARMOR_OVER_TIME", _ref_target, _stct_card._val_card_magnitude, 3);
}