//
//
// OBJ_TREASURE_CHEST
//
//

//
// VARIABLES
//
_loot_amount = irandom_range(2,3);

_flag_triggered = false;

_rand_x = irandom_range(-48,48);
_rand_y = irandom_range(-48,48);

//
// INIT
//
// PERSIST OPENED STATE
if (ds_map_exists(global.player_chests_opened, _chest_id))
{
    _flag_triggered = true;
    image_index = 1;
}

else if (_chest_id == "RANDOM_CHEST"){
	scr_roll_random_chest();
}


//
// METHODS
//
#region METHODS
//
// INIT A RANDOM CHEST
// 
function scr_roll_random_chest(){
	_rarity = choose("I","I","I","I","I","I","II","II","II","III");
	
	switch(_rarity){
		case "I":
		_color = c_white;
		break;
		case "II":
		_color = c_lime;
		break;
		case "III":
		_color = c_aqua;
		break;
	}	
}
	
//
// AWARDS A TREASURE OF A PRESET CHEST
//
function scr_award_treasure_chest_loot(){
	//BASED ON CHEST ID, GET INFO FROM THE SPECIAL LOOT TABLE SCRIPT
	var _rewards = scr_get_chest_custom_loot(_chest_id);
	for (var _j = 0; _j < array_length(_rewards); _j++){
		var _focus = _rewards[_j];
		if (!is_string(_focus)){
			//POPUP GOLD GAINED			
			global.player_gold += _focus;
			_rand_x = irandom_range(-48,48);
			_rand_y = irandom_range(-48,48);			
			scr_spawn_popup("TEXT",string(_focus)+"gp",undefined,c_yellow,obj_player.x+_rand_x,obj_player.y+_rand_y);		
		}
		else {
			_new_card = scr_get_card_info(_focus);	
			scr_add_card_to_deck(_new_card);
			
			//POPUP NEW CARD GAINED
			_rand_x = irandom_range(-48,48);
			_rand_y = irandom_range(-48,48);
			scr_spawn_popup("TEXT","+"+_new_card[?"card_name"],undefined,c_white,obj_player.x+_rand_x,obj_player.y+_rand_y);
		}
	}
	
}

//
// AWARDS A TREASURE OF THE APPROPRAITE RARITY FROM THE GLOBAL POOLS IF RANDOM
//
function scr_roll_treasure_chest_reward(){
	switch(_rarity){
		#region I
		case "I":
			//GIVE 2-3 BASIC CARDS
			for (var _i = 0; _i < _loot_amount; _i++){
				_card_roll = irandom_range(0,ds_list_size(global.rarity_I_cards)-1);
				_card_name = ds_list_find_value(global.rarity_I_cards,_card_roll);
				_new_card = scr_get_card_info(_card_name);
				scr_add_card_to_deck(_new_card);
			
				//POPUP NEW CARD GAINED
				_rand_x = irandom_range(-48,48);
				_rand_y = irandom_range(-48,48);
				scr_spawn_popup("TEXT","+"+_card_name,undefined,c_white,obj_player.x+_rand_x,obj_player.y+_rand_y);
			}
			
			//POPUP GOLD GAINED
			global.player_gold += 50;
			_rand_x = irandom_range(-48,48);
			_rand_y = irandom_range(-48,48);			
			scr_spawn_popup("TEXT","500gp",undefined,c_yellow,obj_player.x+_rand_x,obj_player.y+_rand_y);			
		break;
		#endregion
		
		#region II
		case "II":
			//GIVE 2-3 BASIC CARDS
			for (var _i = 0; _i < _loot_amount; _i++){
				_card_roll = irandom_range(0,ds_list_size(global.rarity_I_cards)-1);
				_card_name = ds_list_find_value(global.rarity_I_cards,_card_roll);
				_new_card = scr_get_card_info(_card_name);
				scr_add_card_to_deck(_new_card);
			
				//POPUP NEW CARD GAINED
				_rand_x = irandom_range(-48,48);
				_rand_y = irandom_range(-48,48);
				scr_spawn_popup("TEXT","+"+_card_name,undefined,c_white,obj_player.x+_rand_x,obj_player.y+_rand_y);
			}
		
			//GIVE 1 UNCOMMON CARD
			_card_roll = irandom_range(0,ds_list_size(global.rarity_II_cards)-1);
			_card_name = ds_list_find_value(global.rarity_II_cards,_card_roll);
			_new_card = scr_get_card_info(_card_name);
			scr_add_card_to_deck(_new_card);
			
			//POPUP NEW CARD GAINED
			_rand_x = irandom_range(-48,48);
			_rand_y = irandom_range(-48,48);			
			scr_spawn_popup("TEXT","+"+_card_name,undefined,c_lime,obj_player.x+_rand_x,obj_player.y+_rand_y);
			
			//POPUP GOLD GAINED
			global.player_gold += 100;
			_rand_x = irandom_range(-48,48);
			_rand_y = irandom_range(-48,48);			
			scr_spawn_popup("TEXT","+100gp",undefined,c_yellow,obj_player.x+_rand_x,obj_player.y+_rand_y);
		break;
		#endregion
		
		#region III
		case "III":
			//GIVE 2-3 BASIC CARDS
			for (var _i = 0; _i < _loot_amount; _i++){
				_card_roll = irandom_range(0,ds_list_size(global.rarity_I_cards)-1);
				_card_name = ds_list_find_value(global.rarity_I_cards,_card_roll);
				_new_card = scr_get_card_info(_card_name);
				scr_add_card_to_deck(_new_card);
			
				//POPUP NEW CARD GAINED
				_rand_x = irandom_range(-48,48);
				_rand_y = irandom_range(-48,48);
				scr_spawn_popup("TEXT","+"+_card_name,undefined,c_white,obj_player.x+_rand_x,obj_player.y+_rand_y);
			}
		
			//GIVE 1 UNCOMMON CARD
			_card_roll = irandom_range(0,ds_list_size(global.rarity_II_cards)-1);
			_card_name = ds_list_find_value(global.rarity_II_cards,_card_roll);
			_new_card = scr_get_card_info(_card_name);
			scr_add_card_to_deck(_new_card);
			
			//POPUP NEW CARD GAINED
			_rand_x = irandom_range(-48,48);
			_rand_y = irandom_range(-48,48);			
			scr_spawn_popup("TEXT","+"+_card_name,undefined,c_lime,obj_player.x+_rand_x,obj_player.y+_rand_y);
			
			//GIVE 1 EPIC CARD
			_card_roll = irandom_range(0,ds_list_size(global.rarity_III_cards)-1);
			_card_name = ds_list_find_value(global.rarity_III_cards,_card_roll);
			_new_card = scr_get_card_info(_card_name);
			scr_add_card_to_deck(_new_card);
			
			//POPUP NEW CARD GAINED
			_rand_x = irandom_range(-48,48);
			_rand_y = irandom_range(-48,48);				
			scr_spawn_popup("TEXT","+"+_card_name,undefined,c_aqua,obj_player.x+_rand_x,obj_player.y+_rand_y);
			
			//POPUP GOLD GAINED
			global.player_gold += 200;
			_rand_x = irandom_range(-48,48);
			_rand_y = irandom_range(-48,48);				
			scr_spawn_popup("TEXT","+200gp",undefined,c_yellow,obj_player.x+_rand_x,obj_player.y+_rand_y);
		break;
		#endregion
	}
}
#endregion