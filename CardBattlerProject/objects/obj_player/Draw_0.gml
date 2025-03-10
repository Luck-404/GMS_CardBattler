//////////////////////////////////////////////////////////////////////
//							OBJ_PLAYER DRAW							//
//																	//
// > DRAWS THE PLAYER'S SHADOW CIRCLE								//
//////////////////////////////////////////////////////////////////////
draw_self();
draw_sprite(spr_player_circle,0,x,y+15);

if (room == rm_encounter){
	draw_set_font(fnt_fanwood_sm);
	draw_set_color(c_black);
	draw_text(150,850,"deck: " + string(ds_list_size(global.player_encounter_deck)));
	////draw deck contents in order
	//for (var _i = 0; _i < ds_list_size(global.player_encounter_deck); _i++){
	//	draw_text(150,800+(_i*20),"deck: " + ds_list_find_value(global.player_encounter_deck,_i)._card_name);
	//}

	draw_text(450,850,"hand: " + string(ds_list_size(global.player_hand)));
	////draw deck contents in order
	//for (var _i = 0; _i < ds_list_size(global.player_hand); _i++){
	//	draw_text(450,800+(_i*20),"hand: " + ds_list_find_value(global.player_hand,_i)._card_name);
	//}
	
	draw_text(1550,850,"discard: " + string(ds_list_size(global.player_discard_pile)));
	////draw deck contents in order
	//for (var _i = 0; _i < ds_list_size(global.player_discard_pile); _i++){
	//	draw_text(1550,800+(_i*20),"discard: " + ds_list_find_value(global.player_discard_pile,_i)._card_name);
	//}
	
	draw_text(1750,850,"exhaust: " + string(ds_list_size(global.player_exhaust_pile)));	
	////draw deck contents in order
	//for (var _i = 0; _i < ds_list_size(global.player_exhaust_pile); _i++){
	//	draw_text(1750,800+(_i*20),"exhaust: " + ds_list_find_value(global.player_exhaust_pile,_i)._card_name);
	//}
	
	draw_text(100,100,"mana: " + string(global.cur_mana) + "/" + string(global.max_mana));
	if (global.echo_count != 0){
		draw_text(100,130,"echo count: " + string(global.echo_count));	
	}
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