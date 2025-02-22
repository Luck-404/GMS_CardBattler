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
					global.start_x = 4130;
					global.start_y = 5391;					
					_ref_transition = instance_create_layer(x,y,"GUI",obj_transition);
					_ref_transition._target_room = rm_overworld_green;
				break;
				
				case "new room": //enter an overworld from another overworld
				var _ref_passer = instance_create_layer(x,y,"GUI",obj_passer);
					switch(_toid){
						case rm_overworld_green:
							switch(_fromid){
								case rm_route_green_1:
									//create a transition object, pass it room to goto and the initial position to send the player
									global.start_x = 1966;
									global.start_y = 116;	
									obj_player.x = 1966;
									obj_player.y = 116;
									obj_player._flag_moving = false;											
									obj_player._target_x = 1966;
									obj_player._target_y = 116;
									_ref_transition = instance_create_layer(x,y,"GUI",obj_transition);
									_ref_transition._target_room = rm_overworld_green;
									global.saved_room = rm_overworld_green;
								break;
								
								case rm_route_green_3:
									//create a transition object, pass it room to goto and the initial position to send the player
									global.start_x = 4078;
									global.start_y = 5684;	
									obj_player.x = 4078;
									obj_player.y = 5684;		
									obj_player._flag_moving = false;									
									obj_player._target_x = 4078;
									obj_player._target_y = 5684;									
									_ref_transition = instance_create_layer(x,y,"GUI",obj_transition);
									_ref_transition._target_room = rm_overworld_green;
									global.saved_room = rm_overworld_green;
								break;
							}
						break;
						
						case rm_route_green_1:
							switch(_fromid){
									case rm_overworld_green:
										//create a transition object, pass it room to goto and the initial position to send the player
										global.start_x = 2990;
										global.start_y = 5720;	
										obj_player.x = 2990;
										obj_player.y = 5720;
										obj_player._flag_moving = false;
										obj_player._target_x = 2990;
										obj_player._target_y = 5720;										
										_ref_transition = instance_create_layer(x,y,"GUI",obj_transition);
										_ref_transition._target_room = rm_route_green_1;
										global.saved_room = rm_route_green_1;
									break;
							}
						break;
						
						case rm_route_green_3:
							switch(_fromid){
									case rm_overworld_green:
										//create a transition object, pass it room to goto and the initial position to send the player
										global.start_x = 3888;
										global.start_y = 150;	
										obj_player.x = 3888;
										obj_player.y = 150;
										obj_player._flag_moving = false;											
										obj_player._target_x = 3888;
										obj_player._target_y = 150;										
										_ref_transition = instance_create_layer(x,y,"GUI",obj_transition);
										_ref_transition._target_room = rm_route_green_3;
										global.saved_room = rm_route_green_3;
									break;
							}
						break;
					}
				break;
				
				case "return": //return to saved overworld from encounter				
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
			global.player_xpos = obj_player.x;
			global.player_ypos = obj_player.y;	
			
			//autosave the stuff
			scr_save();
			
			instance_destroy(obj_player);
			
			//go to main menu
			_ref_transition = instance_create_layer(x,y,"GUI",obj_transition);
			_ref_transition._target_room = rm_main_menu;
		break;
		
		case "encounter":
			//save location and room
			global.saved_room = room;
			global.player_xpos = obj_player.x;
			global.player_ypos = obj_player.y;	
			
			scr_save();
			//create a transition object and pass it the encounter room (type of encounter
			_ref_transition = instance_create_layer(x,y,"GUI",obj_transition);
			_ref_transition._target_room = rm_encounter;			
		break;
	}

}