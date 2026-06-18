//
//
// STEP:  | HANDLE PLAYER INTERACTION TO TRIGGER THE OPENING OF THE GUI
//
//


//
// HIGHLIGHT AND INTERACTION | IF PLAYER IS NEXT TO, HIGHLIGHT THE RANCH OBJ AND ALLOW INTERACTION
//
#region HIGHLIGHT AND INTERACTION
if (distance_to_object(obj_player) < 48 && global.pause == false){
	image_index = 1;
	
	//ALLOW FOR TRIGGERING AN INTERACTION
	#region E TO INTERACT
	if (_flag_triggered == false && _cooldown == 0){
		if (keyboard_check(ord("E"))){
			_flag_triggered = true;
			_cooldown = 60;
			
			scr_spawn_popup_text_bubble(x,y-50,"HEALED PARTY");
			for (var _i = 0; _i < ds_list_size(global.player_party); _i++){
				var _b = ds_list_find_value(global.player_party,_i);
				var _max = _b[?"beast_hp_max"];
				ds_map_replace(_b,"beast_hp_cur",_max);
			}
		}
	}
	#endregion
} else {
	image_index = 0;
}
#endregion

//
// COOLDOWN | COOLDOWN SO YOU CANT SPAM THE GUI AND HAVE IT OPEN MANY TIMES
//
#region COOLDOWN
if (_cooldown > 0){
	_cooldown--;	
	if (_cooldown <= 0){
		_cooldown = 0;
		_flag_triggered = false;	
	}
}
#endregion