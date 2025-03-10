//////////////////////////////////////////////////////////////////////
//							OBJ_MINION DRAW							//
//																	//
// > DRAWS THE MINION'S SHADOW CIRCLE								//
//////////////////////////////////////////////////////////////////////
draw_self();
if (_minion_unit_attached != undefined){
	var _x_pos = _minion_unit_attached.x;
	var _y_pos = _minion_unit_attached.y;


	if(_minion_unit_attached._creature_minion_limit == 3){
		if (_minion_team = "Enemy"){
			switch(_minion_position){
				case 0:
					x = _x_pos - 64;
					y = _y_pos + 100;		
				break;
			
				case 1:
					x = _x_pos;
					y = _y_pos + 100;			
				break;
			
				case 2:
					x = _x_pos + 64;
					y = _y_pos + 100;							
				break;
			}
		} else {
			switch(_minion_position){
				case 0:
	
					x = _x_pos + 64;
					y = _y_pos + 100;						
				break;
			
				case 1:
					x = _x_pos;
					y = _y_pos + 100;			
				break;
			
				case 2:
					x = _x_pos - 64;
					y = _y_pos + 100;				
				break;	
			}
		}
	}
	
	else if(_minion_unit_attached._creature_minion_limit == 5){
		if (_minion_team = "Enemy"){		
			switch(_minion_position){
					case 0:
						x = _x_pos - 64;
						y = _y_pos + 100;							
					break;
			
					case 1:
						x = _x_pos-32;
						y = _y_pos+130;								
					break;
			
					case 2:
						x = _x_pos;
						y = _y_pos+100;						
					break;
			
					case 3:
						x = _x_pos+32;
						y = _y_pos+130;							
					break;

					case 4:
						x = _x_pos+64;
						y = _y_pos+100;							
					break;
				}
		} 
		else {
			switch(_minion_position){
					case 0:
						x = _x_pos+64;
						y = _y_pos+100;		
					break;
			
					case 1:
						x = _x_pos+32;
						y = _y_pos+130;								
					break;
			
					case 2:
						x = _x_pos;
						y = _y_pos+100;						
					break;
			
					case 3:
						x = _x_pos-32;
						y = _y_pos+130;					
					break;

					case 4:
						x = _x_pos - 64;
						y = _y_pos + 100;				
					break;
				}
			}
	}	
	
draw_sprite(spr_minion_circle,0,x,y+16);	

////////////////////////
// HOVER INTERACTIONS //
////////////////////////
if ((global.flag_gui_open == false) && position_meeting(mouse_x,mouse_y,self) && (global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CHANNEL || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_TARGET || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CARD)){
	draw_sprite_ext(_minion_sprite,0,x,y,0.3,0.3,0,c_white,1);
} else { 
	draw_sprite_ext(_minion_sprite,0,x,y,0.2,0.2,0,c_white,1);
}
	
	
	//leech icon
	if(_minion_name == "Bloodbeak" || _minion_name == "Serpent"){
		draw_sprite(spr_leech,0,_minion_unit_attached.x-60, _minion_unit_attached.y - 98);
	}
}