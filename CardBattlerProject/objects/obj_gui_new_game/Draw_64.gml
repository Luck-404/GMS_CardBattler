//////////////////////////////////////////////////////////////////////
//					OBJ_GUI_NEW_GAME DRAW GUI						//
//																	//
// > DRAW AND HANDLE INFORMATION ABOUT THE PATHS/PATRONS, AS WELL	//
//   AS PLAYER SELECTIONS AND THE CONFIRM BUTTON					//
//////////////////////////////////////////////////////////////////////
	///////////////////////////////
	// HANDLE 'X' CLICK TO CLOSE //
	///////////////////////////////
		if (device_mouse_x_to_gui(0) < 1135 && device_mouse_x_to_gui(0) > 1114 && mouse_y < 308 && mouse_y > 289) {
			image_index = 1;
			if (mouse_check_button(mb_left)) {
				image_index = 2;
			}
			if (mouse_check_button_released(mb_left)) {
				global.flag_gui_open = false;
				_selected_blessing = undefined;
				_selected_patron = undefined;
				instance_destroy();
			}
		} else {
			image_index = 0;
		}

	/////////////
	// PATRONS //
	/////////////
	#region PATRONS	
		draw_set_color(c_black);

		//DEFINE THE STARTING POSITION OF THE PATRONS GRID
		_patrons_start_x = room_width / 2 - (ds_list_size(_list_patrons) * (64 + 10)) / 2; 
		_patrons_start_y = room_height / 2 - 200;
		_patrons_box_w = 64;
		_patrons_box_h = 64;

		//FOR EACH VALUE IN THE PATRONS DSLIST (POPULATED IN SCR_POPULATE_PATRONS)...
		for (var _i = 0; _i < ds_list_size(_list_patrons); _i++) {
			var _patron = ds_list_find_value(_list_patrons, _i);
			var _sigil = ds_map_find_value(_patron, "Sigil");
			var _name = ds_map_find_value(_patron, "Name");

			//CALCULATE THE POSITION TO DRAW THE BOX AT
			_patrons_x_pos = _patrons_start_x + _i * (64 + 10);
			_patrons_y_pos = _patrons_start_y;

			// DRAW THE BOX
			draw_set_color(c_black);
			draw_rectangle(_patrons_x_pos, _patrons_y_pos, _patrons_x_pos + 64, _patrons_y_pos + 64, true);

			// DRAW THE PATRON'S SIGIL IN THE BOX
			if (!is_undefined(_sigil)) {
				draw_sprite(_sigil, 0, _patrons_x_pos + 32, _patrons_y_pos + 32);
			}

			// ON HOVER, HIGHLIGHT IT, SHOW A TOOLTIP
			if (device_mouse_x_to_gui(0) > _patrons_x_pos && device_mouse_x_to_gui(0) < _patrons_x_pos + _patrons_box_w &&
				mouse_y > _patrons_y_pos && mouse_y < _patrons_y_pos + _patrons_box_h) {
	
				//HIGHLIGHT
				draw_set_color(c_white);
				draw_rectangle(_patrons_x_pos+5, _patrons_y_pos+5, _patrons_x_pos + _patrons_box_w-5, _patrons_y_pos + _patrons_box_h-5, true);

				// TOOLTIPS
				draw_set_color(c_gray);
				draw_rectangle(device_mouse_x_to_gui(0), mouse_y - 30, device_mouse_x_to_gui(0) + string_width(_name) + 10, mouse_y, false);
				draw_set_color(c_white);
				draw_text(device_mouse_x_to_gui(0) + 5, mouse_y - 27, _name);
			}

			// WATCH FOR LEFT CLICKS, SET THE APPROPRIATE PATRON
			if (mouse_check_button_pressed(mb_left) &&
				device_mouse_x_to_gui(0) > _patrons_x_pos && device_mouse_x_to_gui(0) < _patrons_x_pos + _patrons_box_w &&
				mouse_y > _patrons_y_pos && mouse_y < _patrons_y_pos + _patrons_box_h) {
		
				_selected_patron = ds_list_find_value(_list_patrons, _i);
		
				//UPDATE THE ARRAY WITH THE PROPER BLESSINGS
				_array_blessings = _selected_patron[?"Blessings"];		
			}

			// DRAW INFORMATION ABOUT THE PATRON
			if (_selected_patron != undefined && _selected_patron == _patron) {
				//DRAW SELECTION INDICATOR SPRITE
				draw_sprite(spr_selected_arrow, 0, _patrons_x_pos, _patrons_y_pos);
		
				//DRAW THE TEXT INFORMATION
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
	#endregion		

	///////////////
	// BLESSINGS //
	///////////////
	#region BLESSINGS
		if (_selected_patron != undefined && array_length(_array_blessings) != 0) {
			//DEFINE STARTING POSITIONS FOR THE BLESSINGS
			_blessings_start_x = room_width / 2 - (3) * (32 + 10) / 2;
			_blessings_start_y = (room_height/2) + 70;
	
			//FOR EVERY BLESSING IN THE ARRAY (SHOULD BE 3)...
			for (var _j = 0; _j < 3; _j++) {
				var _blessing = _array_blessings[_j];
				var _blessing_sprite = ds_map_find_value(_blessing, "Sprite");
				var _blessing_name = ds_map_find_value(_blessing, "Name");

				//CALCULATE THE POSITION TO DRAW THE BOX AT
				_blessings_x_pos = _blessings_start_x + _j * (32 + 10);
				_blessings_y_pos = _blessings_start_y;

				//DRAW BOX
				draw_set_color(c_black);
				draw_rectangle(_blessings_x_pos, _blessings_y_pos, _blessings_x_pos + 32, _blessings_y_pos + 32, true);

				// DRAW ASSOCIATED SPRITE
				draw_sprite(_blessing_sprite, 0, _blessings_x_pos + 16, _blessings_y_pos + 16);

				// ON HOVER, HIGHLIGHT AND SHOW TOOLTIP
				if (device_mouse_x_to_gui(0) > _blessings_x_pos && device_mouse_x_to_gui(0) < _blessings_x_pos + 32 &&
					mouse_y > _blessings_y_pos && mouse_y < _blessings_y_pos + 32) {
				
					//HIGHLIGHT
					draw_set_color(c_white);
					draw_rectangle(_blessings_x_pos+5, _blessings_y_pos+5, _blessings_x_pos + _blessings_box_w-5, _blessings_y_pos + _blessings_box_h-5, true);

					//SHOW TOOLTIP
					draw_set_color(c_gray);
					draw_rectangle(device_mouse_x_to_gui(0), mouse_y - 30, device_mouse_x_to_gui(0) + string_width(_blessing_name) + 10, mouse_y, true);
					draw_set_color(c_white);
					draw_text(device_mouse_x_to_gui(0) + 5, mouse_y - 27, _blessing_name);
				}

				// SELECT BLESSINGS ON LEFT CLICK
				if (mouse_check_button_pressed(mb_left) &&
					device_mouse_x_to_gui(0) > _blessings_x_pos && device_mouse_x_to_gui(0) < _blessings_x_pos + 32 &&
					mouse_y > _blessings_y_pos && mouse_y < _blessings_y_pos + 32) {
					
					//SET THE BLESSING TO THE CURRENT SELECTED BLESSING
					_selected_blessing = _array_blessings[_j];
				}

				// Draw selection indicator
				if (_selected_blessing == _blessing) {
					//DRAW SELECTED ARROW
					draw_sprite_ext(spr_selected_arrow, 0, _blessings_x_pos+2, _blessings_y_pos+2,0.45,0.45,0,c_white,1);
				
					//DRAW INFORMATION
					draw_set_color(c_black);				
					var _desc = ds_map_find_value(_blessing, "Description");	
					draw_text((room_width / 2) - 125, (room_height / 2)+100,string(_desc));
				}
			}
		}
	#endregion

	/////////////
	// CONFIRM //
	/////////////
	#region CONFIRM
	if (_selected_patron != undefined && _selected_blessing != undefined) {
		//DRAW THE CONFIRM BUTTON
		draw_sprite(spr_button_confirm, 0, room_width / 2, _blessings_start_y + 80);

		// HIGHLIGHT THE CONFIRM BUTTON ON HOVER
		if (device_mouse_x_to_gui(0) > room_width / 2 - 32 && device_mouse_x_to_gui(0) < room_width / 2 + 32 &&
			mouse_y > _blessings_start_y + 80 - 16 && mouse_y < _blessings_start_y + 80 + 16) {
		
		
			draw_set_color(c_white);
			draw_rectangle(room_width / 2 - 32, _blessings_start_y + 80 - 16, room_width / 2 + 32, _blessings_start_y + 80 + 16, true);
			// HANDLE CLICKS
			if (mouse_check_button_pressed(mb_left) && (_variables_passed == false)){
				_variables_passed = true;			
				//PASS THE VALUES TO THE PASSER
				_ref_passer._pass_patron = ds_map_find_value(_selected_patron, "Name");
				_ref_passer._pass_starter = ds_map_find_value(_selected_patron, "Starter");
				_ref_passer._pass_cards = ds_map_find_value(_selected_patron, "Cards");
				_ref_passer._pass_gear = ds_map_find_value(_selected_patron, "Gear");
				_ref_passer._pass_gold = ds_map_find_value(_selected_patron, "Bonus Gold");
		
				_ref_passer._pass_blessing = _selected_blessing[?"Name"];
		
				var _check = scr_passer_check("New Game");
				//CHECK THE VALUES
				if (_check == true){ //ON OK, WE TRANSITION TO THE MAP
					//START TRANSITION TO OVERWORLD
					//close the gui
					global.flag_gui_open = false;						
					_selected_blessing = undefined;
					_selected_patron = undefined;	
					scr_transition("overworld","start",0,0);
					instance_destroy();
					}	
				else { //IF NOT OKAY, DISPLAY ERROR RECIEVED
					_variables_passed = false;
					show_debug_message(string(_check));
				}
			}
		}
	}
	#endregion