//////////////////////////////////////////////////////////////////////
//						OBJ_CURSOR DRAW								//
//																	//
// > DRAW SWORD CURSORS OVER TARGETS THAT WILL BE HIT BY A SPELL    //
//////////////////////////////////////////////////////////////////////
if(global.player_enc_state == PLAYER_ENCOUNTER_STATE.PICK_TARGET){
	switch (_target_count){
		case 0:
	
		break;
	
		case 1:
			if (position_meeting(mouse_x,mouse_y,obj_creature)){
				var _creature = instance_nearest(mouse_x,mouse_y,obj_creature);
				if (_creature._active == true){
					//draw sword over the unit
					draw_sprite(spr_hover_sword,-1,_creature.x,_creature.y-200);
				}
			}
		break;
	
		case 3:
			if (position_meeting(mouse_x,mouse_y,obj_creature)){		
				var _creature = instance_nearest(mouse_x,mouse_y,obj_creature);
				if (_creature._active == true){
					//draw sword over the unit
					draw_sprite(spr_hover_sword,-1,_creature.x,_creature.y-400);
					//left
					if(_creature._left_unit != undefined){
						draw_sprite(spr_hover_sword,-1,_creature._left_unit.x,_creature._left_unit.y-400);		
					}
					//right
					if(_creature._right_unit != undefined){
						draw_sprite(spr_hover_sword,-1,_creature._right_unit.x,_creature._right_unit.y-400);	
					}
				}
			}
		break;
	
		case 5:
		if (position_meeting(mouse_x,mouse_y,obj_creature)){
			var _creature = instance_nearest(mouse_x,mouse_y,obj_creature);
			var _list = undefined;
			
			if (_creature._creature_team == "Player"){
				_list = global.player_party_in_play;	
			} else {
				_list = global.enemy_party_in_play;
			}

			if (_creature._active == true){
				for (var _i = 0; _i < ds_list_size(_list); _i++){
					var _list_creature = ds_list_find_index(_list,_i);
					draw_sprite(spr_hover_sword,-1,_list_creature.x,_list_creature.y-400);
				}
			}
		}
		break;
	}
} 

else {
	instance_destroy();	
}