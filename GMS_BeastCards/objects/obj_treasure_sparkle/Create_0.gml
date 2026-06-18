//
//
// OBJ_TREASURE_SPARKLE
//
//

//
// VARIABLES
//
_rarity = "";
_color = c_white;
_visibility_timer = 300;
_flag_triggered = false;
_cooldown = 10;

//
// INIT
//
scr_roll_treasure_sparkle_rarity();
scr_roll_treasure_sparkle_position()
scr_roll_treasure_sparkle_visibility();

//
// METHODS
//
#region METHODS
//
// ROLLS A RARITY FOR THE TREASURE
//
function scr_roll_treasure_sparkle_rarity(){
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
// PLACES TREASURE AT A NEW POSITION
//
function scr_roll_treasure_sparkle_position(){
	x = irandom_range(32,room_width-32);
	y = irandom_range(32,room_height-32);
}

//
// ROLLS TREASURE VISIBILITY
//
function scr_roll_treasure_sparkle_visibility(){
	_roll = irandom_range(0,100);
	if (_roll < 50){
		visible = true;	
	} else {
		visible = false;	
	}
	_visibility_timer = 300;
}

//
// AWARDS A TREASURE OF THE APPROPRAITE RARITY FROM THE GLOBAL POOLS
//
function scr_roll_treasure_sparkle_reward(){
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
		show_debug_message("\nTIER " + string(_rarity) + " RANDOM SPARKLE + " + _card_name);
			
		//POPUP NEW CARD GAINED
		_rand_x = irandom_range(-48,48);
		_rand_y = irandom_range(-48,48);
		scr_spawn_popup("TEXT","+"+_card_name,undefined,c_white,obj_player.x+_rand_x,obj_player.y+_rand_y);
	}
	else {
		_new_item = scr_get_random_item(global.item_pool);
		show_debug_message("\nTIER " + string(_rarity) + " RANDOM SPARKLE + " + _new_item);
		scr_add_item_to_inventory(_new_item,1);
		//POPUP NEW CARD GAINED
		_rand_x = irandom_range(-48,48);
		_rand_y = irandom_range(-48,48);
		scr_spawn_popup("TEXT","+"+string(_new_item),undefined,c_black,obj_player.x+_rand_x,obj_player.y+_rand_y);
	}	
		
	//POPUP GOLD GAINED
	var _new_gold = 10;
	if (_rarity == "II"){
	_new_gold = 25;	
	}
	if (_rarity == "III"){
	_new_gold = 50;	
	}
		
	global.player_gold += _new_gold;
			
	_rand_x = irandom_range(-48,48);
	_rand_y = irandom_range(-48,48);			
	scr_spawn_popup("TEXT","+" + string(_new_gold) + "gp",undefined,c_yellow,obj_player.x+_rand_x,obj_player.y+_rand_y);
}		
#endregion