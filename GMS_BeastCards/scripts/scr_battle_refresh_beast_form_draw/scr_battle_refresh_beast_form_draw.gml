//===============================================================================//
//
// SCRIPT: SCR_BATTLE_REFRESH_BEAST_FORM_DRAW
// FUNCTION: Refreshes temporary Beast transformation draw modifiers.
//           Resets the Beast to its default tint and scale, then applies
//           Frostform or Abyssal Form visual changes.
//           Abyssal Form takes priority when multiple forms are active.
//
// INPUT:    _ref_beast - Battle Beast whose draw state is being refreshed.
//
//===============================================================================//

function scr_battle_refresh_beast_form_draw(_ref_beast){

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return;
	}

	//----------------//
	//RESET DRAW STATE//
	//----------------//
	_ref_beast._c_beast_draw_tint = c_white;
	_ref_beast._val_beast_draw_scale_multiplier = 1;

	//-----------//
	//FROSTFORM//
	//-----------//
	if (scr_status_check("FROSTFORM",_ref_beast) != -1){

		_ref_beast._c_beast_draw_tint =
			make_colour_rgb(
				160,
				220,
				255
			);
	}

	//--------------//
	//ABYSSAL FORM//
	//--------------//
	if (scr_status_check("ABYSSAL_FORM",_ref_beast) != -1){

		_ref_beast._c_beast_draw_tint =
			make_colour_rgb(
				40,
				75,
				170
			);

		_ref_beast._val_beast_draw_scale_multiplier = 1.25;
	}
}