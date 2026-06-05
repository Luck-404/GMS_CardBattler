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
	randomize();
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
	randomize();
	switch(_rarity){
		#region I
		case "I":
			//GIVE 1 BASIC CARD
			_card_roll = irandom_range(0,ds_list_size(global.rarity_I_cards)-1);
			_card_name = ds_list_find_value(global.rarity_I_cards,_card_roll);
			_new_card = scr_get_card_info(_card_name);
			scr_add_card_to_deck(_new_card);
			
			//POPUP NEW CARD GAINED
			scr_spawn_popup("TEXT","+"+_card_name,undefined,c_white,obj_player.x,obj_player.y);
		
			//POPUP GOLD GAINED
			global.player_gold += 10;
			scr_spawn_popup("TEXT","+10gp",undefined,c_yellow,obj_player.x,obj_player.y+20);
		break;
		#endregion
		
		#region II
		case "II":
			//GIVE 1 UNCOMMON CARD
			_card_roll = irandom_range(0,ds_list_size(global.rarity_II_cards)-1);
			_card_name = ds_list_find_value(global.rarity_II_cards,_card_roll);
			_new_card = scr_get_card_info(_card_name);
			scr_add_card_to_deck(_new_card);
			
			//POPUP NEW CARD GAINED
			scr_spawn_popup("TEXT","+"+_card_name,undefined,c_lime,obj_player.x,obj_player.y);
			
			//POPUP GOLD GAINED
			global.player_gold += 20;
			scr_spawn_popup("TEXT","+20gp",undefined,c_yellow,obj_player.x,obj_player.y+20);
		break;
		#endregion
		
		#region III
		case "III":
			//GIVE 1 EPIC CARD
			_card_roll = irandom_range(0,ds_list_size(global.rarity_III_cards)-1);
			_card_name = ds_list_find_value(global.rarity_III_cards,_card_roll);
			_new_card = scr_get_card_info(_card_name);
			scr_add_card_to_deck(_new_card);
			
			//POPUP NEW CARD GAINED
			scr_spawn_popup("TEXT","+"+_card_name,undefined,c_aqua,obj_player.x,obj_player.y);
			
			//POPUP GOLD GAINED
			global.player_gold += 30;
			scr_spawn_popup("TEXT","+30gp",undefined,c_yellow,obj_player.x,obj_player.y+20);
		break;
		#endregion
	}
}
#endregion