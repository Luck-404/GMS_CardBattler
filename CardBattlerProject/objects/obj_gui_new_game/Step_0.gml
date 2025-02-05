//////////////////////////////////////////////////////////////////////
//					OBJ_GUI_NEW_GAME STEP							//
//																	//
// > HANDLE MOUSE INPUT FROM THE USER								//
//////////////////////////////////////////////////////////////////////

///////////////////////////////
// HANDLE 'X' CLICK TO CLOSE //
///////////////////////////////
	if (mouse_x < 1135 && mouse_x > 1114 && mouse_y < 308 && mouse_y > 289){
		image_index = 1;
		if (mouse_check_button(mb_left)){
			image_index = 2;
		}
		if (mouse_check_button_released(mb_left)){
			global.flag_gui_open = false;
			global.gui_active = undefined;
			instance_destroy();
		}
	} else {
		image_index = 0;
	}
	
/////////////////////////////////////////////
// WATCH FOR INTERACTIONS WITH THE PATRONS //
/////////////////////////////////////////////
	//IF HOVERING OVER THE GRID REGION, SET HOVERING TO TRUE

	//IF A LEFT CLICK IS DETECTED, SELECT THE PATRON AT THAT LIST
		//POPULATE THE BLESSINGS FROM THE NEWLY SELECTED PATRON
			//CHECK IF THE 'PATRON NAME' IN THE BLESSING LIST 0 SLOT MATCHES THE 'PATRON NAME' YOU HAVE SELECTED
				//IF IT DOESNT
					//CLEAR OLD LIST
					//POPULATE NEW LIST
					//scr_populate_blessings(_selected_patron,_list_blessings);
				//ELSE DO NOTHING

//////////////////////////////////////
// WATCH FOR INTERACTIONS BLESSINGS //
//////////////////////////////////////
	//IF HOVERING OVER THE BLESSINGS REGION, SET HOVERING TO TRUE

	//IF A LEFT CLICK IS DETECTED, SELECT THE BLESSING AT THAT LIST	
	
////////////////////////////////////
// WATCH FOR INTERACTIONS CONFIRM //
////////////////////////////////////
	//IF HOVERING OVER THE CONFIRM REGION, SET HOVERING TO TRUE

	//IF A LEFT CLICK IS DETECTED...
	
		//PASS ON ALL PROPER VARIABLES TO PASSER
		_ref_passer._pass_patron = _selected_patron[?"Name"];
		_ref_passer._pass_starter = _selected_patron[?"Starter"];
		_ref_passer._pass_cards = _selected_patron[?"Cards"];
		_ref_passer._pass_gear = _selected_patron[?"Gear"];
		_ref_passer._pass_gold = _selected_patron[?"Bonus Gold"];
		
		_ref_passer._pass_blessing = _selected_blessing[?"Name"];
		
		//recieve the OK from passer checker (script that will check if all values are okay)
		if (scr_passer_check("New Game") == true){
			//START TRANSITION TO OVERWORLD
		}