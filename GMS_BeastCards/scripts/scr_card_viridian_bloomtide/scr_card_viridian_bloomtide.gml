//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BLOOMTIDE
// FUNCTION: Resolves Bloomtide.
//           Applies the Bloomtide global Event.
//           Event presentation is handled by the Bloomtide status.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_bloomtide(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY BLOOMTIDE//
	//================//
	scr_status_apply_event(
		"BLOOMTIDE"
	);
}