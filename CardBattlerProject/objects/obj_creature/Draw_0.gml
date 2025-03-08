//////////////////////////////////////////////////////////////////////
//						OBJ_CREATURE DRAW							//
//																	//
// > DRAWS THE CREATURE'S SHADOW CIRCLE								//
//////////////////////////////////////////////////////////////////////
draw_sprite(spr_creature_circle,0,x,y+32);
if (_flag_has_died == false){
	if (_selected_channel){
		draw_sprite(spr_creature_selected_channel,0,x,y);
	}

	if (_selected_target){
		draw_sprite(spr_creature_selected_target,0,x,y);
	}

	////////////////////////
	// HOVER INTERACTIONS //
	////////////////////////
	if ((global.flag_gui_open == false) && position_meeting(mouse_x,mouse_y,self) && (global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CHANNEL || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_TARGET || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CARD)){
		//enlarges self
		if (_active){
			if (_creature_team == "Enemy"){
				draw_sprite_ext(sprite_index,0,x,y,-1.5,1.5,0,c_white,1);
				draw_sprite_ext(spr_unit_active,0,x,y,1,1,0,c_white,1);
			}
			else{
				draw_sprite_ext(sprite_index,0,x,y,1.5,1.5,0,c_white,1);
				draw_sprite_ext(spr_unit_active,0,x,y,1,1,0,c_white,1);
			}
		}
		else {
			if (_creature_team == "Enemy"){
				draw_sprite_ext(sprite_index,0,x,y,-1.5,1.5,0,c_white,1);
			} else {
				draw_sprite_ext(sprite_index,0,x,y,1.5,1.5,0,c_white,1);
			}
		
		}
	} 
	else {
		if(_active){
			draw_self();
			if (_creature_team == "Enemy"){
				image_xscale = -1;
			}
			draw_sprite_ext(spr_unit_active,0,x,y,1,1,0,c_white,1);
		}
		else { //draw greyed if
			if (_creature_team == "Enemy"){
				draw_sprite_ext(sprite_index,0,x,y,-1.0,1.0,0,c_white,1);
			}		
			else {
				draw_sprite_ext(sprite_index,0,x,y,1.0,1.0,0,c_white,1);	
			}
		}
	}
} else {
	draw_self();
	if (_creature_team == "Enemy"){
		image_xscale = -1;
	}
	draw_sprite_ext(sprite_index,1,x,y,1,1,0,c_white,1);
}