//
//
// OBJ_TREASURE_CHEST
//
//

//
// VARIABLES
//
_loot_amount = 1;

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
		_loot_amount = 3;
		break;
		case "II":
		_color = c_lime;
		_loot_amount = 2;
		break;
		case "III":
		_color = c_aqua;
		_loot_amount = 1;
		break;
	}	
}
	
//
// AWARDS A TREASURE OF A PRESET CHEST
//
function scr_award_treasure_chest_loot(){
	//BASED ON CHEST ID, GET INFO FROM THE SPECIAL LOOT TABLE SCRIPT
	var _rewards = scr_get_chest_custom_loot(_chest_id);
	
	for (var _j = 0; _j < ds_list_size(_rewards); _j++){
		
		var _reward = ds_list_find_value(_rewards,_j);
		var _reward_type = _reward[0];
		var _reward_name = _reward[1];
		var _reward_count = _reward[2];
		show_debug_message("CHEST REWARD: j" + string(_j) + " " + string(_reward));
		show_debug_message("CHEST REWARD TYPE: " + string(_reward_type));
		show_debug_message("CHEST REWARD NAME: " + string(_reward_name));
		show_debug_message("CHEST REWARD COUNT: " + string(_reward_count));
		
		switch(_reward_type){
				case "CARD":
					var _card = scr_get_card_info(_reward_name);
					for (var _k = 0; _k < _reward_count; _k++){
						scr_add_card_to_deck(_card);
					}
				break;
				
				case "ITEM":
					scr_add_item_to_inventory(_reward_name,_reward_count)		
				break;
				
				case "GOLD":
					global.player_gold+=_reward_count;
				break;				
		}
		
		_rand_x = irandom_range(-128,128);
		_rand_y = irandom_range(-128,128);			
		scr_spawn_popup("TEXT","+" + _reward_name + "x" + string(_reward_count),undefined,c_white,obj_player.x+_rand_x,obj_player.y+_rand_y);		
	}
}

//
// AWARDS A TREASURE OF THE APPROPRAITE RARITY FROM THE GLOBAL POOLS IF RANDOM
//
function scr_roll_treasure_chest_reward(){
	for (var _i = 0; _i < _loot_amount; _i++){
		var _rew = choose("ITEM","CARD");
		var _card_pool = global.rarity_I_cards;
		
		if (_rarity == "I"){
			_card_pool = global.rarity_I_cards;	
		} else if (_rarity == "II"){
			_card_pool = global.rarity_II_cards;	
		} else {
			_card_pool = global.rarity_III_cards;	
		}
		
		if (_rew == "CARD"){
			var _card_roll = irandom_range(0,ds_list_size(_card_pool)-1);
			var _card_name = ds_list_find_value(_card_pool,_card_roll);
			var _card = scr_get_card_info(_card_name)
			scr_add_card_to_deck(_card);		
			show_debug_message("\nTIER " + string(_rarity) + " RANDOM CHEST + " + _card_name);
			
			//POPUP NEW CARD GAINED
			_rand_x = irandom_range(-48,48);
			_rand_y = irandom_range(-48,48);
			scr_spawn_popup("TEXT","+"+_card_name,undefined,c_white,obj_player.x+_rand_x,obj_player.y+_rand_y);
		}
		else {
			_new_item = scr_get_random_item(global.item_pool);
			show_debug_message("\nTIER " + string(_rarity) + " RANDOM CHEST + " + _new_item);
			scr_add_item_to_inventory(_new_item,1);
			//POPUP NEW CARD GAINED
			_rand_x = irandom_range(-48,48);
			_rand_y = irandom_range(-48,48);
			scr_spawn_popup("TEXT","+"+string(_new_item),undefined,c_black,obj_player.x+_rand_x,obj_player.y+_rand_y);
		}	
		
		//POPUP GOLD GAINED
		var _new_gold = 50;
		if (_rarity == "II"){
		_new_gold = 150;	
		}
		if (_rarity == "III"){
		_new_gold = 300;	
		}
		
		global.player_gold += _new_gold;
			
		_rand_x = irandom_range(-48,48);
		_rand_y = irandom_range(-48,48);			
		scr_spawn_popup("TEXT","+" + string(_new_gold) + "gp",undefined,c_yellow,obj_player.x+_rand_x,obj_player.y+_rand_y);
	}		
}
#endregion