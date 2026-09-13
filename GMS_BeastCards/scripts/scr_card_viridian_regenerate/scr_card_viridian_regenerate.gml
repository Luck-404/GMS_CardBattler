//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_REGENERATE
// FUNCTION: Resolves Regenerate.
//           Applies Armor Over Time to the selected target.
//           Grants 8 Armor at the end of each turn for 5 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_regenerate(_stct_card,_ref_caster,_ref_target){

	//======================//
	//APPLY ARMOR OVER TIME//
	//======================//
	scr_status_apply_buff("ARMOR_OVER_TIME",8,5);
}