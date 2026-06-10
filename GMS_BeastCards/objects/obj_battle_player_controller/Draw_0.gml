//
//
// DRAW: OBJ_BATTLE_PLAYER_CONTROLLER | DRAW MANA COUNTER
//
//
if (!instance_exists(obj_gui_end_battle_pane)){
#region MANA COUNTER
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_black);
draw_set_font(fnt_large_gui);
draw_text(50,50,"MANA: " + string(_cur_mana) +"/" + string(_max_mana));
#endregion

if (global.echo_counter != 0){
draw_text(50,150,"ECHO: " + string(global.echo_counter));	
}
draw_set_font(fnt_small_gui);
draw_text(50,800,"DCK: " + string(ds_list_size(_battle_deck)));	
draw_text(200,800,"HND: " + string(ds_list_size(_battle_hand)));	
draw_text(880,800,"DIS: " + string(ds_list_size(_battle_discard)));	
draw_text(950,800,"EXH: " + string(ds_list_size(_battle_exhaust)));	
//draw_text(room_width/2-16,25,"_s: " + string(ds_list_size(global.statuses)));


#region CARD-> MOUSE
if (_player_state == PLAYER_STATE.SELECT_CASTER){
	draw_set_colour(c_black);
	draw_line(global.cast_card.x,global.cast_card.y,device_mouse_x_to_gui(0),device_mouse_y_to_gui(0));	
}
#endregion

#region CASTER-> MOUSE
if (_player_state == PLAYER_STATE.SELECT_TARGET){
	draw_set_colour(c_black);
	draw_line(global.cast_card.x,global.cast_card.y,global.caster_beast.x,global.caster_beast.y);
	draw_line(global.caster_beast.x,global.caster_beast.y,device_mouse_x_to_gui(0),device_mouse_y_to_gui(0));	
	
	var _card_range = global.cast_card._ref_card[?"card_range"];
	if (_card_range == "GLOBAL"){
		draw_set_colour(c_black);
		draw_set_font(fnt_small_gui);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text(device_mouse_x_to_gui(0)-string_width("CLICK TO CAST GLOBAL CARD")/2,device_mouse_y_to_gui(0)-15,"CLICK TO CAST GLOBAL CARD");
	}
	
}
#endregion

//------------------------------------------------------------
// CTRL INSPECTION PANE
//------------------------------------------------------------
if (keyboard_check(vk_lcontrol) &&
    (_player_state == PLAYER_STATE.SELECT_CASTER || _player_state == PLAYER_STATE.SELECT_TARGET) && !position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),obj_battle_card))
{
    var _x1 = room_width/2 - 180;
    var _x2 = room_width/2 + 180;
    var _y1 = 750;
    var _y2 = 850;

    draw_set_font(fnt_small_gui);

    draw_set_colour(c_dkgray);
    draw_rectangle(_x1, _y1, _x2, _y2, false);

    draw_set_colour(c_black);
    draw_rectangle(_x1, _y1, _x2, _y2, true);

    draw_set_colour(c_white);

    var _card = global.cast_card._ref_card;

    //--------------------------------------------------------
    // CASTER MODE
    //--------------------------------------------------------
    if (_player_state == PLAYER_STATE.SELECT_CASTER)
    {
        var _colors = _card[?"card_colors"];
        var _arch   = _card[?"card_archetype_req"];
        var _class  = _card[?"card_class_req"];

        draw_text(_x1 + 10, _y1 + 10, "REQUIREMENTS TO CAST:");
        draw_text(_x1 + 10, _y1 + 30, "COLOR(S): " + string(_colors));
        draw_text(_x1 + 10, _y1 + 50, "ARCHETYPE: " + string(_arch));
        draw_text(_x1 + 10, _y1 + 70, "CLASS: " + string(_class));
    }

    //--------------------------------------------------------
    // TARGET MODE
    //--------------------------------------------------------
    if (_player_state == PLAYER_STATE.SELECT_TARGET)
    {
        var _range = _card[?"card_range"];

        draw_text(_x1 + 10, _y1 + 10, "REQUIREMENTS TO CAST:");
        draw_text(_x1 + 10, _y1 + 30, "RANGE: " + string(_range));
    }
}

}