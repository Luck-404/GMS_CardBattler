//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_INSPIRATION
// FUNCTION: Resolves Inspiration.
//           Applies the Inspiration Buff for 3 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_uncolored_inspiration(_stct_card,_ref_caster,_ref_target){

	//===================//
	//APPLY BUFF STATUS//
	//===================//
	scr_status_apply_buff("INSPIRATION",0,3);
}