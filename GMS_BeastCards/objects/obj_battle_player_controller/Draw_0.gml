//
//
// DRAW: OBJ_BATTLE_PLAYER_CONTROLLER | DRAW MANA COUNTER
//
//

#region MANA COUNTER
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_black);
draw_set_font(fnt_gui_large);
draw_text(50,50,"MANA: " + string(_cur_mana) +"/" + string(_max_mana));
if (global.echo_counter != 0){
draw_text(50,150,"ECHO: " + string(global.echo_counter));	
}
#endregion

#region CARD-> MOUSE
if (_player_state == PLAYER_STATE.SELECT_CASTER){
	draw_set_colour(c_black);
	draw_line(global.cast_card.x,global.cast_card.y,mouse_x,mouse_y);	
}
#endregion

#region CASTER-> MOUSE
if (_player_state == PLAYER_STATE.SELECT_TARGET){
	draw_set_colour(c_black);
	draw_line(global.cast_card.x,global.cast_card.y,global.caster_beast.x,global.caster_beast.y);
	draw_line(global.caster_beast.x,global.caster_beast.y,mouse_x,mouse_y);	
	
	var _card_range = global.cast_card._ref_card[?"card_range"];
	if (_card_range == "GLOBAL"){
		draw_set_colour(c_black);
		draw_set_font(fnt_gui_small);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text(mouse_x-string_width("CLICK TO CAST GLOBAL CARD")/2,mouse_y-15,"CLICK TO CAST GLOBAL CARD");
	}
	
}
#endregion

