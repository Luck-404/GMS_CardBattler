//===============================================================================//
//
// DRAW GUI END: OBJ_GUI_WORLD_EVENT_BANNER
// FUNCTION: Draws a three-line World Event announcement/status banner.
//
//===============================================================================//

//================//
//HUD VISIBILITY//
//================//
var _ref_world_event_controller =
	scr_world_event_get_controller();

if (
	instance_exists(_ref_world_event_controller) &&
	variable_instance_exists(_ref_world_event_controller,"_flag_world_event_gui_visible") &&
	!_ref_world_event_controller._flag_world_event_gui_visible
){
	exit;
}

//================//
//GUI LAYOUT//
//================//
var _val_gui_w =
	display_get_gui_width();

var _val_banner_w = 580;
var _val_banner_h = 92;

var _val_x1 =
	(_val_gui_w * 0.5) -
	(_val_banner_w * 0.5);

var _val_y1 = 76;

var _val_x2 =
	_val_x1 +
	_val_banner_w;

var _val_y2 =
	_val_y1 +
	_val_banner_h;

//================//
//FADE OUT//
//================//
var _val_alpha = 1;

if (
	_ct_life >
	_ct_life_max -
	_ct_fade_frames
){

	_val_alpha =
		clamp(
			(
				_ct_life_max -
				_ct_life
			) /
			max(
				1,
				_ct_fade_frames
			),
			0,
			1
		);
}

//================//
//BACKGROUND//
//================//
draw_set_alpha(
	0.94 *
	_val_alpha
);

draw_set_colour(
	global.c_dk_gray
);

draw_rectangle(
	_val_x1,
	_val_y1,
	_val_x2,
	_val_y2,
	false
);

//================//
//BORDER//
//================//
draw_set_alpha(
	_val_alpha
);

draw_set_colour(
	c_yellow
);

draw_rectangle(
	_val_x1,
	_val_y1,
	_val_x2,
	_val_y2,
	true
);

draw_rectangle(
	_val_x1 + 1,
	_val_y1 + 1,
	_val_x2 - 1,
	_val_y2 - 1,
	true
);

//================//
//TITLE//
//================//
draw_set_halign(
	fa_center
);

draw_set_valign(
	fa_top
);

draw_set_font(
	fnt_gui_small
);

draw_set_colour(
	c_yellow
);

draw_text(
	_val_gui_w * 0.5,
	_val_y1 + 10,
	_str_title
);

//================//
//DETAIL LINES//
//================//
draw_set_font(
	fnt_gui_party_small
);

draw_set_colour(
	c_white
);

draw_text(
	_val_gui_w * 0.5,
	_val_y1 + 39,
	_str_line_1
);

draw_set_colour(
	c_ltgray
);

draw_text(
	_val_gui_w * 0.5,
	_val_y1 + 61,
	_str_line_2
);

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
