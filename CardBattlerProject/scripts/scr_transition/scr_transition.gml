//////////////////////////////////////////////////////////////////////
//						SCR_TRANSITION								//
//																	//
// > TAKE IN A DESTINATION AND A TYPE OF TRANSITION, CREAT THE		//
//	 TRANSITION OBJECT AS NEEDED									//
//////////////////////////////////////////////////////////////////////
function scr_transition(_destination,_type,_toid,_fromid){
	switch(_destination){
		case "overworld":
			switch(_type){
				case "start": //enter overworld from main menu
					//create a transition object, pass it room to goto
					global.start_x = 1968;
					global.start_y = 1982;					
					_ref_transition = instance_create_layer(x,y,"GUI",obj_transition);
					_ref_transition._target_room = rm_overworld_green;
				break;
				
				case "new room": //enter an overworld from another overworld
					switch(_toid){
						case "green_dungeon":
						//save fromid info
						
						//create a transition object, pass it room to goto and the initial position to send the player
						global.start_x = 0;
						global.start_y = 0;	
						break;
					}
				break;
				
				case "return": //return to saved overworld from encounter
					global.start_x = global.player_xpos;
					global.start_y = global.player_ypos;					
					//create a transition object, pass it the saved global room to goto and position to goto
					_ref_transition = instance_create_layer(x,y,"GUI",obj_transition);
					_ref_transition._target_room = global.saved_room;
				break;
				
				case "load": //enter the overworld, pull from the savefile and enter the world at the saved coordinates
					//create a transition object, pass it the saved information (room) and position to goto
					_ref_transition = instance_create_layer(x,y,"GUI",obj_transition);
					_ref_transition._target_room = global.saved_room;
				break;
			}
		break;
		
		case "main menu":
			//save location and room
			global.saved_room = room;
			global.start_x = obj_player.x;
			global.start_y = obj_player.y;	
			
			//autosave the stuff
			scr_save();

			//go to main menu
			_ref_transition = instance_create_layer(x,y,"GUI",obj_transition);
			_ref_transition._target_room = rm_main_menu;
		break;
		
		case "encounter":
			//save location and room
			global.saved_room = room;
			global.start_x = obj_player.x;
			global.start_y = obj_player.y;	
			
			scr_save();
			//create a transition object and pass it the encounter room (type of encounter
			_ref_transition = instance_create_layer(x,y,"GUI",obj_transition);
			_ref_transition._target_room = rm_encounter;			
		break;
	}

}