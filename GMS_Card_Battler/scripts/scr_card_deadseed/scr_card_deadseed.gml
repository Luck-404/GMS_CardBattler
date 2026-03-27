//////////////////////////////////////////////////////////////////////
//						scr_card_deadseed						//
//																	//
// > SUMMON deadseed
//////////////////////////////////////////////////////////////////////
function scr_card_deadseed(_card,_channel,_target){
	var _count = 0;
	// each dead ally
		for (var _i = 0; _i < ds_list_size(global.player_party_dead); _i++){
			_count++;
			var _unit = ds_list_find_value(global.player_party_dead, _i);
			
			//determine unit spec
			var _deadspec = _unit._creature_spec;
			
			switch(_deadspec){
				case "Martial":
				var _new_minion = scr_create_combat_minion(_card,_channel,_target,"Deadseed",["Martial"]);
				break;
				
				case "Technical":
				_new_minion = scr_create_combat_minion(_card,_channel,_target,"Deadseed",["Technical"]);
				break;
				
				case "Magical":
				_new_minion = scr_create_combat_minion(_card,_channel,_target,"Deadseed",["Magical"]);
				break;
			}
			
			//make a beam from target to channeler
			scr_create_combat_effect(undefined,spr_card_invis,_unit.x,_unit.y,15,c_white,0.1,0.1,_channel.x,_channel.y,0,"Beam",undefined,"Effects");
		}
		
	// each dead enemy
		for (var _i = 0; _i < ds_list_size(global.enemy_party_dead); _i++){
			_count++;
			var _unit = ds_list_find_value(global.enemy_party_dead, _i);
			
			//determine unit spec
			var _deadspec = _unit._creature_spec;
			
			switch(_deadspec){
				case "Martial":
				var _new_minion = scr_create_combat_minion(_card,_channel,_target,"Deadseed",["Martial"]);
				break;
				
				case "Technical":
				_new_minion = scr_create_combat_minion(_card,_channel,_target,"Deadseed",["Technical"]);
				break;
				
				case "Magical":
				_new_minion = scr_create_combat_minion(_card,_channel,_target,"Deadseed",["Magical"]);
				break;
			}
			
			//make a beam from target to channeler
			scr_create_combat_effect(undefined,spr_card_invis,_unit.x,_unit.y,15,c_white,0.1,0.1,_channel.x,_channel.y,0,"Beam",undefined,"Effects");
		}
	
	if (_count == 0){
		var _deadspec = choose("Martial","Technical","Magical");
		switch(_deadspec){
			case "Martial":
			var _new_minion = scr_create_combat_minion(_card,_channel,_target,"Deadseed",["Martial"]);
			break;
				
			case "Technical":
			_new_minion = scr_create_combat_minion(_card,_channel,_target,"Deadseed",["Technical"]);
			break;
				
			case "Magical":
			_new_minion = scr_create_combat_minion(_card,_channel,_target,"Deadseed",["Magical"]);
			break;
		}
	}
	scr_create_combat_effect(undefined,spr_effect_minion_poof,_channel.x,_channel.y+110,18,c_white,0.8,0.8,0,0,0,"Stationary",undefined,"Effects");
	scr_trigger_global_reactions(_card,_target,_channel,0);


	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_siphon,0,false);
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
	
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);		
}