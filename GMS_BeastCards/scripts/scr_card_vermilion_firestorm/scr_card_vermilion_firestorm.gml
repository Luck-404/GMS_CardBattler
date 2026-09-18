//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FIRESTORM
// FUNCTION: Resolves Firestorm.
//           Begins Firestorm Weather for 5 rounds.
//
// ARGUMENTS: _stct_card is the Firestorm Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is unused for this Global Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_firestorm(_stct_card,_ref_caster,_ref_target){

	//======================//
	//BEGIN FIRESTORM WEATHER//
	//======================//
	scr_status_apply_weather(
		"FIRESTORM",
		5
	);
}