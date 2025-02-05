//////////////////////////////////////////////////////////////////////
//					OBJ_GUI_NEW_GAME DRAW GUI						//
//																	//
// > DRAW THE INFORMATION ABOUT THE PATHS/PATRONS, AS WELL AS		//
//   PLAYER SELECTIONS AND THE CONFIRM BUTTON						//
//////////////////////////////////////////////////////////////////////
//DRAW PATRON GRID across top (3 for now)
draw_set_color(c_black);
	//for each patron..
	for (var _i = 0; _i < ds_list_size(_list_patrons); _i++){
			
	}
	
	//DRAW A WHITE BOX ON HOVER
	if (_flag_hover_patron == true){
		var _ref_patron = 0; //figure out the size of each 'patron square', then check mouse position based on the x and y coordinates/size and index we're looking at
		
		//DISPLAY THE COLOR-NAME OF THE PATRON AS A LITTLE DIALOGUE BOX
		var _patron_name = 
	}
	//DRAW SELECTED PATRON INFO
	
		//DRAW YELLOW ARROWS SPRITE WHEN SELECTED

//DRAW GRID OF AVAILABLE BLESSINGS
	if (_selected_patron != 0){


			//DRAW A WHITE BOX ON HOVER
				//DISPLAY THE NAME OF THE BLESSING AS A LITTLE DIALOGUE BOX
	
			//DRAW SELECTED BLESSING INFO
				//DRAW YELLOW ARROWS SPRITE WHEN SELECTED	

	}
	
//DRAW CONFIRM BUTTON IF A PATRON AND BLESSING HAVE BEEN SELECTED	
	if (_selected_patron != 0 && _selected_blessing !=0){
			//DRAW CONFIRM SPRITE

			//DRAW A WHITE BOX ON HOVER

	}