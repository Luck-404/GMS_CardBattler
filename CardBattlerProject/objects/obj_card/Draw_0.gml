//////////////////////////////////////////////////////////////////////
//							OBJ_CARD DRAW							//
//																	//
// > HANDLE MAKING THE CARD REF INTO AN OBJ CARD- CARRY OVER THESE  //
//   DEFINITIONS													//
//////////////////////////////////////////////////////////////////////

if (_reward == false){
	if (_list == "destroy"){
		draw_sprite_ext(sprite_index,2,x,y,0.01,0.01,0,c_white,0);
		image_index = 2;
		image_speed = 0;
		_reward = false;
	}
	
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
			//draw info
			draw_set_font(fnt_fanwood_sm);
			draw_set_color(c_black);
			var _tooltip_x = 1420;
			var _tooltip_y = 838;
			var _output_str = "";
			
			_output_str += _card_name + "\n";
			_output_str += string(_card_desc) + "\n";
			_output_str += "Mana Cost: " + string(_card_cost) + "\n";			
			_output_str += _card_color + "\n";
			_output_str += "Type: " + _card_type + "\n";
			_output_str += "Spec Req: " + _card_spec_req + "\n";
			_output_str += "Class Req: " + _card_class_req + "\n";

			//draw final tooltip;
			draw_text_ext(_tooltip_x,_tooltip_y,_output_str,15,150);
		} 
		//////////////////
		// NOT HOVERING //
		//////////////////
		else {
			y = 952;
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