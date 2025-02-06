//////////////////////////////////////////////////////////////////////
//					OBJ_GUI_NEW_GAME DRAW GUI						//
//																	//
// > DRAW THE INFORMATION ABOUT THE PATHS/PATRONS, AS WELL AS		//
//   PLAYER SELECTIONS AND THE CONFIRM BUTTON						//
//////////////////////////////////////////////////////////////////////

///////////////////////////////
// HANDLE 'X' CLICK TO CLOSE //
///////////////////////////////
if (mouse_x < 1135 && mouse_x > 1114 && mouse_y < 308 && mouse_y > 289) {
	image_index = 1;
	if (mouse_check_button(mb_left)) {
		image_index = 2;
	}
	if (mouse_check_button_released(mb_left)) {
		global.flag_gui_open = false;
		global.gui_active = undefined;
		instance_destroy();
	}
} else {
	image_index = 0;
}

//////////////////////
// DRAW PATRON GRID //
//////////////////////
draw_set_color(c_black);

// Define starting position for drawing
_patrons_start_x = room_width / 2 - (ds_list_size(_list_patrons) * (64 + 10)) / 2; 
_patrons_start_y = room_height / 2 - 200;
_patrons_box_w = 64;
_patrons_box_h = 64;

for (var _i = 0; _i < ds_list_size(_list_patrons); _i++) {
	var _patron = ds_list_find_value(_list_patrons, _i);
	var _sigil = ds_map_find_value(_patron, "Sigil");
	var _name = ds_map_find_value(_patron, "Name");


	// Calculate position
	_patrons_x_pos = _patrons_start_x + _i * (64 + 10);
	_patrons_y_pos = _patrons_start_y;

	// Draw background box
	draw_set_color(c_black);
	draw_rectangle(_patrons_x_pos, _patrons_y_pos, _patrons_x_pos + 64, _patrons_y_pos + 64, true);

	// Draw sigil centered in the box
	if (!is_undefined(_sigil)) {
		draw_sprite(_sigil, 0, _patrons_x_pos + 32, _patrons_y_pos + 32);
	}

	// Hover effect: Draw a white box and show patron name
	if (mouse_x > _patrons_x_pos && mouse_x < _patrons_x_pos + _patrons_box_w &&
		mouse_y > _patrons_y_pos && mouse_y < _patrons_y_pos + _patrons_box_h) {
		
		draw_set_color(c_white);
		draw_rectangle(_patrons_x_pos+5, _patrons_y_pos+5, _patrons_x_pos + _patrons_box_w-5, _patrons_y_pos + _patrons_box_h-5, true);

		// Draw tooltip box
		draw_set_color(c_gray);
		draw_rectangle(mouse_x, mouse_y - 30, mouse_x + string_width(_name) + 10, mouse_y, false);
		draw_set_color(c_white);
		draw_text(mouse_x + 5, mouse_y - 27, _name);
		
		//draw 
	}

	// Select patron on left click
	if (mouse_check_button_pressed(mb_left) &&
		mouse_x > _patrons_x_pos && mouse_x < _patrons_x_pos + _patrons_box_w &&
		mouse_y > _patrons_y_pos && mouse_y < _patrons_y_pos + _patrons_box_h) {
		
		_selected_patron = _patron;

		_array_blessings = _selected_patron[?"Blessings"];		
	}

	// Draw selection indicator and other info
	if (_selected_patron != undefined && _selected_patron == _patron) {
		draw_sprite(spr_selected_arrow, 0, _patrons_x_pos, _patrons_y_pos);
		var _desc = ds_map_find_value(_patron, "Description");
		var _starter =ds_map_find_value(_patron, "Starter");
		var _cards =ds_map_find_value(_patron, "Cards");
		var _gear = ds_map_find_value(_patron, "Gear");
		var _gold =ds_map_find_value(_patron, "Bonus Gold");
		var _blessings = ds_map_find_value(_patron, "Blessings");		
		
		draw_set_color(c_black);
		draw_text((room_width / 2) - 125, (room_height / 2)-100,string(_desc));
		draw_text((room_width / 2) - 125, (room_height / 2)-80,string(_starter));
		draw_text((room_width / 2) - 125, (room_height / 2)-60,string(_cards));
		draw_text((room_width / 2) - 125, (room_height / 2)-40,string(_gear));
		draw_text((room_width / 2) - 125, (room_height / 2)-20,string(_gold));
		for (var _k = 0; _k < 3; _k++){
			var _ref_blessing = ds_map_find_value(_array_blessings[_k],"Name");
			draw_text((room_width / 2) - 125, (room_height / 2) + (20*_k),_ref_blessing);	
		}
	}
}

//////////////////////////////////////
// DRAW GRID OF AVAILABLE BLESSINGS //
//////////////////////////////////////
if (_selected_patron != undefined && _array_blessings != undefined) {
	_blessings_start_x = room_width / 2 - (3) * (32 + 10) / 2;
	_blessings_start_y = (room_height/2) + 70;
	
	for (var _j = 0; _j < 3; _j++) {
		var _blessing = _array_blessings[_j];
		var _blessing_sprite = ds_map_find_value(_blessing, "Sprite");
		var _blessing_name = ds_map_find_value(_blessing, "Name");
		
		_blessings_x_pos = _blessings_start_x + _j * (32 + 10);
		_blessings_y_pos = _blessings_start_y;

		// Draw blessing grid
		draw_set_color(c_white);
		draw_rectangle(_blessings_x_pos, _blessings_y_pos, _blessings_x_pos + 32, _blessings_y_pos + 32, true);

		// Draw blessing sprite
		draw_sprite(_blessing_sprite, 0, _blessings_x_pos + 16, _blessings_y_pos + 16);

		// Hover effect: show blessing name
		if (mouse_x > _blessings_x_pos && mouse_x < _blessings_x_pos + 32 &&
			mouse_y > _blessings_y_pos && mouse_y < _blessings_y_pos + 32) {
				
			draw_set_color(c_white);
			draw_rectangle(_blessings_x_pos+5, _blessings_y_pos+5, _blessings_x_pos + _blessings_box_w-5, _blessings_y_pos + _blessings_box_h-5, true);

			draw_set_color(c_gray);
			draw_rectangle(mouse_x, mouse_y - 30, mouse_x + string_width(_blessing_name) + 10, mouse_y, true);
			draw_set_color(c_white);
			draw_text(mouse_x + 5, mouse_y - 27, _blessing_name);
		}

		// Select blessing on left click
		if (mouse_check_button_pressed(mb_left) &&
			mouse_x > _blessings_x_pos && mouse_x < _blessings_x_pos + 32 &&
			mouse_y > _blessings_y_pos && mouse_y < _blessings_y_pos + 32) {
			
			_selected_blessing = _blessing;
		}

		// Draw selection indicator
		if (_selected_blessing == _blessing) {
			draw_sprite_ext(spr_selected_arrow, 0, _blessings_x_pos+2, _blessings_y_pos+2,0.45,0.45,0,c_white,1);
			var _desc = ds_map_find_value(_blessing, "Description");	
		
			draw_set_color(c_black);
			draw_text((room_width / 2) - 125, (room_height / 2)+100,string(_desc));
		}
	}
}



/////////////////////////////////////////////////
// DRAW CONFIRM BUTTON IF A PATRON & BLESSING ARE SELECTED //
/////////////////////////////////////////////////
if (_selected_patron != undefined && _selected_blessing != undefined) {
	draw_sprite(spr_button_confirm, 0, room_width / 2, _blessings_start_y + 80);

	// Highlight confirm button on hover
	if (mouse_x > room_width / 2 - 32 && mouse_x < room_width / 2 + 32 &&
		mouse_y > _blessings_start_y + 80 - 16 && mouse_y < _blessings_start_y + 80 + 16) {
		
		
		draw_set_color(c_white);
		draw_rectangle(room_width / 2 - 32, _blessings_start_y + 80 - 16, room_width / 2 + 32, _blessings_start_y + 80 + 16, true);
		
		// On click, confirm selection
		if (mouse_check_button_pressed(mb_left) && _flag_confirm_active == false) {
			_flag_confirm_active = true;
			if (instance_exists(obj_passer) == false){
				_ref_passer = instance_create_layer(0,0,"GUI",obj_passer);	
			} 
			_ref_passer._pass_patron = ds_map_find_value(_selected_patron, "Name");
			_ref_passer._pass_starter = ds_map_find_value(_selected_patron, "Starter");
			_ref_passer._pass_cards = ds_map_find_value(_selected_patron, "Cards");
			_ref_passer._pass_gear = ds_map_find_value(_selected_patron, "Gear");
			_ref_passer._pass_gold = ds_map_find_value(_selected_patron, "Bonus Gold");
		
			_ref_passer._pass_blessing = _selected_blessing[?"Name"];
		
			//recieve the OK from passer checker (script that will check if all values have been passed properly)
			if (scr_passer_check("New Game") == true){
				//START TRANSITION TO OVERWORLD
				}	
			else {
				show_debug_message(string(scr_passer_check("New Game")));
				_flag_confirm_active = false;
			}
		}
	}
}