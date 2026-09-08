//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_GROWTH_SIGIL
// FUNCTION: Resolves Growth Sigil.
//           Begins Seedfall Weather.
//           Weather presentation is owned by the Seedfall status.
//
//===============================================================================//

function scr_card_viridian_growth_sigil(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//BEGIN SEEDFALL//
	//----------------//
	scr_status_apply_weather("SEEDFALL");
}