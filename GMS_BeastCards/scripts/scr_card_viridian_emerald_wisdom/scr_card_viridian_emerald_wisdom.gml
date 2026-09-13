//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_EMERALD_WISDOM
// FUNCTION: Resolves Emerald Wisdom.
//           Applies the Draw 2 Buff for 3 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_emerald_wisdom(_stct_card,_ref_caster,_ref_target){

	//===================//
	//APPLY BUFF STATUS//
	//===================//
	scr_status_apply_buff("DRAW_2",0,3);
}