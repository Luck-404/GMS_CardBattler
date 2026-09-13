//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_THUNDERSTORM
// FUNCTION: Resolves Thunderstorm.
//           Begins Storming Weather.
//           Weather presentation is owned by the Storming status.
//
// ARGUMENTS: _stct_card is the Thunderstorm card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_thunderstorm(_stct_card,_ref_caster,_ref_target){

	//======================//
	//BEGIN STORMING WEATHER//
	//======================//
	scr_status_apply_weather(
		"STORMING"
	);
}