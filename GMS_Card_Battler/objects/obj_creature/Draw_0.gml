//////////////////////////////////////////////////////////////////////
//						OBJ_CREATURE DRAW							//
//																	//
// > DRAWS THE CREATURE'S SHADOW CIRCLE								//
//////////////////////////////////////////////////////////////////////
/////////////////////
// ANIMATION STATE //
/////////////////////
//if (_creature_sprite != undefined){
	switch (_creature_animation_state){
		case CREATURE_ANIMAITON_STATE.IDLE: //0,1,2
			image_speed = 0.3;
			if (image_index < 0 || image_index > 3){ 
				image_index = 0;
			}
		break;
	
		case CREATURE_ANIMAITON_STATE.ATTACK:
			image_speed = 0.7;		
			if (image_index > 6){ //3,4,5
				image_index = 0;
				_creature_animation_state = CREATURE_ANIMAITON_STATE.IDLE;
			}
		break;
	
		case CREATURE_ANIMAITON_STATE.HURT:
		image_speed = 0.7;
			if (image_index > 9){ //6,7,8
				image_index = 0;
				_creature_animation_state = CREATURE_ANIMAITON_STATE.IDLE;
			}			
		break;
	
		case CREATURE_ANIMAITON_STATE.DYING:
			image_speed = 0.7;
			if (image_index > 12){ //9,10,11
				image_index = 12;
				image_speed = 0;
				_creature_animation_state = CREATURE_ANIMAITON_STATE.DEAD;
			}
			
		break;	
	
		case CREATURE_ANIMAITON_STATE.DEAD: //12
			image_speed = 0;
			image_index = 12;
		break;		

	}
//}
draw_sprite(spr_creature_circle,0,x,y+32);

//////////////////////
// ENLARGE ON HOVER //
//////////////////////
if (_flag_has_died == false){
	//////////////////////////
	// SELECTION INDICATORS //
	//////////////////////////
	if (_selected_channel){
		draw_sprite(spr_creature_selected_channel,0,x,y);
	}

	if (_selected_target){
		draw_sprite(spr_creature_selected_target,0,x,y);
	}

	/////////////////
	// HOVER LOGIC //
	/////////////////
	if ((global.flag_gui_open == false) && position_meeting(mouse_x,mouse_y,self) && (global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CHANNEL || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_TARGET || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CARD)){
		//enlarges self
		if (_active){
			if (_creature_team == "Enemy"){
				draw_sprite_ext(sprite_index,-1,x,y,-0.5,0.5,0,c_white,1);
				draw_sprite_ext(spr_unit_active,0,x,y,1,1,0,c_white,1);
			}
			else{
				draw_sprite_ext(sprite_index,-1,x,y,0.5,0.5,0,c_white,1);
				draw_sprite_ext(spr_unit_active,0,x,y,1,1,0,c_white,1);
			}
		}
		else {
			if (_creature_team == "Enemy"){
				draw_sprite_ext(sprite_index,-1,x,y,-0.5,0.5,0,c_white,1);
			} else {
				draw_sprite_ext(sprite_index,-1,x,y,0.5,0.5,0,c_white,1);
			}
		
		}
	} 
	else {
		////////////////////////////////
		// DEFAULT STATE- NORMAL SIZE //
		////////////////////////////////
		if(_active){
			if (_creature_team == "Enemy"){
				draw_sprite_ext(sprite_index,-1,x,y,-0.25,0.25,0,c_white,1);
				draw_sprite_ext(spr_unit_active,0,x,y,-0.25,0.25,0,c_white,1);
				image_xscale = -1;
			}
			else {
				draw_sprite_ext(sprite_index,-1,x,y,0.25,0.25,0,c_white,1);
				draw_sprite_ext(spr_unit_active,0,x,y,0.25,0.25,0,c_white,1);
			}
		}
		else { //draw greyed if
			if (_creature_team == "Enemy"){
				draw_sprite_ext(sprite_index,-1,x,y,-0.25,0.25,0,c_white,1);
			}		
			else {
				draw_sprite_ext(sprite_index,-1,x,y,0.25,0.25,0,c_white,1);	
			}
		}
	}
} 
////////////////////////////////
// ENEMY DEAD - CHANGE SPRITE //
////////////////////////////////
else {
	if (_creature_team == "Enemy"){
		draw_sprite_ext(sprite_index,-1,x,y,-0.25,0.25,0,c_white,1);
	} else {
		draw_sprite_ext(sprite_index,-1,x,y,0.25,0.25,0,c_white,1);	
	}
}