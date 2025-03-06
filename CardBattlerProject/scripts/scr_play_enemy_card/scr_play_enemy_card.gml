//////////////////////////////////////////////////////////////////////
//						SCR_PLAY_ENEMY_CARD							//
//																	//
// > PLAYS THE ENEMY CARD BASED ON WHAT TYPE OF CARD IT IS.		    //
//////////////////////////////////////////////////////////////////////
function scr_play_enemy_card(_ref_unit){
	var _card = _ref_unit._ref_card;
	var _ref_card_scr = _card[?"script"];
		
	switch (_card[?"type"]){
		case "Attack":
			//pick a random enemy target
			var _ref_tar_num = irandom_range(1,ds_list_size(global.player_party_in_play));
			var _ref_tar = ds_list_find_value(global.player_party_in_play,_ref_tar_num-1);
			_ref_card_scr(_ref_tar);
		break;
		
		case "Defend":
			//pick self
			_ref_card_scr(_ref_unit);
		break;
		
		case "Heal":
			//pick lowest hp ally
			_ref_tar = _ref_unit;
			 for(var _i = 0; _i < ds_list_size(global.enemy_party_in_play); _i++){
				_cursor = ds_list_find_value(global.enemy_party_in_play, _i);
				if (_cursor._creature_hp_current < _ref_tar._creature_hp_current){
					_ref_tar = _cursor;
				}
			 }
			_ref_card_scr(_ref_tar);
		break;		
	}
}