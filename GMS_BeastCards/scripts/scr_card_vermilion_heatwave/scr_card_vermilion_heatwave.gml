//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_HEATWAVE
// FUNCTION: Resolves Heatwave.
//           Begins Heatwave Weather for 5 rounds.
//
// ARGUMENTS: _stct_card is the Heatwave Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is unused for this Global Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_heatwave(_stct_card,_ref_caster,_ref_target){

	//======================//
	//BEGIN HEATWAVE WEATHER//
	//======================//
	scr_status_apply_weather("HEATWAVE",5);
}