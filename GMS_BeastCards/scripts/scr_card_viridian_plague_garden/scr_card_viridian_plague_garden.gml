//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PLAGUE_GARDEN
// FUNCTION: Resolves Plague Garden.
//           Applies a team-bound global Buff for 5 rounds.
//           Enemy Bleed, Poison, and Venom gains summon Sporelings.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_plague_garden(_stct_card,_ref_caster,_ref_target){

	//=====================//
	//APPLY PLAGUE GARDEN//
	//=====================//
	scr_status_apply_buff("PLAGUE_GARDEN",0,5);
}