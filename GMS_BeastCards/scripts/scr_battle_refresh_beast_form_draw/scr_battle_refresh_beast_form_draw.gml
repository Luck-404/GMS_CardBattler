//===============================================================================//
//
// SCRIPT: SCR_REFRESH_BEAST_FORM_DRAW
// FUNCTION: Resolves temporary Beast transformation draw modifiers.
//           Resets the Beast to its normal tint and scale.
//           Frostform draws light blue.
//           Abyssal Form draws deep blue and 25% larger.
//           Abyssal Form takes visual priority if multiple forms are active.
//
//===============================================================================//

function scr_refresh_beast_form_draw(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return;
	}

	//----------------//
	//RESET DRAW STATE//
	//----------------//
	_ref_beast._c_beast_draw_tint =
		c_white;

	_ref_beast._val_beast_draw_scale_multiplier =
		1;

	//-----------//
	//FROSTFORM//
	//-----------//
	if (
		scr_status_check(
			"FROSTFORM",
			_ref_beast
		) != -1
	){

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
	if (
		scr_status_check(
			"ABYSSAL_FORM",
			_ref_beast
		) != -1
	){

		_ref_beast._c_beast_draw_tint =
			make_colour_rgb(
				40,
				75,
				170
			);

		_ref_beast._val_beast_draw_scale_multiplier =
			1.25;
	}
}