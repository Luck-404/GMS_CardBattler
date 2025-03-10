//////////////////////////////////////////////////////////////////////
//						SCR_PLAY_ENEMY_CARD							//
//																	//
// > PLAYS THE ENEMY CARD BASED ON WHAT TYPE OF CARD IT IS.		    //
//////////////////////////////////////////////////////////////////////
function scr_play_enemy_card(_ref_unit,_playing_card){
	//////////////////
	// GET CARD REF //
	//////////////////
	var _card_ref = _playing_card._card_ref;
	var _card_ran = _playing_card._card_range;
	var _ref_card_scr = _card_ref[?"script"];
	
	
	
	switch (_card_ref[?"type"]){
		/////////////
		// ATTACKS //
		/////////////
		case "Attack":
			if(_card_ran == "Melee"){ //pick front target
				var _ref_tar = ds_list_find_value(global.player_party_in_play,0);
				_ref_card_scr(_card_ref,_ref_unit,_ref_tar);
			}
			
			else {
			//pick a random enemy target
			var _ref_tar_num = irandom_range(1,ds_list_size(global.player_party_in_play));
			var _ref_tar = ds_list_find_value(global.player_party_in_play,_ref_tar_num-1);
			_ref_card_scr(_card_ref,_ref_unit,_ref_tar);
			}
		break;
		
		
		
		/////////////
		// DEFENSE //
		/////////////		
		case "Defend":
			//pick self
			_ref_card_scr(_card_ref,_ref_unit,_ref_unit);
		break;
		
		
		/////////////
		// UTILITY //
		/////////////		
		case "Utility":
			if (_card_ran == "Self"){ //play on self
				_ref_card_scr(_card_ref,_ref_unit,_ref_unit);
			}
			
			else {
			//pick a random ally target
				var _ref_tar_num = irandom_range(1,ds_list_size(global.enemy_party_in_play));
				var _ref_tar = ds_list_find_value(global.enemy_party_in_play,_ref_tar_num-1);
				_ref_card_scr(_card_ref,_ref_unit,_ref_tar);
			}
		break;
		
		
		///////////
		// BUFFS //
		///////////		
		case "Buff":
			//pick self
			_ref_card_scr(_card_ref,_ref_unit,_ref_unit);
		break;
		
		
		
		/////////
		// DOT //
		/////////	
		case "DoT":
			if(_card_ran == "Melee"){ //pick front target
				var _ref_tar = ds_list_find_value(global.player_party_in_play,0);
				_ref_card_scr(_card_ref,_ref_unit,_ref_tar);
			}
			else {
				//pick a random enemy target
				var _ref_tar_num = irandom_range(1,ds_list_size(global.player_party_in_play));
				var _ref_tar = ds_list_find_value(global.player_party_in_play,_ref_tar_num-1);
				_ref_card_scr(_card_ref,_ref_unit,_ref_tar);
			}
		break;		
		
		
		
		///////////
		// HEALS //
		///////////
		case "Heal":
			//pick lowest hp ally
			var _ref_tar = _ref_unit;
			 for(var _i = 0; _i < ds_list_size(global.enemy_party_in_play); _i++){
				_cursor = ds_list_find_value(global.enemy_party_in_play, _i);
				if ((_cursor._creature_hp_current/_cursor._creature_hp_max) < (_ref_tar._creature_hp_current/_ref_tar._creature_hp_max)){
					_ref_tar = _cursor;
				}
			 }
			_ref_card_scr(_card_ref,_ref_unit,_ref_tar);
		break;		
		
		///////////////
		// ARCHETYPE //
		///////////////
		case "Archetype":
			if (_card_ran == "Targetless"){ //
				_ref_card_scr(_card_ref,_ref_unit,_ref_unit);
			} else { //play on self
				_ref_card_scr(_card_ref,_ref_unit,_ref_unit);
			}
		break;		
	}
	
	
	
	///////////////////////////////////////
	// PUT CARD INTO BACK OF UNIT'S DECK //
	///////////////////////////////////////
	ds_list_add(_ref_unit._deck,_card_ref);
	ds_list_delete(_ref_unit._deck,0);
	instance_destroy(_playing_card);
	_ref_unit._card_to_play = undefined;	
}