switch(global.overworld_pipeline_state){
	#region GUI
	case ENCOUNTER_PIPELINE_STATE.CREATE_GUI: //CREATES GUI
		show_debug_message("PIPELINE: CREATING OBJ_CARD_DISPLAY");
		//CREATE THE GUI CONTROLLER
		if (instance_exists(obj_card_display) == false){
			instance_create_layer(x,y,"GUI",obj_card_display);
			//send to idle to wait for confirmation from the object.
			global.overworld_pipeline_state = ENCOUNTER_PIPELINE_STATE.IDLE;			
		}
		global.overworld_pipeline_state = ENCOUNTER_PIPELINE_STATE.IDLE;	
	break;
	#endregion
	
	
	
	#region AMBIANCE	
	case ENCOUNTER_PIPELINE_STATE.CREATE_AMBIANCE:
		show_debug_message("PIPELINE: CREATING OBJ_MUSIC_CONTROLLER");
		//CREATE THE MUSIC CONTROLLER
		if (instance_exists(obj_music_controller) == false){
			instance_create_layer(x,y,"GUI",obj_music_controller);
			//send to idle to wait for confirmation from the object.
			global.overworld_pipeline_state = ENCOUNTER_PIPELINE_STATE.IDLE;	
		}
		
		show_debug_message("PIPELINE: CREATING OBJ_SWAY_SHADER_CONTROLLER");
		//CREATE THE SWAY SHADER CONTROLLER
		if (instance_exists(obj_sway_shader_controller) == false){
			instance_create_layer(x,y,"GUI",obj_sway_shader_controller);
			//send to idle to wait for confirmation from the object.
			global.overworld_pipeline_state = ENCOUNTER_PIPELINE_STATE.IDLE;	
		}
		global.overworld_pipeline_state = ENCOUNTER_PIPELINE_STATE.IDLE;			
	break;	
	#endregion	
	
	
	
	#region NPCS, QUESTS, SHOPS
	case ENCOUNTER_PIPELINE_STATE.CHECK_NPC:
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
			global.overworld_pipeline_state = ENCOUNTER_PIPELINE_STATE.IDLE;	
		} else {
			show_debug_message("PIPELINE: COULD NOT FIND A CARD SHOP TO POPULATE.");			
		}
		
		//POPULATE MERC SHOP
		show_debug_message("PIPELINE: POPULATING MERC SHOP");	
		if ((instance_exists(obj_mercenary_shop) == true) && global.counter_merc_shop_reset == 0){	
			scr_stock_mercenary_shop(irandom_range(3,6));
			global.counter_merc_shop_reset = 3;
			global.overworld_pipeline_state = ENCOUNTER_PIPELINE_STATE.IDLE;	
		} else {
			show_debug_message("PIPELINE: COULD NOT FIND A MERC SHOP TO POPULATE.");			
		}
		global.overworld_pipeline_state = ENCOUNTER_PIPELINE_STATE.SPAWN_TREASURE;	
	break;	
	#endregion	
	
	
	
	#region TREASURES
	case ENCOUNTER_PIPELINE_STATE.SPAWN_TREASURE:
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
		global.overworld_pipeline_state = ENCOUNTER_PIPELINE_STATE.SPAWN_PLAYER;
	break;
	#endregion		
	
	
	
	#region PLAYER	
	case ENCOUNTER_PIPELINE_STATE.SPAWN_PLAYER:
	
	break;	
	#endregion		
	
	
	
	case ENCOUNTER_PIPELINE_STATE.SPAWN_STATS:
	break;	
	
	case ENCOUNTER_PIPELINE_STATE.END_INIT_TRANSITION:
	break;	
	
	case ENCOUNTER_PIPELINE_STATE.IDLE:
	break;
	
	case ENCOUNTER_PIPELINE_STATE.TRANSITION_OUT:
	break;
	
	case ENCOUNTER_PIPELINE_STATE.TRANSITION_IN:
	break;
	
	case ENCOUNTER_PIPELINE_STATE.RESET:
	break;
}