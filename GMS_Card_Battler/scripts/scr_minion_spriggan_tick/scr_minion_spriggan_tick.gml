//////////////////////////////////////////////////////////////////////
//						SCR_MINION_SPRIGGAN_TICK					//
//																	//
// > HEAL HOST FOR 2*STACK, DEAL 2*STACKS DAMAGE TO A RANDOM ENEMY  //	
//////////////////////////////////////////////////////////////////////
function scr_minion_spriggan_tick(_host,_self){
	///////////////
	// HEAL HOST //
	///////////////
	scr_heal_creature(_host,2*_self._minion_stacks,0);
	scr_create_combat_effect(_host,spr_effect_heal,0,0,44,c_white,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
	audio_play_sound(snd_effect_heal,0,false);	

	//////////////////////////////////
	// DEAL DAMAGE TO A RANDOM UNIT //
	//////////////////////////////////
	#region DAMAGE

		///////////////////
		// SELECT TARGET //
		///////////////////
		var _ref_tar_num = 0;
		var _ref_tar = undefined;
		if (ds_list_size(global.enemy_party_in_play) >0){
			_ref_tar_num = irandom_range(1,ds_list_size(global.enemy_party_in_play));
			_ref_tar = ds_list_find_value(global.enemy_party_in_play,_ref_tar_num-1);
			scr_create_combat_effect(_ref_tar,spr_effect_hit,0,0,9,c_white,1,1,0,0,0,"Stationary",undefined,"Effects");
		}
		
		////////////
		// DAMAGE //
		////////////
		if(_ref_tar != undefined){
			scr_damage_creature(_ref_tar,(2*_self._minion_stacks));
			audio_play_sound(snd_effect_hit,0,false);	
		}
	#endregion

	////////////
	// EFFECT //
	////////////
		//TODO
	
	///////////
	// SOUND //
	///////////
		//TODO
		
		
		
	///////////
	// DEBUG //
	///////////		
	show_debug_message("COMBAT: SPRIGGAN HEALED HOST AND DAMAGED RANDOM");		
}