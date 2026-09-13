//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_GROWTH_SIGIL
// FUNCTION: Resolves Growth Sigil.
//           Begins Seedfall Weather.
//           Weather presentation is owned by the Seedfall status.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_growth_sigil(_stct_card,_ref_caster,_ref_target){

	//================//
	//BEGIN SEEDFALL//
	//================//
	scr_status_apply_weather("SEEDFALL");
}