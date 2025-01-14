show_debug_message("\n\n===ENEMY TEAM OBJECT ALIVE===\n\n");		

//////////////////
// STARTER TEAM //
//////////////////
_flag_party_spawned = false;
global.enemy_team = ds_list_create(); 
global.enemy_team_in_play = ds_list_create();
global.enemy_team_dead = ds_list_create();
//RANDOMIZE HERE IN THE FUTURE
var _creature_wraith = scr_create_creature("Wraith", false, "Uncolored", "None", "None","Enemy","Default",irandom_range(1,5),"All","All",undefined, undefined,spr_creature_uncolored_wraith,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default);
ds_list_add(global.enemy_team, _creature_wraith);


//////////
// DECK //
//////////
global.enemy_card_inventory = ds_list_create(); //create enemy inventory

//RANDOMIZE HERE IN THE FUTURE
//add a 'starter deck'
	var _card_strike = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike,"Enemy","Uncolored","Attack","Any");
	var _card_echo = scr_create_card("Echo", "Next spell cast twice, exhaust", 0, scr_card_echo, spr_card_echo,"None","Uncolored","Utility","Any");
	var _card_block = scr_create_card("Block", "Defend 5", 1, scr_card_block, spr_card_block,"Ally","Uncolored","Defend","Any");	
	
	ds_list_add(global.enemy_card_inventory, _card_echo);
	ds_list_add(global.enemy_card_inventory, _card_echo);	
	ds_list_add(global.enemy_card_inventory, _card_strike);
	ds_list_add(global.enemy_card_inventory, _card_strike);	
	ds_list_add(global.enemy_card_inventory, _card_block);
	ds_list_add(global.enemy_card_inventory, _card_block);