//////////////////////////////////////////////////////////////////////
//							OBJ_CARD DRAW							//
//																	//
// > HANDLE MAKING THE CARD REF INTO AN OBJ CARD- CARRY OVER THESE  //
//   DEFINITIONS													//
//////////////////////////////////////////////////////////////////////

if (_reward == false){
	////////////////
	// DECK CARDS //
	////////////////
	if (_list == "deck"){
		//draw card backs, no hover logic
		draw_sprite_ext(sprite_index,1,x,y,0.3,0.3,0,c_white,1);
	}
	
	///////////////////
	// DISCARD CARDS //
	///////////////////
	else if (_list == "discard"){
		//draw card, no hover logic
		draw_sprite_ext(sprite_index,0,x,y,0.3,0.3,0,c_white,1);
	}
	
	///////////////////
	// EXHAUST CARDS //
	///////////////////
	else if (_list == "exhaust"){
		//draw card, no hover logic
		draw_sprite_ext(sprite_index,0,x,y,0.3,0.3,0,c_white,1);
	}

	/////////////////////////////////////
	// HAND CARDS - HOVER INTERACTIONS //
	/////////////////////////////////////
	else{
		////////////////////
		// SELECTION ICON //
		////////////////////
		if (_selected){
			draw_sprite(spr_card_selected,0,x,y);
		}

		//////////////////////////////////
		// HOVER TOOLTIPS AND ENLARGING //
		//////////////////////////////////
		if (global.flag_gui_open == false && position_meeting(mouse_x,mouse_y,self) && (global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CHANNEL || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_TARGET || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CARD)){
			//enlarges card
			if (_active){
				draw_sprite_ext(sprite_index,0,x,y,0.6,0.6,0,c_white,1);
				draw_sprite_ext(spr_card_active,0,x,y,1,1,0,c_white,1);
			}
			else {
				draw_sprite_ext(sprite_index,0,x,y,0.6,0.6,0,c_white,1);
			}
			//draws info box
			draw_set_color(c_grey);
			draw_rectangle(mouse_x+10,mouse_y,mouse_x+155, mouse_y+100,false);
	
			//draw info
			draw_set_font(fnt_fanwood_sm);
			draw_set_color(c_white);
	
			draw_text(mouse_x+15, mouse_y+5, _card_name + " | Mana Cost: " + string(_card_cost));
			draw_text(mouse_x+15, mouse_y+20, _card_desc);	
			draw_text(mouse_x+15, mouse_y+35, _card_color);	
			draw_text(mouse_x+15, mouse_y+50, _card_type);	
			draw_text(mouse_x+15, mouse_y+60, _list);	
			draw_text(mouse_x+15, mouse_y+70, "requires " + _card_spec_req);				
			draw_text(mouse_x+15, mouse_y+80, "requires " + _card_class_req);	

	
		} 
		//////////////////
		// NOT HOVERING //
		//////////////////
		else {
			if(_active){
				draw_sprite_ext(sprite_index,0,x,y,0.4,0.4,0,c_white,1);
				draw_sprite_ext(spr_card_active,0,x,y,1.0,1.0,0,c_white,1);
			}
			else { //draw greyed if
				draw_sprite_ext(sprite_index,0,x,y,0.4,0.4,0,c_white,1);
			}
		}
	}
}