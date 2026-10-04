//===============================================================================//
//
// DRAW: OBJ_NPC
// FUNCTION: Draws the NPC using directional and highlighted sprite frames.
//
// FRAME MAP:
//     0 = Forward
//     1 = Backward
//     2 = Forward Highlighted
//     3 = Backward Highlighted
//
//===============================================================================//

//================//
//VALIDATE SPRITE//
//================//
if (sprite_index == -1){
	exit;
}

//=====================//
//INTERACTION HIGHLIGHT//
//=====================//
var _flag_show_interaction =
	_stct_npc != undefined &&
	_stct_npc._flag_interactable &&
	_flag_player_nearby &&
	!_flag_triggered;

//================//
//SELECT NPC FRAME//
//================//
var _it_draw_frame =
	_it_facing_frame;

//----------------//
//ADD HIGHLIGHT//
//----------------//
if (
	_flag_show_interaction &&
	sprite_get_number(sprite_index) >= 4
){
	_it_draw_frame += 2;
}

//----------------//
//CLAMP FRAME//
//----------------//
_it_draw_frame =
	clamp(
		_it_draw_frame,
		0,
		sprite_get_number(sprite_index) - 1
	);

//================//
//DRAW NPC//
//================//
draw_sprite_ext(
	sprite_index,
	_it_draw_frame,
	x,
	y,
	image_xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);

//================//
//TALK PROMPT//
//================//
if (_flag_show_interaction){

	draw_set_font(fnt_gui_small);
	draw_set_colour(c_white);

	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);

	draw_text(
		x,
		bbox_top - 6,
		"TALK"
	);
}

//================//
//INTERACTING NAME//
//================//
if (
	_stct_npc != undefined &&
	_flag_triggered
){

	draw_set_font(fnt_gui_small);
	draw_set_colour(c_white);

	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);

	draw_text(
		x,
		bbox_top - 6,
		string(_stct_npc._str_npc_name)
	);
}

//================//
//RESET DRAW STATE//
//================//
draw_set_colour(c_white);
draw_set_alpha(1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);