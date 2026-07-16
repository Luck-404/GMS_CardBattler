//===============================================================================//
//
// STEP: OBJ_HEALING_POOL_INTERACTABLE
// FUNCTION: Heals all party beasts when the player interacts.
//
//===============================================================================//

//
// HIGHLIGHT AND INTERACTION
//
#region HIGHLIGHT AND INTERACTION
if (distance_to_object(obj_player) < 48 && !global.flag_pause){

	image_index = 1;

	if (!_flag_triggered && _cooldown == 0){

		if (keyboard_check(ord("E"))){
			audio_play_sound(snd_heal,0,false);
			_flag_triggered = true;
			_cooldown = 60;

			scr_spawn_popup_text_bubble(x,y - 50,"HEALED PARTY");

			for (var _it_beast = 0; _it_beast < ds_list_size(global.list_player_party); _it_beast++){

				var _stct_beast = ds_list_find_value(global.list_player_party,_it_beast);

				if (_stct_beast == undefined){
					continue;
				}

				_stct_beast._val_beast_hp_cur = _stct_beast._val_beast_hp_max;
			}
		}
	}
}
else{
	image_index = 0;
}
#endregion

//
// COOLDOWN
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