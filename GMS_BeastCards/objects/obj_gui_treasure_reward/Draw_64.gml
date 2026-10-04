//===============================================================================//
//
// DRAW GUI: OBJ_GUI_TREASURE_REWARD
// FUNCTION: Draws one treasure reward notification.
//
//           Notifications are right-aligned to the bottom-right of the GUI.
//           Newest reward occupies the lowest position.
//           Older rewards grow upward.
//
//           If an older/middle reward expires, remaining entries smoothly settle
//           into their new positions.
//
//===============================================================================//

#region LAYOUT

//================//
//GUI SIZE//
//================//
var _val_gui_width =
	display_get_gui_width();

var _val_gui_height =
	display_get_gui_height();

//================//
//MEASURE TEXT//
//================//
draw_set_font(fnt_gui_small);

_val_box_width =
	max(
		180,
		string_width(_str_text) + 24
	);

_val_box_width =
	min(
		_val_box_width,
		_val_gui_width - 32
	);

//================//
//COUNT NEWER//
//================//
var _ct_newer = 0;

var _ct_rewards =
	instance_number(obj_gui_treasure_reward);

for (
	var _it_reward = 0;
	_it_reward < _ct_rewards;
	_it_reward++
){

	var _ref_reward =
		instance_find(
			obj_gui_treasure_reward,
			_it_reward
		);

	if (!instance_exists(_ref_reward)){
		continue;
	}

	if (_ref_reward == id){
		continue;
	}

	if (
		_ref_reward._val_reward_serial >
		_val_reward_serial
	){
		_ct_newer++;
	}
}

//================//
//TARGET POSITION//
//================//
_val_target_x =
	_val_gui_width -
	_val_screen_margin -
	_val_box_width;

_val_target_y =
	_val_gui_height -
	_val_screen_margin -
	_val_box_height -
	(
		_ct_newer *
		(
			_val_box_height +
			_val_box_gap
		)
	);

//================//
//INITIAL POSITION//
//================//
if (!_flag_position_initialized){

	x = _val_target_x;
	y = _val_target_y;

	_flag_position_initialized = true;
}

//================//
//SMOOTH POSITION//
//================//
else{

	x =
		lerp(
			x,
			_val_target_x,
			0.35
		);

	y =
		lerp(
			y,
			_val_target_y,
			0.35
		);
}

#endregion

#region DRAW

//================//
//APPLY FADE//
//================//
draw_set_alpha(_val_alpha);

//================//
//BOX FILL//
//================//
draw_set_colour(global.c_dk_gray);

draw_rectangle(
	x,
	y,
	x + _val_box_width,
	y + _val_box_height,
	false
);

//================//
//BOX OUTLINE//
//================//
draw_set_colour(c_white);

draw_rectangle(
	x,
	y,
	x + _val_box_width,
	y + _val_box_height,
	true
);

//================//
//REWARD TEXT//
//================//
draw_set_font(fnt_gui_small);
draw_set_colour(_c_text);

draw_set_halign(fa_left);
draw_set_valign(fa_middle);

draw_text(
	x + 12,
	y + (_val_box_height * 0.5),
	_str_text
);

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(1);

draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

#endregion