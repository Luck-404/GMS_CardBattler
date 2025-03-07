//////////////////////////////////////////////////////////////////////
//							OBJ_PLAYER DRAW							//
//																	//
// > DRAWS THE PLAYER'S SHADOW CIRCLE								//
//////////////////////////////////////////////////////////////////////
draw_self();
draw_sprite(spr_player_circle,0,x,y+15);

if (room == rm_encounter){
	draw_set_font(fnt_fanwood);
	draw_set_color(c_black);
	draw_text(200,850,"deck: " + string(ds_list_size(global.player_encounter_deck)));
	draw_text(500,850,"hand: " + string(ds_list_size(global.player_hand)));
	draw_text(1400,850,"discard: " + string(ds_list_size(global.player_discard_pile)));
	draw_text(1600,850,"exhaust: " + string(ds_list_size(global.player_exhaust_pile)));	
	draw_text(100,100,"mana: " + string(global.cur_mana) + "/" + string(global.max_mana));
}

if (_card_selected != undefined && _channel_selected == undefined){
	//card to mouse
	draw_set_color(c_black);
	draw_line(_card_selected.x,_card_selected.y,mouse_x,mouse_y);
	draw_sprite(spr_cross,0,mouse_x,mouse_y);
}

else if (_channel_selected != undefined){
	//card to channel
	draw_set_color(c_black);
	draw_line(_card_selected.x,_card_selected.y,_channel_selected.x,_channel_selected.y);
	draw_sprite(spr_cross,0,_channel_selected.x,_channel_selected.y);
	
	//channel to mouse
	draw_set_color(c_black);
	draw_line(_channel_selected.x,_channel_selected.y,mouse_x,mouse_y);
	draw_sprite(spr_cross,0,mouse_x,mouse_y);	
}