//////////////////////////////////////////////////////////////////////
//						SCR_INIT_ENEMY_DECK							//
//																	//
// > GIVE UP TO 5 CARDS TO EACH CREATURE							//
//////////////////////////////////////////////////////////////////////
function scr_init_enemy_deck(_creature,_ref_creature_name){
var _card_2 = scr_load_card("Block");
ds_list_add(_creature._deck, _card_2);

//switch(_ref_creature_name){
//		#region	Bush Monkey
//		case "Bush Monkey": //GREEN MARTIAL ADVENTURER
//			var _arr = ["Strike","Block","Block","Thorny Whip","Thorny Whip"];
//			var _tmp_list = ds_list_create();			
//			for (var _i = 0; _i < array_length(_arr); _i++){
//				var _new_card = scr_load_card(_arr[_i]);		
//				ds_list_add(_tmp_list, _new_card);
//			}

//			while (ds_list_size(_tmp_list) > 0){
//				//pull from a random card in tmplist,
//				var _index = irandom_range(0,ds_list_size(_tmp_list)-1);
//				var _final_card = ds_list_find_value(_tmp_list,_index);
//				// add to deck
//				ds_list_add(_creature._deck,_final_card);	
//				//remove from tmplist 
//				ds_list_delete(_tmp_list, _index);	
//			}
//		break;
//		#endregion
		
		
		
//		#region Corpseflower
//		case "Corpseflower": //GREEN MAGICAL SUMMONER
//			_arr = ["Nature's Remedy","Poison Ivy","Poison Ivy","Life Spirit","Bramblet"];
//			_tmp_list = ds_list_create();			
//			for (var _i = 0; _i < array_length(_arr); _i++){
//				var _new_card = scr_load_card(_arr[_i]);		
//				ds_list_add(_tmp_list, _new_card);
//			}

//			while (ds_list_size(_tmp_list) > 0){
//				//pull from a random card in tmplist,
//				var _index = irandom_range(0,ds_list_size(_tmp_list)-1);
//				var _final_card = ds_list_find_value(_tmp_list,_index);
//				// add to deck
//				ds_list_add(_creature._deck,_final_card);	
//				//remove from tmplist 
//				ds_list_delete(_tmp_list, _index);	
//			}
//		break;
//		#endregion
		
		
		
//		#region Furn
//		case "Furn": //GREEN TECHNICAL HUNTER
//			_arr = ["Strike","Fell","Fell","Strike","Thorny Whip","Bloodbeak"];
//			_tmp_list = ds_list_create();			
//			for (var _i = 0; _i < array_length(_arr); _i++){
//				var _new_card = scr_load_card(_arr[_i]);		
//				ds_list_add(_tmp_list, _new_card);
//			}

//			while (ds_list_size(_tmp_list) > 0){
//				//pull from a random card in tmplist,
//				var _index = irandom_range(0,ds_list_size(_tmp_list)-1);
//				var _final_card = ds_list_find_value(_tmp_list,_index);
//				// add to deck
//				ds_list_add(_creature._deck,_final_card);	
//				//remove from tmplist 
//				ds_list_delete(_tmp_list, _index);	
//			}				
//		break;
//		#endregion	
//	}
}