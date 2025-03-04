if ((global.flag_gui_open == false) && position_meeting(mouse_x,mouse_y,self) && (global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CHANNEL || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_TARGET || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CARD)){
	//enlarges card
	if (_active){
	draw_sprite_ext(sprite_index,0,x,y,1.5,1.5,0,c_white,1);
	}
	else {
	draw_sprite_ext(sprite_index,0,x,y,1.5,1.5,0,c_grey,1);
	}
	//draws info box
	draw_set_color(c_grey);
	draw_rectangle(mouse_x+10,mouse_y,mouse_x+155, mouse_y+75,false);
	
	//draw info
	draw_set_font(fnt_fanwood_sm);
	draw_set_color(c_white);
	
	draw_text(mouse_x+15, mouse_y+5, _card_name + string(_card_cost));
	draw_text(mouse_x+15, mouse_y+20, _card_desc);	
	draw_text(mouse_x+15, mouse_y+35, _card_color);	
	draw_text(mouse_x+15, mouse_y+50, _card_type);	
	
} else {
	if(_active){
		draw_self();
	}
	else { //draw greyed if
		draw_sprite_ext(sprite_index,0,x,y,1.0,1.0,0,c_grey,1);
	}
}