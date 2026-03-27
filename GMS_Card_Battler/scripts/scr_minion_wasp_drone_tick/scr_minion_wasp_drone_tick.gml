//////////////////////////////////////////////////////////////////////
//					SCR_MINION_LIFE_SPIRIT_TICK						//
//																	//
// > HEAL A UNIT FOR 20% MAX HP										//	
//////////////////////////////////////////////////////////////////////
function scr_minion_wasp_drone_tick(_host,_self){
	///////////////////
	// SELECT TARGET //
	///////////////////
	var _ref_tar_num = 0;
	var _ref_tar = undefined;
	if (ds_list_size(global.enemy_party_in_play) > 0){
		_ref_tar_num = irandom_range(1,ds_list_size(global.enemy_party_in_play));
		_ref_tar = ds_list_find_value(global.enemy_party_in_play,_ref_tar_num-1);
		////////////
		// POISON //
		////////////
		var _counter = scr_get_status_counter(_ref_tar,"General",undefined,"Poison");		
		if (_counter == undefined){		
			scr_create_status_counter(_ref_tar,"Poison","Target is poisoned for 3 turns","Reaction","End",scr_status_poison_tick, false, undefined, 3, 1, "3 + (stacks)", 0, "General", _ref_tar._creature_statuses, spr_status_poison);
			_ref_tar._status_poisoned = true;	
			scr_create_combat_popup(_ref_tar,"Poisoned","Poison",0,0);
		} 
		else {
			_counter._counter_life = 3;
			_counter._counter_stacks+= 1;
		}
		
		////////////
		// EFFECT //
		////////////		
		scr_create_combat_effect(_ref_tar,spr_effect_dripping,0,0,36,c_lime,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");

	}
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_debuff,0,false);
		
		
		
	///////////
	// DEBUG //
	///////////		
	show_debug_message("WASP POISONED RANDOM");
}