//===============================================================================//
//
// DRAW GUI: OBJ_GUI_MARKET_PANE
// FUNCTION: Draws the shared paged Market list.
//           Egg, Prism, NPC Trade, and Wandering Trader markets all use the same
//           four-entry page layout. Mouse wheel changes pages.
//
//===============================================================================//

//================//
//COOLDOWN//
//================//
hscr_gui_market_update_click_cooldown();

//================//
//RIGHT CLICK CLOSE//
//================//
if (mouse_check_button_pressed(mb_right)){

	audio_play_sound(
		snd_gui_close,
		0,
		false
	);

	//----------------//
	//NPC VENDOR//
	//----------------//
	if (_str_market_type == "NPC"){

		global.ref_active_gui =
			undefined;

		hscr_gui_market_release_npc_vendor();

		instance_destroy();
		exit;
	}

	//----------------//
	//STANDARD MARKET//
	//----------------//
	global.ref_active_gui =
		undefined;

	if (instance_exists(obj_gui_controller)){

		obj_gui_controller
			.hscr_gui_set_pause(
				false
			);
	}
	else if (instance_exists(obj_player)){

		scr_player_set_movement_state(
			"START"
		);
	}

	instance_destroy();
	exit;
}

//================//
//UPDATE PAGING//
//================//
var _ct_offers =
	array_length(
		_arr_stock
	);

_ct_pages =
	max(
		1,
		ceil(
			_ct_offers /
			_ct_entries_per_page
		)
	);

_it_page =
	clamp(
		_it_page,
		0,
		_ct_pages - 1
	);

//================//
//MOUSE WHEEL//
//================//
var _it_old_page =
	_it_page;

if (mouse_wheel_up()){

	_it_page =
		max(
			0,
			_it_page - 1
		);
}

if (mouse_wheel_down()){

	_it_page =
		min(
			_ct_pages - 1,
			_it_page + 1
		);
}

if (_it_page != _it_old_page){

	audio_play_sound(
		snd_gui_press,
		0,
		false
	);
}

//================//
//DRAW PANE//
//================//
draw_set_alpha(1);
draw_set_colour(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_sprite(
	spr_gui_market_pane,
	0,
	x,
	y
);

//================//
//HEADER//
//================//
draw_set_font(
	fnt_gui_medium
);

draw_set_colour(
	c_white
);

draw_set_halign(
	fa_center
);

draw_set_valign(
	fa_top
);

draw_text(
	x,
	_val_pane_top + 28,
	_str_header_text
);

draw_set_font(
	fnt_gui_small
);

draw_text(
	x,
	_val_pane_top + 58,
	"Gold: " +
	string(global.val_player_gold) +
	" gp | Right click to close"
);

//================//
//VISIBLE ENTRIES//
//================//
var _val_mouse_x =
	device_mouse_x_to_gui(0);

var _val_mouse_y =
	device_mouse_y_to_gui(0);

var _it_offer_start =
	_it_page *
	_ct_entries_per_page;

var _it_offer_end =
	min(
		_it_offer_start +
			_ct_entries_per_page,
		_ct_offers
	);

var _it_entry = 0;

for (
	var _it_offer = _it_offer_start;
	_it_offer < _it_offer_end;
	_it_offer++
){

	hscr_gui_market_draw_offer_entry(
		_it_offer,
		_it_entry,
		_val_mouse_x,
		_val_mouse_y
	);

	_it_entry++;
}

//================//
//EMPTY MARKET//
//================//
if (_ct_offers <= 0){

	draw_set_font(
		fnt_gui_small
	);

	draw_set_colour(
		c_white
	);

	draw_set_halign(
		fa_center
	);

	draw_set_valign(
		fa_middle
	);

	draw_text(
		x,
		_val_list_y +
			(
				(
					(_val_entry_h * 4) +
					(_val_entry_gap * 3)
				) *
				0.5
			),
		"NO STOCK AVAILABLE"
	);
}

//================//
//PAGE FOOTER//
//================//
draw_set_font(
	fnt_gui_small
);

draw_set_colour(
	c_white
);

draw_set_halign(
	fa_right
);

draw_set_valign(
	fa_bottom
);

draw_text(
	_val_pane_right - 28,
	_val_pane_bottom - 20,
	"PAGE " +
	string(_it_page + 1) +
	"/" +
	string(_ct_pages)
);

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(1);
draw_set_colour(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
