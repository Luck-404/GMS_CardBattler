//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_THUNDERSTORM
// FUNCTION: Resolves Thunderstorm.
//           Begins Storming Weather.
//           Weather presentation is owned by the Storming status.
//
//===============================================================================//

function scr_card_cerulean_thunderstorm(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//BEGIN STORMING WEATHER//
	//----------------------//
	scr_status_apply_weather(
		"STORMING"
	);
}