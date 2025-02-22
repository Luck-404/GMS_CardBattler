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
		show_debug_message("\nPIPELINE: CREATING OBJ_CARD_DISPLAY");
		//CREATE THE GUI CONTROLLER
		if (instance_exists(obj_card_display) == false){
			instance_create_layer(x,y,"GUI",obj_card_display);
			//TODO - chECKER?	
		}
		if (instance_exists(obj_card_display)) {
			show_debug_message("PIPELINE: SUCCESS...");				
			global.overworld_pipeline_state = PIPELINE_STATE.CREATE_AMBIANCE;	
		}
	break;
	#endregion
	
	
	
	#region AMBIANCE	
	//////////////////////////////////////////////////////
	//	CREATE AMBIANCE: MISC WORLD AMBIANCE (SFX, VFX) //
	//////////////////////////////////////////////////////
	case PIPELINE_STATE.CREATE_AMBIANCE:
		show_debug_message("PIPELINE: CREATING OBJ_MUSIC_CONTROLLER");
		//CREATE THE MUSIC CONTROLLER
		if (instance_exists(obj_music_controller) == false){
			instance_create_layer(x,y,"GUI",obj_music_controller);
			//TODO - chECKER?	
		}
		if (instance_exists(obj_music_controller)){
			show_debug_message("PIPELINE: SUCCESS...");					
			show_debug_message("PIPELINE: CREATING OBJ_SWAY_SHADER_CONTROLLER");
			//CREATE THE SWAY SHADER CONTROLLER
			if (instance_exists(obj_sway_shader_controller) == false){
				instance_create_layer(x,y,"GUI",obj_sway_shader_controller);
				//TODO - chECKER?	
			}
		}
		if (instance_exists(obj_sway_shader_controller)){
			show_debug_message("PIPELINE: SUCCESS...");					
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
		show_debug_message("PIPELINE: CHECKING NPCS...");
		show_debug_message("PIPELINE: NO NPCS TO CHECK AT THIS TIME.");		
		//CHECK QUEST SPOTS
		show_debug_message("PIPELINE: CHECKING QUESTS...");
		show_debug_message("PIPELINE: NO QUESTS TO CHECK AT THIS TIME.");		
		
		//POPULATE CARD SHOP
		show_debug_message("PIPELINE: POPULATING CARD SHOP");	
		if ((instance_exists(obj_card_shop) == true) && global.counter_card_shop_reset == 0){	
			scr_stock_card_shop(irandom_range(3,6)); //stock card shop with 3-6 cards
			global.counter_card_shop_reset = 3;
			global.overworld_pipeline_state = PIPELINE_STATE.IDLE;	
		} else {
			show_debug_message("PIPELINE: COULD NOT FIND A CARD SHOP TO POPULATE.");			
		}
		show_debug_message("PIPELINE: SUCCESS...");				
		//POPULATE MERC SHOP
		show_debug_message("PIPELINE: POPULATING MERC SHOP");	
		if ((instance_exists(obj_mercenary_shop) == true) && global.counter_merc_shop_reset == 0){	
			scr_stock_mercenary_shop(irandom_range(3,6));
			global.counter_merc_shop_reset = 3;
			global.overworld_pipeline_state = PIPELINE_STATE.IDLE;	
		} else {
			show_debug_message("PIPELINE: COULD NOT FIND A MERC SHOP TO POPULATE.");			
		}
		show_debug_message("PIPELINE: SUCCESS...");				
		global.overworld_pipeline_state = PIPELINE_STATE.SPAWN_TREASURE;	
	break;	
	#endregion	
	
	
	
	#region TREASURES
	///////////////////////
	//	CREATE TREASURES //
	///////////////////////
	case PIPELINE_STATE.SPAWN_TREASURE:
		//check position of placed cards
		show_debug_message("PIPELINE: CHECKING PLACED TREASURES...");
		show_debug_message("PIPELINE: FEATURE NOT IMPLEMENTED");		
		
		//check position of randomized chests
		show_debug_message("PIPELINE: CHECKING RANDOMIZED CHESTS...");
		show_debug_message("PIPELINE: FEATURE NOT IMPLEMENTED");	
		
		//spawn 3 randomized sparkly spots at the beginning of the game.
		show_debug_message("PIPELINE: SPAWNING LUCKY SPOTS...");
		for (var _i = 0; _i < 3; _i++){
		    var _new_position = scr_find_valid_tile_in_tilemap();
		    if (_new_position != noone) {
		        var _new_x = _new_position[0];
		        var _new_y = _new_position[1];
		        instance_create_layer(_new_x, _new_y, "Player", obj_treasure);
		    }	
		}
		show_debug_message("PIPELINE: SUCCESS...");	
		global.overworld_pipeline_state = PIPELINE_STATE.SPAWN_PLAYER;
	break;
	#endregion		
	
	
	
	#region PLAYER	
	///////////////////////////////////////////////////////////////////////////////////////
	//	CREATE PLAYER: TAKE IN DATA FROM PASSER, ASSIGN POSITION BASED ON THE TRANSITION //
	///////////////////////////////////////////////////////////////////////////////////////	
	case PIPELINE_STATE.SPAWN_PLAYER:
		show_debug_message("PIPELINE: SPAWNING PLAYER...");	
		var _ref_player = instance_create_layer(global.start_x, global.start_y, "Player", obj_player);
			//PASSER STUFF (Either from load or from new game)
			if (obj_passer._pass_savefile != undefined){ //LOAD THE PLAYER STUFF
				
			}
			else{ //set up a new player
				
			}
		show_debug_message("PIPELINE: SUCCESS...");	
		global.overworld_pipeline_state = PIPELINE_STATE.SPAWN_STATS;	
	break;	
	#endregion		
	
	
	
	#region STATS	
	///////////////////////////
	//	CREATE STATS TRACKER //
	///////////////////////////////////////////////////////////////////////////////////////		
	case PIPELINE_STATE.SPAWN_STATS:
		//spawn stats tracker
		show_debug_message("PIPELINE: SPAWNING STATS TRACKER...");
		show_debug_message("PIPELINE: FEATURE NOT IMPLEMENTED");
		global.overworld_pipeline_state = PIPELINE_STATE.END_INIT_TRANSITION;			
	break;	
	#endregion	
	
	
	
	#region END INIT	
	case PIPELINE_STATE.END_INIT_TRANSITION:
		obj_transition._transition_state_tracker = TRANSITION_STATE.FADE_IN;
		global.overworld_pipeline_state = PIPELINE_STATE.IDLE;	
	break;	
	#endregion 
	
	
	
	#region IDLE		
	case PIPELINE_STATE.IDLE:
	
	break;
	#endregion	
	
	
	
	#region TRANSITION OUT		
	case PIPELINE_STATE.TRANSITION_OUT:
	break;
	#endregion
	
	
	
	#region TRANSITION IN			
	case PIPELINE_STATE.TRANSITION_IN:
	break;
	#endregion
	
	
	
	#region RESET		
	case PIPELINE_STATE.RESET:
	break;
	#endregion	
}