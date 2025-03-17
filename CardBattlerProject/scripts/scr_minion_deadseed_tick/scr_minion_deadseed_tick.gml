//////////////////////////////////////////////////////////////////////
//					scr_minion_deadseed_tick						//
//																	//
// > scr_minion_deadseed_tick
//////////////////////////////////////////////////////////////////////
function scr_minion_deadseed_tick(_host,_self){
	///////////////////
	// SELECT TARGET //
	///////////////////
	var _ref_tar_num = 0;
	var _ref_tar = undefined;
	if (ds_list_size(global.enemy_party_in_play) > 0){
		_ref_tar_num = irandom_range(1,ds_list_size(global.enemy_party_in_play));
		_ref_tar = ds_list_find_value(global.enemy_party_in_play,_ref_tar_num-1);
		
		switch(_self._minion_notes[0]){
			case "Martial":
				////////////
				// DAMAGE //
				////////////
				scr_damage_creature(_ref_tar, 3);
		
				////////////
				// EFFECT //
				////////////
				scr_create_combat_effect(_ref_tar,spr_effect_hit,0,0,9,c_lime,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
				audio_play_sound(snd_effect_hit,0,false);	
	
			break;
			
			case "Technical":
				///////////
				// BLEED //
				///////////
				if (_ref_tar._creature_def == 0){
					var _counter3 = scr_get_status_counter(_ref_tar,"General",undefined,"Bleed");		
					if (_counter3 == undefined){		
						scr_create_status_counter(_ref_tar,"Bleed","Target is bleeding for 5 turns.",_card,"End",scr_status_bleed_tick, false, undefined, 5, 1, "2*(stacks)", 0, "General", _ref_tar._creature_statuses, spr_status_bleed);
						_ref_tar._status_bleeding = true;
						scr_create_combat_popup(_ref_tar,"Bleeding","Damage",0,0);
						scr_create_combat_effect(_ref_tar,spr_effect_dripping,0,0,17,c_red,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");					
					} 
					else {
						_counter3._counter_life = 5;
						_counter3._counter_stacks += 1;
					}
				} 
				else {
					scr_create_combat_popup(_ref_tar,"Shield blocked bleed","Default",0,0);
				}
				audio_play_sound(snd_effect_debuff,0,false);	
			break;
			
			case "Magical":
				////////////
				// POISON //
				////////////
				var _counter3 = scr_get_status_counter(_ref_tar,"General",undefined,"Poison");		
				if (_counter3 == undefined){		
					scr_create_status_counter(_ref_tar,"Poison","Target is poisoned for 3 turns","Reaction","End",scr_status_poison_tick, false, undefined, 3, 1, "3 + (stacks)", 0, "General", _ref_tar._creature_statuses, spr_status_poison);
					_ref_tar._status_poisoned = true;	
					scr_create_combat_popup(_ref_tar,"Poisoned","Poison",0,0);
					scr_create_combat_effect(_ref_tar,spr_effect_dripping,0,0,17,c_lime,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
					audio_play_sound(snd_effect_debuff,0,false);					
				} 
				else {
					_counter3._counter_life = 3;
					_counter3._counter_stacks+= 1;
				}
				audio_play_sound(snd_effect_debuff,0,false);	
			break;
		}

	}

		
		
		
	///////////
	// DEBUG //
	///////////		
	show_debug_message("DEADSEED HIT");
}