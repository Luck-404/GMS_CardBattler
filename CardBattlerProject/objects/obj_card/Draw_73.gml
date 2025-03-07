if (_reward == false){
	if (_list == "deck"){
		draw_sprite_ext(sprite_index,1,x,y,0.3,0.3,0,c_white,1);
	}

	else if (_list == "discard"){
		draw_sprite_ext(sprite_index,0,x,y,0.3,0.3,0,c_white,1);
	}

	else if (_list == "exhaust"){
		draw_sprite_ext(sprite_index,0,x,y,0.3,0.3,0,c_white,1);
	}

	else{
		if (_selected){
			draw_sprite(spr_card_selected,0,x,y);
		}

		if (global.flag_gui_open == false && position_meeting(mouse_x,mouse_y,self) && (global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CHANNEL || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_TARGET || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CARD)){
			//enlarges card
			if (_active){
				draw_sprite_ext(sprite_index,0,x,y,0.4,0.4,0,c_white,1);
			}
			else {
				draw_sprite_ext(sprite_index,0,x,y,0.4,0.4,0,c_grey,1);
			}
			//draws info box
			draw_set_color(c_grey);
			draw_rectangle(mouse_x+10,mouse_y,mouse_x+155, mouse_y+75,false);
	
			//draw info
			draw_set_font(fnt_fanwood_sm);
			draw_set_color(c_white);
	
			draw_text(mouse_x+15, mouse_y+5, _card_name + " | Mana Cost: " + string(_card_cost));
			draw_text(mouse_x+15, mouse_y+20, _card_desc);	
			draw_text(mouse_x+15, mouse_y+35, _card_color);	
			draw_text(mouse_x+15, mouse_y+50, _card_type);	
			draw_text(mouse_x+15, mouse_y+60, _list);		
	
		} else {
			if(_active){
				draw_sprite_ext(sprite_index,0,x,y,0.3,0.3,0,c_white,1);
			}
			else { //draw greyed if
				draw_sprite_ext(sprite_index,0,x,y,0.3,0.3,0,c_grey,1);
			}
		}
	}
}