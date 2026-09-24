//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_INFERNO_ETERNAL
// FUNCTION: Applies a 5-round global ERUPTION threshold reduction.
//           Begins Heatwave Weather.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_inferno_eternal(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY GLOBAL BUFF//
	//================//
	var _ref_inferno = scr_status_apply_buff("INFERNO_ETERNAL", _ref_target, _stct_card._val_card_magnitude, 5);

	if (!instance_exists(_ref_inferno)){
		return;
	}

	//================//
	//BEGIN HEATWAVE//
	//================//
	scr_status_apply_weather(
		"HEATWAVE",
		5
	);
}