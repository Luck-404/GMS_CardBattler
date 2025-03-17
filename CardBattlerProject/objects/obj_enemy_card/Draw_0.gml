//////////////////////////////////////////////////////////////////////
//						OBJ_ENEMY_CARD DRAW							//
//																	//
// > DRAW HOVER INFORMATION											//
//////////////////////////////////////////////////////////////////////
if (global.player_enc_state!=PLAYER_ENCOUNTER_STATE.EXIT_ENC){
	if ((global.flag_gui_open == false) && position_meeting(mouse_x,mouse_y,self) && (global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CHANNEL || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_TARGET || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CARD)){
		//enlarges card
		draw_sprite_ext(_card_sprite,0,x,y,0.5,0.5,0,c_white,1);
	
		//draw info
		draw_set_font(fnt_fanwood_sm);
		draw_set_color(c_black);
		var _tooltip_x = 1420;
		var _tooltip_y = 838;
		var _output_str = "";
			
		_output_str += _card_name + "\n";
		_output_str += string(_card_desc) + "\n";		
		_output_str += _card_color + "\n";
		_output_str += "Type: " + _card_type + "\n";

		//draw final tooltip;
		draw_text_ext(_tooltip_x,_tooltip_y,_output_str,15,150);
	
	} else {
		draw_sprite_ext(_card_sprite,0,x,y,0.2,0.2,0,c_white,1);
	}
}