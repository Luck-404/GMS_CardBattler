//===============================================================================//
//
// CREATE: OBJ_TREASURE_CHEST
// FUNCTION: Initializes chest loot state and persistence.
//           Rolls random chest rarity when needed.
//           Defines helper scripts for awarding preset or random loot.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
_val_loot_amount = 1;

_flag_triggered = false;

_val_rand_x = irandom_range(-48,48);
_val_rand_y = irandom_range(-48,48);

_str_rarity = "I";
_c_chest = c_white;

//----//
//INIT//
//----//
if (ds_map_exists(global.player_chests_opened, _uid_chest)){
    _flag_triggered = true;
    image_index = 1;
}
else if (_str_chest_id == "RANDOM"){
	hscr_roll_random_chest();
}

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_roll_random_chest | ROLLS CHEST RARITY AND UPDATES ITS LOOT AMOUNT
//—------------------------------------------------------------------------------//
	function hscr_roll_random_chest(){
		_str_rarity = choose("I","I","I","I","I","I","II","II","II","III");
	
		switch(_str_rarity){
			case "I":
				_c_chest = c_white;
				_val_loot_amount = 3;
			break;

			case "II":
				_c_chest = c_lime;
				_val_loot_amount = 2;
			break;

			case "III":
				_c_chest = c_aqua;
				_val_loot_amount = 1;
			break;
		}	
	}

//—------------------------------------------------------------------------------//
// hscr_award_custom_treasure_chest_loot | AWARDS CUSTOMIZED LOOT
//—------------------------------------------------------------------------------//
	function hscr_award_custom_treasure_chest_loot(){

		var _arr_rewards = scr_get_chest_custom_loot(_str_chest_id);

		for (var _it_reward = 0; _it_reward < array_length(_arr_rewards); _it_reward++){

			var _stct_reward = _arr_rewards[_it_reward];

			var _str_reward_type = _stct_reward._str_type;
			var _str_reward_name = _stct_reward._str_rew_id;
			var _val_reward_count = _stct_reward._val_amount;

			switch(_str_reward_type){
				case "CARD":
					for (var _it_card = 0; _it_card < _val_reward_count; _it_card++){
						var _ref_card = scr_get_card_info(_str_reward_name);
						scr_add_card_to_deck(_ref_card);
					}
				break;

				case "ITEM":
					scr_add_item_to_inventory(_str_reward_name,_val_reward_count);
				break;

				case "GOLD":
					global.player_gold += _val_reward_count;
				break;
			}

			_val_rand_x = irandom_range(-128,128);
			_val_rand_y = irandom_range(-128,128);

			scr_spawn_popup("TEXT","+" + _str_reward_name + "x" + string(_val_reward_count),undefined,c_white,obj_player.x + _val_rand_x,obj_player.y + _val_rand_y);
		}
	}

//—------------------------------------------------------------------------------//
// hscr_roll_treasure_chest_reward | ROLL RANDOM CHEST LOOT
//—------------------------------------------------------------------------------//
	function hscr_roll_treasure_chest_reward(){
		for (var _it_loot = 0; _it_loot < _val_loot_amount; _it_loot++){
			var _str_reward_type = choose("ITEM","CARD");
			var _list_card_pool = global.rarity_I_cards;
		
			if (_str_rarity == "I"){
				_list_card_pool = global.rarity_I_cards;	
			} else if (_str_rarity == "II"){
				_list_card_pool = global.rarity_II_cards;	
			} else {
				_list_card_pool = global.rarity_III_cards;	
			}
		
			if (_str_reward_type == "CARD"){
				var _val_card_roll = irandom_range(0, ds_list_size(_list_card_pool) - 1);
				var _str_card_name = ds_list_find_value(_list_card_pool, _val_card_roll);
				var _ref_card = scr_get_card_info(_str_card_name);

				scr_add_card_to_deck(_ref_card);		
			
				_val_rand_x = irandom_range(-48,48);
				_val_rand_y = irandom_range(-48,48);

				scr_spawn_popup("TEXT","+" + _str_card_name,undefined,c_white,obj_player.x + _val_rand_x,obj_player.y + _val_rand_y);
			} else {
				var _str_new_item = scr_get_random_item(global.item_pool);

				scr_add_item_to_inventory(_str_new_item, 1);

				_val_rand_x = irandom_range(-48,48);
				_val_rand_y = irandom_range(-48,48);

				scr_spawn_popup("TEXT","+" + string(_str_new_item),undefined,c_black,obj_player.x + _val_rand_x,obj_player.y + _val_rand_y);
			}	
		
			var _val_new_gold = 50;

			if (_str_rarity == "II"){
				_val_new_gold = 150;	
			}

			if (_str_rarity == "III"){
				_val_new_gold = 300;	
			}
		
			global.player_gold += _val_new_gold;
			
			_val_rand_x = irandom_range(-48,48);
			_val_rand_y = irandom_range(-48,48);

			scr_spawn_popup("TEXT","+" + string(_val_new_gold) + "gp",undefined,c_yellow,obj_player.x + _val_rand_x,obj_player.y + _val_rand_y);
		}		
	}
#endregion