//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_FUNGAL_RECYCLING
// FUNCTION: Sacrifices the selected corpse when valid; otherwise sacrifices
//           10 caster HP. Then recovers a random exhausted Viridian Card.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected corpse or undefined.
// RETURNS: No value.
//
//===============================================================================//
function scr_card_viridian_fungal_recycling(_stct_card,_ref_caster,_ref_target){

	//===================//
	//PAY SACRIFICE COST//
	//===================//
	var _stct_sacrifice = scr_battle_sacrifice("CORPSE",_ref_target);

	if (!_stct_sacrifice._flag_success){
		scr_battle_sacrifice("HOST_HEALTH",_ref_caster,10);
	}

	//======================//
	//RECOVER VIRIDIAN CARD//
	//======================//
	var _ref_recovered = scr_battle_recover_random_exhausted_card("VIRIDIAN");

	if (instance_exists(_ref_recovered)){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"RECOVERED: " + string(_ref_recovered._ref_card._str_card_name),
			undefined,
			c_green,
			room_width * 0.5,
			room_height * 0.5
		);
	}
	else{

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"NO VIRIDIAN CARD TO RECOVER",
			undefined,
			c_ltgray,
			room_width * 0.5,
			room_height * 0.5
		);
	}
}
