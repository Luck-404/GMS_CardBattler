//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SNOWFALL
// FUNCTION: Resolves Snowfall.
//           Begins Snow Weather.
//           Weather presentation is owned by the Snow status.
//
//===============================================================================//

function scr_card_cerulean_snowfall(_stct_card,_ref_caster,_ref_target){

	//------------------//
	//BEGIN SNOW WEATHER//
	//------------------//
	scr_status_apply_weather(
		"SNOW"
	);
}