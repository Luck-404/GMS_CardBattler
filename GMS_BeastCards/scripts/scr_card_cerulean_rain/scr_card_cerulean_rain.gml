//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_RAIN
// FUNCTION: Resolves Rain.
//           Begins Rain Weather.
//           Weather presentation is owned by the Rain status.
//
// ARGUMENTS: _stct_card is the Rain card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_rain(_stct_card,_ref_caster,_ref_target){

	//==================//
	//BEGIN RAIN WEATHER//
	//==================//
	scr_status_apply_weather(
		"RAIN"
	);
}