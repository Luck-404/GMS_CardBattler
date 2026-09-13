//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_GREENFLOW
// FUNCTION: Resolves Greenflow.
//           Fires 1 damage bolt for each Minion controlled by the caster.
//           Each bolt deals neutral damage to the selected target.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_greenflow(_stct_card,_ref_caster,_ref_target){

	//======================//
	//COUNT CASTER'S MINIONS//
	//======================//
	var _ct_bolts = ds_list_size(_ref_caster._list_minions);

	//==================//
	//NO MINIONS — FAIL//
	//==================//
	if (_ct_bolts <= 0){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"FAILED: NO MINIONS",
			undefined,
			c_red,
			_ref_caster.x,
			_ref_caster.y - 48
		);

		return;
	}

	//================//
	//FIRE BOLTS//
	//================//
	repeat (_ct_bolts){
		scr_battle_damage_target(_stct_card._val_card_magnitude,_ref_target);
	}
}