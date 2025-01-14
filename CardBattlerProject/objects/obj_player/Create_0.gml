///////////////
// VARIABLES //
///////////////
show_debug_message("\n\n===PLAYER CREATED===\n\n");	
randomize();
_flag_fullscreen = true;
window_set_fullscreen(_flag_fullscreen);
_flag_deck_created = false;
_flag_party_spawned = false;
_move_speed = 4;
_target_x = x; // Current position
_target_y = y;
_flag_moving = false; // Movement status
global.max_mana = 3;
global.current_mana = 3;
global.player_xpos = 960;
global.player_ypos = 540;
global.gold = 0;
global.randgold = 0;

//////////////////
// STARTER TEAM //
//////////////////
global.player_team = ds_list_create(); 
var _creature_wraith = scr_create_creature("Wraith", false, "Uncolored", "None", "None","Ally","Default",irandom_range(30,40),"All","All",undefined, undefined,spr_creature_uncolored_wraith,snd_creature_wraith_hurt,snd_creature_wraith_death,snd_creature_wraith_default);
ds_list_add(global.player_team, _creature_wraith);
global.player_team_in_play = ds_list_create(); 
global.player_team_dead = ds_list_create();

//////////
// DECK //
//////////
global.card_inventory = ds_list_create(); //create inventory
instance_create_layer(x,y,"GUI",obj_card_display); //generate the card display for overworld

//add a 'starter deck'
	var _card_strike = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike,"Enemy","Uncolored","Attack","Any");
	var _card_echo = scr_create_card("Echo", "Next spell cast twice, exhaust", 0, scr_card_echo, spr_card_echo,"None","Uncolored","Utility","Any");
	var _card_inspiration = scr_create_card("Inspiration", "Gain 1 mana, exhaust", 0, scr_card_inspiration, spr_card_insirpation,"None","Uncolored","Utility","Any");
	ds_list_add(global.card_inventory, _card_echo);
	ds_list_add(global.card_inventory, _card_inspiration);
	ds_list_add(global.card_inventory, _card_strike);


///////////////////////
// ENCOUNTER TRIGGER //
///////////////////////
instance_create_layer(x,y,"GUI",obj_encounter_trigger);


////////////
// CAMERA //
////////////
global._camera = camera_create(); // Create a camera
global._cam_width = 960; // Camera width (match your viewport)
global._cam_height = 540; // Camera height (match your viewport)
camera_set_view_size(global._camera, global._cam_width, global._cam_height); // Set camera size
camera_set_view_pos(global._camera, x - global._cam_width / 2, y - global._cam_height / 2); // Center on character
view_set_camera(0, global._camera); // Attach camera to Viewport 0

