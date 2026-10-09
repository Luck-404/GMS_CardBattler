//===============================================================================//
//
// DRAW GUI END: OBJ_BATTLE_MINION
// FUNCTION: Draws the battle Minion after normal battle GUI presentation.
//           This guarantees Minions render above their host Beast shadow/sprite.
//           Displays its sprite and current HP.
//           Normal hover shows its name.
//           Ctrl hover shows detailed Minion information using the shared
//           Cheats-style hover tooltip.
//
//===============================================================================//

//------------------//
//END BATTLE GUARD//
//------------------//
if (
	instance_exists(
		obj_gui_end_battle_pane
	)
){
	exit;
}

//----------------//
//VALIDATE HOST//
//----------------//
if (
	!instance_exists(
		_ref_host
	)
){
	exit;
}

#region BASIC SETUP

//-----------//
//DRAW SETUP//
//-----------//
draw_set_font(
	fnt_gui_party_small
);

//------------------//
//BASE MINION SCALE//
//------------------//
var _val_base_scale =
	0.125;

//------------------------//
//MAGNITUDE SIZE INCREASE//
//------------------------//
var _ct_growth_tiers =
	floor(
		max(
			0,
			_val_magnitude
		) /
		5
	);

var _val_magnitude_scale =
	1 +
	(
		_ct_growth_tiers *
		0.10
	);

//----------------//
//FINAL DRAW SCALE//
//----------------//
var _val_scale =
	_val_base_scale *
	_val_magnitude_scale *
	_val_vfx_scale;

var _val_flip =
	(_str_team == "ENEMY")
		? -1
		: 1;

#endregion

#region DRAW SPRITE

//-------------//
//DRAW MINION//
//-------------//
draw_sprite_ext(
	_spr_minion,
	0,
	x + _val_vfx_offset_x,
	y + _val_vfx_offset_y,
	_val_scale *
		_val_flip,
	_val_scale,
	0,
	c_white,
	1
);

#endregion

#region DRAW HP

//---------//
//DRAW HP//
//---------//
draw_set_colour(
	c_white
);

var _str_hp =
	string(
		_val_cur_hp
	) +
	"/" +
	string(
		_val_max_hp
	);

draw_text(
	x -
		(
			string_width(
				_str_hp
			) *
			0.5
		),
	y + 20,
	_str_hp
);

#endregion

#region HOVER TOOLTIP

//================//
//CHECK HOVER//
//================//
var _flag_minion_hover =
	position_meeting(
		device_mouse_x(0),
		device_mouse_y(0),
		self
	);

if (
	!scr_gui_check_cheats_active() &&
	_flag_minion_hover
){

	//================//
	//CTRL INSPECTION//
	//================//
	if (
		keyboard_check(
			vk_lcontrol
		)
	){

		scr_gui_request_battle_inspection(
			"MINION",
			self,
			40
		);
	}

	//================//
	//SIMPLE TOOLTIP//
	//================//
	else{

		scr_gui_set_hover_tooltip(
			_str_name,
			"",
			40
		);
	}
}

#endregion

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(1);
draw_set_colour(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
