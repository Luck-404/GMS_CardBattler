//===============================================================================//
//
// DRAW GUI: OBJ_OVERWORLD_TREASURE_CHEST
// FUNCTION: Draws the GUI-space overhead label for the active Gilded Gambit
//           Choose-a-Chest World Event. Only the designated banner-owner chest
//           draws the label; all five chests remain normally Y-sorted in-world.
//
//===============================================================================//

//================//
//VALIDATE OWNER//
//================//
var _flag_choice_label_owner =
	variable_instance_exists(
		self,
		"_flag_world_event_instance"
	) &&
	_flag_world_event_instance &&
	variable_instance_exists(
		self,
		"_str_world_event_id"
	) &&
	_str_world_event_id ==
		"CHOOSE_A_CHEST" &&
	variable_instance_exists(
		self,
		"_flag_world_event_choice_banner_owner"
	) &&
	_flag_world_event_choice_banner_owner &&
	!_flag_triggered;

if (!_flag_choice_label_owner){
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

var _val_gui_object_top =
	(bbox_top - _val_cam_y) *
	_val_scale_y;

//================//
//LABEL LAYOUT//
//================//
var _str_label =
	"Choose a Chest";

var _val_label_bottom =
	_val_gui_object_top -
	24;

var _val_pad_x = 8;
var _val_pad_y = 5;

draw_set_font(
	fnt_gui_small
);

var _val_label_w =
	string_width(
		_str_label
	) +
	(_val_pad_x * 2);

var _val_label_h =
	string_height(
		_str_label
	) +
	(_val_pad_y * 2);

var _val_x1 =
	_val_gui_x -
	(_val_label_w * 0.5);

var _val_x2 =
	_val_x1 +
	_val_label_w;

var _val_y2 =
	_val_label_bottom;

var _val_y1 =
	_val_y2 -
	_val_label_h;

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
draw_set_valign(fa_middle);

draw_text(
	_val_gui_x,
	_val_y1 +
	(_val_label_h * 0.5),
	_str_label
);

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
