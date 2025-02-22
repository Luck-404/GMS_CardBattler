//////////////////////////////////////////////////////////////////////
//					OBJ_GUI_NEW_GAME DRAW GUI						//
//																	//
// > DRAW AND HANDLE INFORMATION ABOUT THE PATHS/PATRONS, AS WELL	//
//   AS PLAYER SELECTIONS AND THE CONFIRM BUTTON					//
//////////////////////////////////////////////////////////////////////
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
	///////////////////////////////
	// HANDLE 'X' CLICK TO CLOSE //
	///////////////////////////////
		if (position_meeting(_mx,_my,obj_gui_new_game_close_button)) {
			obj_gui_new_game_close_button.image_index = 1;
			if (mouse_check_button_pressed(mb_left) && global._clicked == false) {
				obj_gui_new_game_close_button.image_index = 2;
				global.flag_gui_open = false;
				_selected_blessing = undefined;
				_selected_patron = undefined;
				instance_destroy(_ref_passer);
				instance_destroy();
			}
		} else {
			obj_gui_new_game_close_button.image_index = 0;
		}

	/////////////
	// PATRONS //
	/////////////
	#region PATRONS	
		if (position_meeting(_mx,_my,obj_gui_new_game_patron_button)) {
			_tar_patron = instance_nearest(_mx,_my,obj_gui_new_game_patron_button);
			_tar_patron.image_index = 1;
			_tar_patron._hover= true;
			if (mouse_check_button_pressed(mb_left) && global._clicked == false) {
				_tar_patron.image_index = 2;
				if (_tar_patron == _selected_patron){
					_tar_patron._flag_selected = false;
					_tar_patron._spawned_blessings = false;
					_selected_patron = undefined;
					_array_blessings = [];
					//delete all old blessings
					with (obj_gui_new_game_blessing_button){
						instance_destroy(obj_gui_new_game_blessing_button);
					}
				
					//delete all confirm buttons
					with (obj_gui_new_game_confirm_button){
						instance_destroy(obj_gui_new_game_confirm_button);
					}
				} else {
					//unselect all patrons
					with (obj_gui_new_game_patron_button){
						obj_gui_new_game_patron_button._flag_selected = false;
						obj_gui_new_game_patron_button._spawned_blessings = false;
						_array_blessings = [];
					}
				
					//delete all old blessings
					with (obj_gui_new_game_blessing_button){
						instance_destroy(obj_gui_new_game_blessing_button);
					}
				
					//delete all confirm buttons
					with (obj_gui_new_game_confirm_button){
						instance_destroy(obj_gui_new_game_confirm_button);
					}
					//select new patron
					_tar_patron._flag_selected = true;
					_selected_patron = _tar_patron;
					_array_blessings = _tar_patron._ref_to_patron[?"Blessings"];
				}
			}
		}
	#endregion		



	///////////////
	// BLESSINGS //
	///////////////
	#region BLESSINGS
		if (position_meeting(_mx,_my,obj_gui_new_game_blessing_button)) {
			_tar_blessing = instance_nearest(_mx,_my,obj_gui_new_game_blessing_button);
			_tar_blessing.image_index = 1;
			_tar_blessing._hover = true;
			if (mouse_check_button_pressed(mb_left) && global._clicked == false) {
				var _confirm = instance_create_layer(x,y+200,"GUI",obj_gui_new_game_confirm_button);	
				_tar_blessing.image_index = 2;
				//unselect all blessings
				with (obj_gui_new_game_blessing_button){
					obj_gui_new_game_blessing_button._selected = false;
				}
				//select new blessing
				_tar_blessing._selected = true;
				_selected_blessing = _tar_blessing;
			}
		}
	#endregion

	/////////////
	// CONFIRM //
	/////////////
	#region CONFIRM
	if (_selected_patron != undefined && _selected_blessing != undefined) {
		if (position_meeting(_mx,_my,obj_gui_new_game_confirm_button)) {
			obj_gui_new_game_confirm_button.image_index = 1;
			if (mouse_check_button_pressed(mb_left) && global._clicked == false && (_variables_passed == false)) {
				_variables_passed = true;
				//PASS THE VALUES TO THE PASSER
				_ref_passer._pass_patron =  _selected_patron._selection_patron;
				_ref_passer._pass_blessing = _selected_blessing._selection_blessing;
				
				//START TRANSITION TO OVERWORLD
				//close the gui
				global.flag_gui_open = false;						
				_selected_blessing = undefined;
				_selected_patron = undefined;	
				scr_transition("overworld","start",0,0);
				instance_destroy();
			}	
		}
	}
	#endregion