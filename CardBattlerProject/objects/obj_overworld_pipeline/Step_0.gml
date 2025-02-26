//////////////////////////////////////////////////////////////////////
//					OBJ_OVERWORLD_PIPELINE STEP						//
//																	//
// >TRACK AND PERFORM OPERATIONS FOR THE OVERWORLD'S SETUP. ALSO	//
//  HANDLE THE TRANSITION OUT OF THE ROOM TO ANOTHER.				//
//////////////////////////////////////////////////////////////////////
switch(global.overworld_pipeline_state){
	#region GUI
	/////////////////////////////////////////////////////
	//	CREATE GUI: CREATE GUI OBJECTS FOR USER TO SEE //
	/////////////////////////////////////////////////////
	case PIPELINE_STATE.CREATE_GUI: //CREATES GUI
		show_debug_message("\n==========================================================================\nOVERWORLD PIPELINE: CREATING OBJ_CARD_DISPLAY");
		//CREATE THE GUI CONTROLLER
		if (instance_exists(obj_card_display) == false){
			instance_create_layer(x,y,"GUI",obj_card_display);
		}
		if (instance_exists(obj_card_display)) {
			show_debug_message("OVERWORLD PIPELINE: SUCCESS...");				
			global.overworld_pipeline_state = PIPELINE_STATE.CREATE_AMBIANCE;	
		}
	break;
	#endregion
	
	
	
	#region AMBIANCE	
	//////////////////////////////////////////////////////
	//	CREATE AMBIANCE: MISC WORLD AMBIANCE (SFX, VFX) //
	//////////////////////////////////////////////////////
	case PIPELINE_STATE.CREATE_AMBIANCE:
		show_debug_message("OVERWORLD PIPELINE: CREATING OBJ_MUSIC_CONTROLLER");
		//CREATE THE MUSIC CONTROLLER
		if (instance_exists(obj_music_controller) == false){
			instance_create_layer(x,y,"GUI",obj_music_controller);
		}
		if (instance_exists(obj_music_controller)){
			show_debug_message("OVERWORLD PIPELINE:SUCCESS...");					
			show_debug_message("OVERWORLD PIPELINE: CREATING OBJ_SWAY_SHADER_CONTROLLER");
			//CREATE THE SWAY SHADER CONTROLLER
			if (instance_exists(obj_sway_shader_controller) == false){
				instance_create_layer(x,y,"GUI",obj_sway_shader_controller);
			}
		}
		if (instance_exists(obj_sway_shader_controller)){
			show_debug_message("OVERWORLD PIPELINE: SUCCESS...");					
			global.overworld_pipeline_state = PIPELINE_STATE.CHECK_NPC;	
	}
	break;	
	#endregion	
	
	
	
	#region NPCS, QUESTS, SHOPS
	///////////////////////////////
	//	CREATE NPCS/SHOPS/QUESTS //
	///////////////////////////////
	case PIPELINE_STATE.CHECK_NPC:
		//CHECK RELEVANT NPCS
		show_debug_message("OVERWORLD PIPELINE: CHECKING NPCS...");
		show_debug_message("OVERWORLD PIPELINE: NO NPCS TO CHECK AT THIS TIME.");		
		//CHECK QUEST SPOTS
		show_debug_message("OVERWORLD PIPELINE: CHECKING QUESTS...");
		show_debug_message("OVERWORLD PIPELINE: NO QUESTS TO CHECK AT THIS TIME.");		
		
		//POPULATE CARD SHOP
		show_debug_message("OVERWORLD PIPELINE: POPULATING CARD SHOP");	
		if ((instance_exists(obj_NPC_card_shop) == true)){	
			scr_stock_card_shop(irandom_range(3,6)); //stock card shop with 3-6 cards
			global.overworld_pipeline_state = PIPELINE_STATE.IDLE;	
		} else {
			show_debug_message("OVERWORLD PIPELINE: COULD NOT FIND A CARD SHOP TO POPULATE.");			
		}
		show_debug_message("OVERWORLD PIPELINE: SUCCESS...");				
		//POPULATE MERC SHOP
		show_debug_message("OVERWORLD PIPELINE: POPULATING MERC SHOP");	
		if ((instance_exists(obj_NPC_mercenary_shop) == true)){	
			scr_stock_mercenary_shop(irandom_range(3,6));
			global.overworld_pipeline_state = PIPELINE_STATE.IDLE;	
		} else {
			show_debug_message("OVERWORLD PIPELINE: COULD NOT FIND A MERC SHOP TO POPULATE.");			
		}
		show_debug_message("OVERWORLD PIPELINE: SUCCESS...");				
		global.overworld_pipeline_state = PIPELINE_STATE.SPAWN_TREASURE;	
	break;	
	#endregion	
	
	
	
	#region TREASURES
	///////////////////////
	//	CREATE TREASURES //
	///////////////////////
	case PIPELINE_STATE.SPAWN_TREASURE:
		//check position of placed cards
		show_debug_message("OVERWORLD PIPELINE: CHECKING PLACED TREASURES...");
		show_debug_message("OVERWORLD PIPELINE: FEATURE NOT IMPLEMENTED");		
		
		//check position of randomized chests
		show_debug_message("OVERWORLD PIPELINE: CHECKING RANDOMIZED CHESTS...");
		show_debug_message("OVERWORLD PIPELINE: FEATURE NOT IMPLEMENTED");	
		
		//spawn 3 randomized sparkly spots at the beginning of the game.
		show_debug_message("OVERWORLD PIPELINE: SPAWNING LUCKY SPOTS...");
		for (var _i = 0; _i < 3; _i++){
		    var _new_position = scr_find_valid_tile_in_tilemap();
		    if (_new_position != noone) {
		        var _new_x = _new_position[0];
		        var _new_y = _new_position[1];
		        instance_create_layer(_new_x, _new_y, "Player", obj_lucky_spot);
		    }	
		}
		show_debug_message("OVERWORLD PIPELINE: SUCCESS...");	
		global.overworld_pipeline_state = PIPELINE_STATE.SPAWN_PLAYER;
	break;
	#endregion		
	
	
	
	#region PLAYER	
	///////////////////////////////////////////////////////////////////////////////////////
	//	CREATE PLAYER: TAKE IN DATA FROM PASSER, ASSIGN POSITION BASED ON THE TRANSITION //
	///////////////////////////////////////////////////////////////////////////////////////	
	case PIPELINE_STATE.SPAWN_PLAYER:
	if (!instance_exists(obj_player)){
		show_debug_message("OVERWORLD PIPELINE: SPAWNING PLAYER...");	
		var _ref_player = instance_create_layer(global.start_x, global.start_y, "Player", obj_player);
			//PASSER STUFF (Either from load or from new game)
			if (obj_passer._pass_savefile != undefined){ //LOAD THE PLAYER STUFF from a file
				scr_init_loaded_player(_ref_player,obj_passer._pass_savefile);
			}
			else{ //set up a new player based on the chosen patron
				scr_init_new_player(_ref_player,obj_passer._pass_patron,obj_passer._pass_blessing);
			}
			show_debug_message("OVERWORLD PIPELINE: SUCCESS...");	
	}
		//delete passer
		global.player_ow_state = PLAYER_OW_STATE.GENERAL;
		instance_destroy(obj_passer);
		global.overworld_pipeline_state = PIPELINE_STATE.SPAWN_STATS;	
	break;	
	#endregion		
	
	
	
	#region STATS	
	///////////////////////////
	//	CREATE STATS TRACKER //
	///////////////////////////////////////////////////////////////////////////////////////		
	case PIPELINE_STATE.SPAWN_STATS:
		//spawn stats tracker
		show_debug_message("OVERWORLD PIPELINE: SPAWNING STATS TRACKER...");
		show_debug_message("OVERWORLD PIPELINE: FEATURE NOT IMPLEMENTED\n==========================================================================\n");
		global.overworld_pipeline_state = PIPELINE_STATE.END_INIT_TRANSITION;			
	break;	
	#endregion	
	
	
	
	#region END INIT	
	case PIPELINE_STATE.END_INIT_TRANSITION:
		global.player_xpos = obj_player.x;
		global.player_ypos = obj_player.y;
		global.saved_room = room;
		scr_save();
		obj_transition._transition_state_tracker = TRANSITION_STATE.FADE_IN;
		global.overworld_pipeline_state = PIPELINE_STATE.IDLE;	
	break;	
	#endregion 
	
	
	
	#region IDLE		
	case PIPELINE_STATE.IDLE:
	break;
	#endregion	
}