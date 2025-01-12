//create
randomize();
_flag_fullscreen = true;
window_set_fullscreen(_flag_fullscreen);
_flag_deck_created = false;

// Initialize variables
_move_speed = 4;
target_x = x; // Current position
target_y = y;
moving = false; // Movement status
// Align the character to the grid at the start
x = round(x / 32) * 32; // Align horizontally
y = round(y / 32) * 32; // Align vertically
x = x-16;
y = y-16;

global.max_mana = 3;
global.current_mana = 3;

//////////
// DECK //
//////////

global.card_inventory = ds_list_create();
instance_create_layer(x,y,"GUI",obj_card_display);
var card_strike = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike);
var card_echo = scr_create_card("Echo", "Next spell cast twice, exhaust", 0, scr_card_echo, spr_card_echo);
var card_inspiration = scr_create_card("Inspiration", "Gain 1 mana, exhaust", 0, scr_card_inspiration, spr_card_insirpation);
ds_list_add(global.card_inventory, card_echo);
ds_list_add(global.card_inventory, card_inspiration);
ds_list_add(global.card_inventory, card_strike);

////////////
// CAMERA //
////////////

camera = camera_create(); // Create a camera
var cam_width = 960; // Camera width (match your viewport)
var cam_height = 540; // Camera height (match your viewport)
camera_set_view_size(camera, cam_width, cam_height); // Set camera size
camera_set_view_pos(camera, x - cam_width / 2, y - cam_height / 2); // Center on character
view_set_camera(0, camera); // Attach camera to Viewport 0

instance_create_layer(x,y,"GUI",obj_encounter_trigger);