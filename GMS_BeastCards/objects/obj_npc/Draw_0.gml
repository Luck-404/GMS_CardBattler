//===============================================================================//
//
// DRAW: OBJ_NPC
// FUNCTION: Draws the NPC and interaction feedback.
//           Displays a highlight while the player is within range.
//           Shows the NPC name above the instance during interaction.
//
//===============================================================================//

//----------//
// DRAW NPC //
//----------//
draw_self();

//----------------------//
// INTERACTION HIGHLIGHT//
//----------------------//
if (
	_stct_npc != undefined &&
	_stct_npc._flag_interactable &&
	_flag_player_nearby &&
	!_flag_triggered
){
	draw_set_colour(c_white);

	draw_rectangle(
		bbox_left - 2,
		bbox_top - 2,
		bbox_right + 2,
		bbox_bottom + 2,
		true
	);

	draw_set_font(fnt_small_gui);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);

	draw_text(
		x,
		bbox_top - 8,
		"[E] " + string(_stct_npc._str_npc_name)
	);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

//------------------//
// INTERACTING NAME //
//------------------//
if (
	_stct_npc != undefined &&
	_flag_triggered
){
	draw_set_font(fnt_small_gui);
	draw_set_colour(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);

	draw_text(
		x,
		bbox_top - 8,
		string(_stct_npc._str_npc_name)
	);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}