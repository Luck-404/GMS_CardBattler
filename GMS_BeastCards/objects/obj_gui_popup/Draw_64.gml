//===============================================================================//
//
// DRAW GUI: OBJ_GUI_POPUP
// FUNCTION: Draws a standard popup.
//
//           RANDOM uses the original supplied position.
//
//           CLEAN positions standard popups into an orderly list above their
//           associated anchor without converting them into scrolling popups.
//
//           CLEAN STACKING returns a repeated entry to the bottom of the list
//           and refreshes its lifetime.
//
//           All printout text uses FNT_GUI_SMALL.
//
//===============================================================================//

#region POSITION

//================//
//CLEAN POSITION//
//================//
if (_flag_clean_printout){

	//----------------//
//ANCHOR POSITION//
//----------------//
	var _val_anchor_x =
		_val_printout_anchor_x;

	var _val_anchor_y =
		_val_printout_anchor_y;

	if (instance_exists(_ref_printout_anchor)){

		_val_anchor_x =
			_ref_printout_anchor.x;

		_val_anchor_y =
			_ref_printout_anchor.y;
	}

	//----------------//
//FINAL POSITION//
//----------------//
	x = _val_anchor_x;

	y =
		_val_anchor_y -
		_val_printout_head_offset -
		_val_printout_push_offset;
}

#endregion

#region DRAW

//================//
//DISPLAY TEXT//
//================//
var _str_draw_text = _str_text;

if (_ct_printout_stack > 1 && _str_text != "DEFAULT"){

	_str_draw_text =
		string(_ct_printout_stack) +
		"x " +
		_str_text;
}

//================//
//POPUP ACTION//
//================//
switch (_str_type){

	case "TEXT":

		if (_str_draw_text != "DEFAULT"){

			draw_set_colour(_c_popup);
			draw_set_font(fnt_gui_small);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);

			draw_text(
				x,
				y,
				_str_draw_text
			);
		}

	break;

	case "ICON":

		if (_spr_icon != undefined){
			draw_sprite(_spr_icon,0,x,y);
		}

		if (_ct_printout_stack > 1){

			draw_set_colour(_c_popup);
			draw_set_font(fnt_gui_small);
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);

			draw_text(
				x + 14,
				y,
				string(_ct_printout_stack) + "x"
			);
		}

	break;

	case "DUAL":

		if (_str_draw_text != "DEFAULT"){

			draw_set_colour(_c_popup);
			draw_set_font(fnt_gui_small);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);

			draw_text(
				x,
				y,
				_str_draw_text
			);
		}

		if (_spr_icon != undefined){
			draw_sprite(
				_spr_icon,
				0,
				x,
				y - 15
			);
		}

	break;
}

//----------------//
//RESET DRAW STATE//
//----------------//
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

#endregion

#region LIFESPAN

//================//
//LIFESPAN//
//================//
if (_ct_life > 0){

	_ct_life--;

	if (_ct_life <= 0){
		instance_destroy();
	}
}

#endregion