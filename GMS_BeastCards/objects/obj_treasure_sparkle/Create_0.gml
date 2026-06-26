//===============================================================================//
//
// CREATE: OBJ_TREASURE_SPARKLE
// FUNCTION: Initializes a roaming treasure sparkle.
//           Rolls rarity, visibility state, and starting position.
//           Defines helper scripts for sparkle behavior and rewards.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
_str_rarity = "";

_c_sparkle = c_white;

_val_visibility_timer = 300;

_flag_triggered = false;

_ct_cooldown = 10;

//----//
//INIT//
//----//
hscr_roll_treasure_sparkle_rarity();
hscr_roll_treasure_sparkle_position();
hscr_roll_treasure_sparkle_visibility();

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_roll_treasure_sparkle_rarity
// FUNCTION: Rolls a rarity tier and assigns its display color.
//—------------------------------------------------------------------------------//
function hscr_roll_treasure_sparkle_rarity(){

	_str_rarity = choose("I","I","I","I","I","I","II","II","II","III");
	
	switch(_str_rarity){
		case "I":
			_c_sparkle = c_white;
		break;

		case "II":
			_c_sparkle = c_lime;
		break;

		case "III":
			_c_sparkle = c_aqua;
		break;
	}
}

//—------------------------------------------------------------------------------//
// hscr_roll_treasure_sparkle_position
// FUNCTION: Places the sparkle at a random room position.
//—------------------------------------------------------------------------------//
function hscr_roll_treasure_sparkle_position(){
	x = irandom_range(32, room_width - 32);
	y = irandom_range(32, room_height - 32);
}

//—------------------------------------------------------------------------------//
// hscr_roll_treasure_sparkle_visibility
// FUNCTION: Randomly determines whether the sparkle is visible.
//—------------------------------------------------------------------------------//
function hscr_roll_treasure_sparkle_visibility(){
	var _val_roll = irandom_range(0,100);

	if (_val_roll < 50){
		visible = true;
	} else {
		visible = false;
	}

	_val_visibility_timer = 300;
}

//—------------------------------------------------------------------------------//
// hscr_roll_treasure_sparkle_reward
// FUNCTION: Awards a random reward based on sparkle rarity.
//           Grants either a card or item plus bonus gold.
//           Creates popup notifications for all rewards.
//—------------------------------------------------------------------------------//
function hscr_roll_treasure_sparkle_reward(){
	var _str_reward_type = choose("ITEM","CARD");
	var _list_card_pool = global.list_pool_cards_rarity_I;
		
	if (_str_rarity == "I"){
		_list_card_pool = global.list_pool_cards_rarity_I;
	} else if (_str_rarity == "II"){
		_list_card_pool = global.list_pool_cards_rarity_II;
	} else {
		_list_card_pool = global.list_pool_cards_rarity_III;
	}
		
	//—------------------------------------------------------------------------------//
	// CARD REWARD
	//—------------------------------------------------------------------------------//
	if (_str_reward_type == "CARD"){

		var _val_card_roll = irandom_range(0, ds_list_size(_list_card_pool) - 1);
		var _str_card_name = ds_list_find_value(_list_card_pool, _val_card_roll);
		var _ref_card = scr_get_card_info(_str_card_name);

		scr_add_card_to_deck(_ref_card);

		show_debug_message("\nTIER " + _str_rarity + " RANDOM SPARKLE + " + _str_card_name);
			
		var _val_rand_x = irandom_range(-48,48);
		var _val_rand_y = irandom_range(-48,48);

		scr_spawn_popup("TEXT","+" + _str_card_name,undefined,c_white,obj_player.x + _val_rand_x,obj_player.y + _val_rand_y);

	} 
	//—------------------------------------------------------------------------------//
	// ITEM REWARD
	//—------------------------------------------------------------------------------//	
	else {

		var _str_new_item = scr_get_random_item(global.list_pool_items);

		show_debug_message("\nTIER " + _str_rarity + " RANDOM SPARKLE + " + _str_new_item);

		scr_add_item_to_inventory(_str_new_item,1);

		var _val_rand_x = irandom_range(-48,48);
		var _val_rand_y = irandom_range(-48,48);

		scr_spawn_popup("TEXT","+" + _str_new_item,undefined,c_black,obj_player.x + _val_rand_x,obj_player.y + _val_rand_y);
	}
		
	var _val_new_gold = 10;

	if (_str_rarity == "II"){
		_val_new_gold = 25;
	}

	if (_str_rarity == "III"){
		_val_new_gold = 50;
	}
		
	global.val_player_gold += _val_new_gold;
			
	var _val_rand_x = irandom_range(-48,48);
	var _val_rand_y = irandom_range(-48,48);

	scr_spawn_popup("TEXT","+" + string(_val_new_gold) + "gp",undefined,c_yellow,obj_player.x + _val_rand_x,obj_player.y + _val_rand_y);
}

#endregion