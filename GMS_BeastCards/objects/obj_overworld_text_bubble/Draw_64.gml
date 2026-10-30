//===============================================================================//
//
// DRAW GUI: OBJ_OVERWORLD_TEXT_BUBBLE
// FUNCTION: Draws a wrapped GUI-space overworld tooltip.
//           Uses the Wandering Merchant overhead-label visual format:
//           black translucent fill, yellow border, centered white text.
//
//===============================================================================//

//================//
//VALIDATE TEXT//
//================//
if (_str_text == "DEFAULT" || _str_text == ""){
	exit;
}

//================//
//RESOLVE CAMERA//
//================//
var _ref_draw_camera =
	view_camera[0];

if (
	variable_global_exists("ref_camera") &&
	global.ref_camera != undefined
){
	_ref_draw_camera =
		global.ref_camera;
}

if (_ref_draw_camera == -1){
	exit;
}

//================//
//CAMERA TO GUI//
//================//
var _val_cam_x =
	camera_get_view_x(
		_ref_draw_camera
	);

var _val_cam_y =
	camera_get_view_y(
		_ref_draw_camera
	);

var _val_cam_w =
	max(
		1,
		camera_get_view_width(
			_ref_draw_camera
		)
	);

var _val_cam_h =
	max(
		1,
		camera_get_view_height(
			_ref_draw_camera
		)
	);

var _val_gui_w =
	display_get_gui_width();

var _val_gui_h =
	display_get_gui_height();

var _val_scale_x =
	_val_gui_w /
	_val_cam_w;

var _val_scale_y =
	_val_gui_h /
	_val_cam_h;

var _val_gui_x =
	(x - _val_cam_x) *
	_val_scale_x;

var _val_gui_y =
	(y - _val_cam_y) *
	_val_scale_y;

//================//
//TEXT LAYOUT//
//================//
draw_set_font(
	fnt_gui_small
);

var _val_text_w =
	min(
		_val_max_text_w,
		max(
			1,
			string_width(
				_str_text
			)
		)
	);

var _val_wrapped_w =
	min(
		_val_max_text_w,
		max(
			1,
			string_width_ext(
				_str_text,
				_val_line_sep,
				_val_text_w
			)
		)
	);

var _val_text_h =
	max(
		1,
		string_height_ext(
			_str_text,
			_val_line_sep,
			_val_text_w
		)
	);

//================//
//BOX LAYOUT//
//================//
var _val_box_w =
	_val_wrapped_w +
	(_val_padding_x * 2);

var _val_box_h =
	_val_text_h +
	(_val_padding_y * 2);

var _val_x1 =
	_val_gui_x -
	(_val_box_w * 0.5);

var _val_x2 =
	_val_x1 +
	_val_box_w;

var _val_y2 =
	_val_gui_y;

var _val_y1 =
	_val_y2 -
	_val_box_h;

//================//
//KEEP ON SCREEN//
//================//
var _val_screen_pad = 8;

if (_val_x1 < _val_screen_pad){

	var _val_shift_x =
		_val_screen_pad -
		_val_x1;

	_val_x1 += _val_shift_x;
	_val_x2 += _val_shift_x;
	_val_gui_x += _val_shift_x;
}
else if (_val_x2 > _val_gui_w - _val_screen_pad){

	var _val_shift_x =
		(_val_gui_w - _val_screen_pad) -
		_val_x2;

	_val_x1 += _val_shift_x;
	_val_x2 += _val_shift_x;
	_val_gui_x += _val_shift_x;
}

if (_val_y1 < _val_screen_pad){

	var _val_shift_y =
		_val_screen_pad -
		_val_y1;

	_val_y1 += _val_shift_y;
	_val_y2 += _val_shift_y;
}

//================//
//BACKGROUND//
//================//
draw_set_alpha(0.90);
draw_set_colour(c_black);

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
draw_set_alpha(1);
draw_set_colour(c_yellow);

draw_rectangle(
	_val_x1,
	_val_y1,
	_val_x2,
	_val_y2,
	true
);

//================//
//TEXT//
//================//
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

draw_text_ext(
	_val_gui_x,
	_val_y1 +
	_val_padding_y,
	_str_text,
	_val_line_sep,
	_val_text_w
);

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
