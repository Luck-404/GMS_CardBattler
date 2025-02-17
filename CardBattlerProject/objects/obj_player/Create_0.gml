//////////////////////////////////////////////////////////////////////
//							OBJ_PLAYER								//
//																	//
// > THE MAIN PLAYER UNIT, MOST USER-GAME INTERACTIONS ARE RAN		//
//	 THROUGH THIS OBJECT											//
//////////////////////////////////////////////////////////////////////
randomize();
_flag_fullscreen = true;
window_set_fullscreen(_flag_fullscreen);
_flag_deck_created = false;
_flag_party_spawned = false;
_move_speed = 0;
_target_x = x; // Current position
_target_y = y;
_flag_moving = false; // Movement status
global.hand_size = 3; // Maximum of 3 cards in the hand
global.max_mana_saved = 3;
global.max_mana = 3;
global.current_mana = 3;
global.player_xpos = 960;
global.player_ypos = 540;
global.gold = 500;
global.randgold = 0;
global.trigger_loss = false;
_flag_transition_start = false;
_flag_can_touch = true;
global.saved_room = room;
_hop_start = false;
_hop_offset = 0;
_hop_dx = 0;
_hop_dy = 0;

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
	//var _card_strike = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike,"Enemy","Uncolored","Attack","Any","Any",irandom_range(30,45),false);
	var _card_potent_fruit = scr_create_card("Potent Fruit", "2x Damage for 3 Turns", 3, scr_card_potent_fruit, spr_card_potent_fruit,"Ally","Green","Buff","Martial","Any",irandom_range(75,90),true);
	var _card_grow_manavine = scr_create_card("Grow Manavine", "+3 max mana for 3 turns", 2, scr_card_grow_manavine, spr_card_grow_manavine,"None","Green","Utility","Technical","Any",irandom_range(60,75),true);	
	var _card_natures_remedy = scr_create_card("Nature's Remedy", "Heal Ally 30% max HP", 2, scr_card_natures_remedy, spr_card_natures_remedy,"Ally","Green","Heal","Magical","Any",irandom_range(60,75),true);	
	var _card_thorny_whip = scr_create_card("Thorny Whip", "Attack 8", 0, scr_card_thorny_whip, spr_card_thorny_whip,"Enemy","Green","Attack","Any","Any",irandom_range(30,45),false);
	var _card_poison_ivy = scr_create_card("Poison Ivy", "Poison up to 3 targets for 2 turns", 1, scr_card_poison_ivy, spr_card_poison_ivy,"Enemy","Green","Attack","Any","Any",irandom_range(45,60),false);
	var _card_fell = scr_create_card("Fell", "Deal 30% hp damage to one unit", 2, scr_card_fell, spr_card_fell,"Enemy","Green","Attack","Any","Any",irandom_range(60,75),false);
	var _card_beastial_bash = scr_create_card("Beastial Bash", "Deal damage to 3 units, stun 1", 3, scr_card_beastial_bash, spr_card_beastial_bash,"Enemy","Green","Attack","Any","Any",irandom_range(75,90),true);
	var _card_stampede = scr_create_card("Stampede", "Deal damage to all units", 3, scr_card_stampede, spr_card_stampede,"Enemy","Green","Attack","Any","Any",irandom_range(75,90),true);
	
	//var _card_echo = scr_create_card("Echo", "Next spell cast twice, exhaust", 0, scr_card_echo, spr_card_echo,"None","Uncolored","Utility","Any","Any",irandom_range(60,75),true);
	//var _card_inspiration = scr_create_card("Inspiration", "Gain 1 mana, exhaust", 0, scr_card_inspiration, spr_card_insirpation,"None","Uncolored","Utility","Any","Any",irandom_range(60,75),true);
	//ds_list_add(global.card_inventory, _card_echo);
	//ds_list_add(global.card_inventory, _card_inspiration);
	ds_list_add(global.card_inventory, _card_thorny_whip);
	ds_list_add(global.card_inventory, _card_potent_fruit);	
	ds_list_add(global.card_inventory, _card_grow_manavine);	
	ds_list_add(global.card_inventory, _card_natures_remedy);	
	ds_list_add(global.card_inventory, _card_poison_ivy);
	ds_list_add(global.card_inventory, _card_fell);	
	ds_list_add(global.card_inventory, _card_beastial_bash);	
	ds_list_add(global.card_inventory, _card_stampede);		
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