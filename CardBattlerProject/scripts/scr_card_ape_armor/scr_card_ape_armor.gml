//////////////////////////////////////////////////////////////////////
//							SCR_CARD_APE_ARMOR						//
//																	//
// > CAST A SHIELD ON SELF											//
//////////////////////////////////////////////////////////////////////
function scr_card_ape_armor(_card,_channel,_target){

	/////////////
	// DEFENSE //
	/////////////
		var _ab_check = scr_check_armorbreak(_target);
		if (_ab_check == false){
			//double armor if you have at least 10
			if (_target._creature_def >= 10){
				_target._creature_def+=_target._creature_def;
				scr_create_combat_popup(_target,string(_target._creature_def),"Shields",0,0);
			}
			//else add 10
			else {
				var _diff = 10-_target._creature_def;
				_target._creature_def = 10;
				scr_create_combat_popup(_target,string(_diff),"Shields",0,0);
			}
		}
	
		//add 10 to each ally
		var _list = undefined;
		if (_target._creature_team == "Player"){
			_list = global.player_party_in_play;
		} else {
			_list = global.enemy_party_in_play
		}
	
		for (var _i = 0; _i < ds_list_size(_list); _i++){
		var _unit = ds_list_find_value(_list,_i);
			if (_unit != _target){
				var _ab_check2 = scr_check_armorbreak(_unit);
				if(_ab_check2 == false){
					_unit._creature_def += 10;
					scr_create_combat_popup(_unit,"10","Shields",0,0);
				}
			}
		
		}

	scr_trigger_global_reactions(_card,_target,_channel,0);	
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_shield,0,0,_card._card_animation_time,c_green,0.3,0.3,undefined,undefined,undefined,undefined,undefined,"Stationary",undefined,"Effects");

	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_ape_armor,0,false);
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);

	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);	
}