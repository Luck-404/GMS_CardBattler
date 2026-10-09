//===============================================================================//
//
// DRAW: OBJ_OVERWORLD_BEAST
// FUNCTION: Draws the overworld Beast shadow and staged animation subimage.
//           Wild Beasts also display disposition-specific fog.
//           Player companions use a minor half-amplitude bounce inverted from
//           the player's current walking bounce while both are moving.
//
//           Visible wild Elites:
//           - no circular "E" badge;
//           - use context-specific flat Elite scale multipliers;
//           - move upward only enough to preserve the normal 512 px canvas
//             bottom anchor while the centered sprite scales;
//           - use a slight gray tint by default;
//           - retain explicit modifier-specific tint overrides;
//           - retain persistent modifier-specific VFX.
//
// NOTES:
// - Beast vertical placement never uses bbox/collision-mask data.
// - No species-specific vertical correction list is used.
// - The shared Elite VFX renderer may inspect the sprite hitbox only to keep
//   overhead motifs at least 5 px above the visible Beast.
//
//===============================================================================//

//================//
//VALIDATE BEAST//
//================//
if (_stct_unit == undefined || _spr_beast == undefined){
	exit;
}

var _flag_draw_elite =
	_str_team == "WILD" &&
	is_struct(_stct_unit) &&
	variable_struct_exists(
		_stct_unit,
		"_flag_elite"
	) &&
	_stct_unit._flag_elite;

var _str_elite_draw_modifier = "";

if (
	_flag_draw_elite &&
	variable_struct_exists(
		_stct_unit,
		"_str_elite_modifier"
	)
){
	_str_elite_draw_modifier =
		string_upper(
			string(
				_stct_unit
					._str_elite_modifier
			)
		);
}

//================//
//ELITE SCALE//
//================//
var _val_elite_draw_scale =
	_flag_draw_elite
	? scr_elite_get_draw_scale_multiplier(
		_str_elite_draw_modifier,
		"OVERWORLD"
	)
	: 1;

//================//
//ELITE TINT//
//================//
var _c_beast_draw_tint =
	_flag_draw_elite
	? scr_elite_get_beast_tint(
		_str_elite_draw_modifier,
		"OVERWORLD",
		c_white
	)
	: c_white;

//===================//
//ELITE VERTICAL LIFT//
//===================//
var _val_elite_vertical_lift = 0;

if (_flag_draw_elite){
	/*
		Every overworld Beast uses a 512 x 512 sprite, middle-center origin, and
		0.10 base draw scale. Scaling around the center extends the lower half of
		the sprite canvas downward automatically. Move the draw origin upward by
		exactly that added lower-half distance so the scaled Elite preserves the
		same canvas-bottom ground anchor as the normal Beast.

		Formula:
		(512 / 2) * 0.10 * (elite scale - 1)

		Current results:
		- Standard 1.60x -> 15.36 px upward
		- Monarch 1.75x  -> 19.20 px upward
		- Hardy 2.00x    -> 25.60 px upward

		No bbox/collision-mask data and no species-specific offsets are used.
	*/
	var _val_sprite_half_height = 512 * 0.5;
	var _val_base_draw_scale = 0.10;

	_val_elite_vertical_lift =
		_val_sprite_half_height *
		_val_base_draw_scale *
		max(
			0,
			_val_elite_draw_scale - 1
		);
}

//====================//
//COMPANION MOVE BOUNCE//
//====================//
var _val_companion_bounce_y = 0;

var _flag_beast_moving =
	abs(x - xprevious) > 0.01 ||
	abs(y - yprevious) > 0.01;

if (
	_str_team == "PLAYER" &&
	_flag_beast_moving &&
	instance_exists(obj_player)
){
	var _ref_player =
		instance_find(
			obj_player,
			0
		);

	if (
		instance_exists(_ref_player) &&
		variable_instance_exists(
			_ref_player,
			"_flag_player_moving"
		) &&
		_ref_player._flag_player_moving &&
		variable_instance_exists(
			_ref_player,
			"_val_player_bounce_offset"
		)
	){
		/*
			Player bounce runs 0 -> 4 px. Invert that phase and halve the amplitude:
			player at 0 (visually high) -> companion at +2 (visually low);
			player at 4 (visually low)  -> companion at  0 (visually high).
		*/
		_val_companion_bounce_y =
			(
				4 -
				clamp(
					_ref_player._val_player_bounce_offset,
					0,
					4
				)
			) *
			0.5;
	}
}

var _val_beast_draw_y =
	y -
	_val_elite_vertical_lift +
	_val_companion_bounce_y;

//================//
//DRAW SHADOW//
//================//
if (_spr_shadow != undefined){

	draw_sprite_ext(
		_spr_shadow,
		0,
		x,
		y + 24,
		0.75 * _val_elite_draw_scale,
		0.75 * _val_elite_draw_scale,
		0,
		c_white,
		1
	);
}

//================//
//WILD DISPOSITION//
//================//
if (_str_team == "WILD"){

	var _spr_fog = undefined;

	switch (_str_disposition){

		case "ANGRY":
			_spr_fog =
				spr_overworld_vfx_wild_fog_angry;
		break;

		case "SCARED":
			_spr_fog =
				spr_overworld_vfx_wild_fog_scared;
		break;

		case "CHILL":
			_spr_fog =
				spr_overworld_vfx_wild_fog_chill;
		break;
	}

	if (_spr_fog != undefined){

		draw_sprite_ext(
			_spr_fog,
			0,
			x,
			y,
			_val_elite_draw_scale,
			_val_elite_draw_scale,
			0,
			c_white,
			1
		);
	}
}

//====================//
//ELITE MODIFIER VFX//
//====================//
if (_flag_draw_elite){

	scr_elite_draw_modifier_vfx(
		self,
		_spr_beast,
		x,
		_val_beast_draw_y,
		0.1 *
			image_xscale *
			_val_elite_draw_scale,
		0.1 *
			_val_elite_draw_scale,
		0,
		"OVERWORLD"
	);
}

//================//
//DRAW BEAST//
//================//
var _val_beast_subimage = scr_beast_animation_get_frame(self);

draw_sprite_ext(
	_spr_beast,
	_val_beast_subimage,
	x,
	_val_beast_draw_y,
	0.1 *
		image_xscale *
		_val_elite_draw_scale,
	0.1 *
		_val_elite_draw_scale,
	0,
	_c_beast_draw_tint,
	1
);
