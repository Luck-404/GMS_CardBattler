//////////////////////////////////////////////////////////////////////
//						OBJ_CARD DRAW GUI							//
//																	//
// > DRAW REWARD CARD SPRITE										//
//////////////////////////////////////////////////////////////////////
if (_reward){
	draw_self();	
}

//////////////////////////////////
// HOVER TOOLTIPS AND ENLARGING //
//////////////////////////////////
if (_list == "hand"){
	if (global.flag_gui_open == false && position_meeting(mouse_x,mouse_y,self) && (global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CHANNEL || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_TARGET || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CARD)){
			y = 952-60;
		//enlarges card
		if (_active){

			draw_sprite_ext(sprite_index,0,x,y,0.6,0.6,0,c_white,1);
			draw_sprite_ext(spr_card_active,0,x,y,1,1,0,c_white,1);
		}
		else {
			draw_sprite_ext(sprite_index,0,x,y,0.6,0.6,0,c_white,1);
		}
	} 
}