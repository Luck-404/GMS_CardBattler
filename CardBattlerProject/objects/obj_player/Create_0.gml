show_debug_message("\n\n\n\n\n|=== PLAYER CREATED: GAME START ===|");	
///////////////
// VARIABLES //
///////////////
show_debug_message("|=== PLAYER: RANDOMIZING... ===|");	
randomize();
show_debug_message("|=== PLAYER: RANDOMIZED ===|");	
_flag_fullscreen = true;
window_set_fullscreen(_flag_fullscreen);
_flag_deck_created = false;
_flag_party_spawned = false;
_move_speed = 4;
_target_x = x; // Current position
_target_y = y;
_flag_moving = false; // Movement status
global.hand_size = 3; // Maximum of 3 cards in the hand
global.max_mana = 3;
global.current_mana = 3;
global.player_xpos = 960;
global.player_ypos = 540;
global.gold = 500;
global.randgold = 0;
global.trigger_loss = false;
_flag_transition_start = false;
_flag_can_touch = true;

//////////////////
// STARTER TEAM //
//////////////////
show_debug_message("|=== PLAYER: CREATING TEAM... ===|");	
global.player_team = ds_list_create(); 
var _creature_wraith = scr_create_creature("Wraith", false, "Uncolored", "None", "None","Ally","Default",irandom_range(30,40),"All","All",undefined, undefined,spr_creature_uncolored_wraith,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default);
ds_list_add(global.player_team, _creature_wraith);

	//monkey for testing purposes
	var _creature_monkey = scr_create_creature("Bush Monkey", false, "Green", "None", "None","Ally","Default",irandom_range(40,60),"All","All",undefined, undefined,spr_creature_green_bush_monkey,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default);
	_creature_monkey[?"curhp"] = 10;
	ds_list_add(global.player_team, _creature_monkey);
	
global.player_team_in_play = ds_list_create(); 
global.player_team_dead = ds_list_create();
global.graveyard = ds_list_create(); 

	//monkey for graveyard purposes
	var _creature_grave_monkey = scr_create_creature("Bush Monkey", false, "Green", "None", "None","Ally","Default",irandom_range(40,60),"All","All",undefined, undefined,spr_creature_green_bush_monkey,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default);
	ds_list_add(global.graveyard, _creature_grave_monkey);
	
show_debug_message("|=== PLAYER: TEAM CREATED! ===|");	

//////////
// DECK //
//////////
show_debug_message("|=== PLAYER: CREATING CARD INVENTORY... ===|");	
global.card_inventory = ds_list_create(); //create inventory
instance_create_layer(x,y,"GUI",obj_card_display); //generate the card display for overworld

//add a 'starter deck'
	var _card_strike = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike,"Enemy","Uncolored","Attack",,"Any","Any",irandom_range(30,45),false);
	var _card_potent_fruit = scr_create_card("Potent Fruit", "2x Damage for 3 Turns", 2, scr_card_potent_fruit, spr_card_potent_fruit,"Ally","Green","Buff","Martial","Any",irandom_range(60,75),true);
	//var _card_echo = scr_create_card("Echo", "Next spell cast twice, exhaust", 0, scr_card_echo, spr_card_echo,"None","Uncolored","Utility","Any","Any",irandom_range(60,75),true);
	//var _card_inspiration = scr_create_card("Inspiration", "Gain 1 mana, exhaust", 0, scr_card_inspiration, spr_card_insirpation,"None","Uncolored","Utility","Any","Any",irandom_range(60,75),true);
	//ds_list_add(global.card_inventory, _card_echo);
	//ds_list_add(global.card_inventory, _card_inspiration);
	ds_list_add(global.card_inventory, _card_strike);
	ds_list_add(global.card_inventory, _card_potent_fruit);	
show_debug_message("|=== PLAYER: CARD INVENTORY CREATED! ===|");	

///////////////////////
// ENCOUNTER TRIGGER //
///////////////////////
show_debug_message("|=== PLAYER: CREATING ENCOUNTER TRIGGER... ===|");	
instance_create_layer(x,y,"GUI",obj_encounter_trigger);
show_debug_message("|=== PLAYER: CREATED ENCOUNTER TRIGGER! ===|");	

////////////
// CAMERA //
////////////
_flag_created_camera = false;