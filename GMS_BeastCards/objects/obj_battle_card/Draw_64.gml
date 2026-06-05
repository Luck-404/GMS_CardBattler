//
//
// DRAW_GUI: OBJ_BATTLE_CARD
//
//
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
		if position_meeting(mouse_x, mouse_y, self)
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
			draw_sprite_ext(_sprite,0,x,y,_scale_x,_scale_y,0,c_white,1);
		}
	} if (obj_battle_player_controller._player_state != PLAYER_STATE.SELECT_CARD){
		_card_oom_check = false;
	}
} 

else { //ENEMY 
	_preview_card = undefined;
	_scale_x = 0.15;
	_scale_y = 0.15;	
	_preview_scale = 1.0;	
	if (_location == "DECK"){
		visible=false;
	} else {
		visible=true;
		
		// hover enlarge
		if position_meeting(mouse_x, mouse_y, self)
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