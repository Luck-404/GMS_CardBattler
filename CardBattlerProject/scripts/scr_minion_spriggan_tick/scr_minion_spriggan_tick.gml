//////////////////////////////////////////////////////////////////////
//						SCR_MINION_SPRIGGAN_TICK					//
//																	//
// > HEAL HOST FOR 2*STACK, DEAL 2*STACKS DAMAGE TO A RANDOM ENEMY  //	
//////////////////////////////////////////////////////////////////////
function scr_minion_spriggan_tick(_host,_self){
	///////////////
	// HEAL HOST //
	///////////////
	#region HEAL
		//////////
		// HEAL //
		//////////
		_host._creature_hp_current += (2*_self._stacks); //add the hp		
		
		if (_host._creature_hp_current > _host._creature_hp_max){ //check for overflow (hp above 100%)
			_host._creature_hp_current = _host._creature_hp_max;
		}
		
		//////////////////
		// COMBAT POPUP //
		//////////////////
		scr_create_combat_popup(_host,string((2*_self._stacks)),"Healing",0,0);

		////////////
		// EFFECT //
		////////////
		scr_create_combat_effect(_host,spr_effect_grow_natures_remedy,0,0);
	
		///////////
		// SOUND //
		///////////
		audio_play_sound(snd_effect_natures_remedy,0,false);	
	#endregion
	
	
	
	//////////////////////////////////
	// DEAL DAMAGE TO A RANDOM UNIT //
	//////////////////////////////////
	#region DAMAGE
	///////////////////
	// SELECT TARGET //
	///////////////////
	var _ref_tar_num = 0;
	var _ref_tar = undefined;
	if (_self._minion_team == "Player"){ //player - look for enemy to attack
		if (ds_list_size(global.enemy_party_in_play) >0){
			_ref_tar_num = irandom_range(1,ds_list_size(global.enemy_party_in_play));
			_ref_tar = ds_list_find_value(global.enemy_party_in_play,_ref_tar_num-1);
		}
	} 
	else { //enemy - look for player to attack
		if (ds_list_size(global.player_party_in_play) > 0){
			_ref_tar_num = irandom_range(1,ds_list_size(global.player_party_in_play));
			_ref_tar = ds_list_find_value(global.player_party_in_play,_ref_tar_num-1);
		}
	}
		
	////////////
	// DAMAGE //
	////////////
	scr_damage_creature(_ref_tar,(2*_self._stacks));

	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_ref_tar,spr_effect_strike,0,0);
		
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_strike,0,false);		
	#endregion	
}