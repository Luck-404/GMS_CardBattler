//===============================================================================//
//
// DRAW GUI END: OBJ_GUI_CONTROLLER
// FUNCTION: Draws the final shared hover tooltip in the overworld.
//           Battle owns its final tooltip draw through
//           OBJ_BATTLE_PLAYER_CONTROLLER.
//
//===============================================================================//

if (room == rm_battle){
	exit;
}

scr_gui_draw_hover_tooltip();

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(1);
draw_set_colour(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);