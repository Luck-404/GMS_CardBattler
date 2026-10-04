//===============================================================================//
//
// DRAW: OBJ_MATERIAL_NODE
// FUNCTION: Draws the Material node and displays interaction feedback while the
//           player is within gathering range.
//
//===============================================================================//

//================//
//DRAW NODE//
//================//
draw_self();

//================//
//GATHER PROMPT//
//================//
if (
	!_flag_collected &&
	instance_exists(
		obj_player
	) &&
	!global.flag_pause &&
	distance_to_object(
		obj_player
	) <
	_val_interact_distance
){

	draw_set_font(
		fnt_gui_small
	);

	draw_set_halign(
		fa_center
	);

	draw_set_valign(
		fa_bottom
	);

	draw_set_colour(
		c_white
	);

	draw_text(
		x,
		bbox_top - 6,
		"GATHER"
	);
}

//================//
//RESET DRAW STATE//
//================//
draw_set_colour(
	c_white
);

draw_set_alpha(
	1
);

draw_set_halign(
	fa_left
);

draw_set_valign(
	fa_top
);