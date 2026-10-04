//===============================================================================//
//
// SCRIPT: SCR_GUI_DRAW_ITEM_BADGE
// FUNCTION: Draws a compact Item icon badge anchored by its bottom-right corner.
//           Uses a white interior, black border, and automatically scales the
//           supplied Item sprite to fit inside the badge.
//
// ARGUMENTS:
//           _spr_item   - Item sprite to display.
//           _val_right  - Right edge of the badge.
//           _val_bottom - Bottom edge of the badge.
//           _val_size   - Badge width/height.
//
// RETURNS: True when a badge is drawn; otherwise false.
//
//===============================================================================//

function scr_gui_draw_item_badge(_spr_item,_val_right,_val_bottom,_val_size=26){

	#region VALIDATION

	//================//
	//VALIDATE SPRITE//
	//================//
	if (_spr_item == undefined){
		return false;
	}

	#endregion

	#region LAYOUT

	//================//
	//BADGE BOUNDS//
	//================//
	var _val_left =
		_val_right -
		_val_size;

	var _val_top =
		_val_bottom -
		_val_size;

	var _val_center_x =
		(_val_left + _val_right) *
		0.5;

	var _val_center_y =
		(_val_top + _val_bottom) *
		0.5;

	#endregion

	#region BACKGROUND

	//================//
	//BLACK BORDER//
	//================//
	draw_set_alpha(1);
	draw_set_colour(c_black);

	draw_rectangle(
		_val_left,
		_val_top,
		_val_right,
		_val_bottom,
		false
	);

	//================//
	//WHITE INTERIOR//
	//================//
	draw_set_colour(c_white);

	draw_rectangle(
		_val_left + 2,
		_val_top + 2,
		_val_right - 2,
		_val_bottom - 2,
		false
	);

	#endregion

	#region ITEM

	//================//
	//FIT ITEM SPRITE//
	//================//
	var _val_sprite_w =
		max(
			1,
			sprite_get_width(
				_spr_item
			)
		);

	var _val_sprite_h =
		max(
			1,
			sprite_get_height(
				_spr_item
			)
		);

	var _val_icon_max =
		max(
			1,
			_val_size - 8
		);

	var _val_icon_scale =
		min(
			1,
			_val_icon_max /
			max(
				_val_sprite_w,
				_val_sprite_h
			)
		);

	//================//
	//DRAW ITEM//
	//================//
	draw_sprite_ext(
		_spr_item,
		0,
		_val_center_x,
		_val_center_y,
		_val_icon_scale,
		_val_icon_scale,
		0,
		c_white,
		1
	);

	#endregion

	#region RESET

	draw_set_alpha(1);
	draw_set_colour(c_white);

	#endregion

	return true;
}