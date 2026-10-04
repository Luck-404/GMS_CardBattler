//===============================================================================//
//
// DRAW GUI END: OBJ_BATTLE_CARD
// FUNCTION: Draws the enlarged centered Card artwork during Ctrl inspection.
//           The fixed Card-information pane is drawn separately by the
//           battle player controller.
//
//===============================================================================//

#region CARD PREVIEW

//================//
//CARD PREVIEW//
//================//
if (
	!scr_gui_check_cheats_active() &&
	keyboard_check(vk_lcontrol) &&
	_spr_preview_card != undefined
){

	draw_sprite_ext(
		_spr_preview_card,
		0,
		display_get_gui_width() * 0.5,
		display_get_gui_height() * 0.5,
		_val_preview_scale,
		_val_preview_scale,
		0,
		c_white,
		1
	);
}

#endregion

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(1);
draw_set_colour(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);