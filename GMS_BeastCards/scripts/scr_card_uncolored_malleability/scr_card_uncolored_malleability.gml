//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_MALLEABILITY
// FUNCTION: Resolves Malleability.
//           Applies Malleability, causing the caster's next card to ignore
//           all caster requirements.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_uncolored_malleability(_stct_card,_ref_caster,_ref_target){

	//===================//
	//APPLY BUFF STATUS//
	//===================//
	scr_status_apply_buff("MALLEABILITY");
}