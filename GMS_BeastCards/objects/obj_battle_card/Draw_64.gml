//
//
// DRAW_GUI: OBJ_BATTLE_CARD
//
//
if (!instance_exists(obj_gui_end_battle_pane)){
draw_self();
if (_team == "PLAYER"){
	_preview_card = undefined;
	_scale_x = 0.3;
	_scale_y = 0.3;	
	_preview_scale = 1.0;	
	if (_location != "HAND"){
		if (_location == "DISCARD"){
			draw_sprite_ext(spr_card_back,0,x,y,_scale_x,_scale_y,0,c_red,1);
		} else if (_location == "EXHAUST"){
			draw_sprite_ext(spr_card_back,0,x,y,_scale_x,_scale_y,0,c_gray,1);		
		} else {
			draw_sprite_ext(spr_card_back,0,x,y,_scale_x,_scale_y,0,c_white,1);
		}
	} else {
		// hover enlarge
		if position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), self)
		{
			_scale_x *= 1.15;
			_scale_y *= 1.15;
		    if (keyboard_check(vk_lcontrol)){
		        _preview_card = _sprite;
		    }
		
		}
		//DRAW GREY IF OOM FOR THIS CARD
		if (obj_battle_player_controller._player_state == PLAYER_STATE.SELECT_CARD && _card_oom_check == true){
			draw_sprite_ext(_sprite,0,x,y,_scale_x,_scale_y,0,c_ltgray,1);		
		} else {
			if (obj_battle_turn_controller._turn_tracker == 1){
				draw_sprite_ext(_sprite,0,x,y,_scale_x,_scale_y,0,c_ltgray,1);	
			} else {
				draw_sprite_ext(_sprite,0,x,y,_scale_x,_scale_y,0,c_white,1);
			}
		}
	} if (obj_battle_player_controller._player_state != PLAYER_STATE.SELECT_CARD){
		_card_oom_check = false;
	}
} 

else { //ENEMY 
	x = _ref_unit.x;
	if (_ref_unit._cur_hp <= 0){
		visible = false;
	} else {
		_preview_card = undefined;
		_scale_x = 0.15;
		_scale_y = 0.15;	
		_preview_scale = 1.0;	
		if (_location == "DECK"){
			visible=false;
		} else {
			if (obj_battle_enemy_controller._enemy_state == ENEMY_STATE.CAST_CARDS){
				
			} else {
				visible=true;
			}
			
			// hover enlarge
			if position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), self)
			{
				_scale_x *= 1.15;
				_scale_y *= 1.15;
			    if (keyboard_check(vk_lcontrol)){
			        _preview_card = _sprite;
			    }
		
			}		
			draw_sprite_ext(_sprite,0,x,y,_scale_x,_scale_y,0,c_white,1);
		}
	}
}
}