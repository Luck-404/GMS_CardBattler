switch(global.overworld_pipeline_state){
	#region GUI
	case PIPELINE_STATE.CREATE_GUI: //CREATES GUI
		show_debug_message("PIPELINE: CREATING OBJ_CARD_DISPLAY");
		//CREATE THE GUI CONTROLLER
		if (instance_exists(obj_card_display) == false){
			instance_create_layer(x,y,"GUI",obj_card_display);
			//send to idle to wait for confirmation from the object.
			global.overworld_pipeline_state = PIPELINE_STATE.IDLE;			
		}
	break;
	#endregion
	
	
	
	#region AMBIANCE	
	case PIPELINE_STATE.CREATE_AMBIANCE:
		show_debug_message("PIPELINE: CREATING OBJ_MUSIC_CONTROLLER");
		//CREATE THE MUSIC CONTROLLER
		if (instance_exists(obj_music_controller) == false){
			instance_create_layer(x,y,"GUI",obj_music_controller);
			//send to idle to wait for confirmation from the object.
			global.overworld_pipeline_state = PIPELINE_STATE.IDLE;	
		}
		
		show_debug_message("PIPELINE: CREATING OBJ_SWAY_SHADER_CONTROLLER");
		//CREATE THE SWAY SHADER CONTROLLER
		if (instance_exists(obj_sway_shader_controller) == false){
			instance_create_layer(x,y,"GUI",obj_sway_shader_controller);
			//send to idle to wait for confirmation from the object.
			global.overworld_pipeline_state = PIPELINE_STATE.IDLE;	
		}		
	break;	
	#endregion	
	
	
	#region NPCS	
	case PIPELINE_STATE.CHECK_NPC:
		//CHECK RELEVANT NPCS
		show_debug_message("PIPELINE: CHECKING NPCS...");
		show_debug_message("PIPELINE: NO NPCS TO CHECK AT THIS TIME.");		
		//CHECK QUEST SPOTS
		show_debug_message("PIPELINE: CHECKING QUESTS...");
		show_debug_message("PIPELINE: NO QUESTS TO CHECK AT THIS TIME.");		
		
		//POPULATE CARD SHOP
		show_debug_message("PIPELINE: POPULATING CARD SHOP");	
		if (instance_exists(obj_card_shop) == true){	
			
		} else {
			show_debug_message("PIPELINE: COULD NOT FIND A CARD SHOP TO POPULATE.");			
		}
		
		//POPULATE MERC SHOP
		show_debug_message("PIPELINE: POPULATING MERC SHOP");	
		if (instance_exists(obj_mercenary_shop) == true){	
			
		} else {
			show_debug_message("PIPELINE: COULD NOT FIND A MERC SHOP TO POPULATE.");			
		}		
	break;	
	#endregion	
	
	case PIPELINE_STATE.SPAWN_TREASURE:
	break;	
	
	case PIPELINE_STATE.SPAWN_PLAYER:
	break;	
	
	case PIPELINE_STATE.SPAWN_STATS:
	break;	
	
	case PIPELINE_STATE.END_INIT_TRANSITION:
	break;	
	
	case PIPELINE_STATE.IDLE:
	break;
	
	case PIPELINE_STATE.TRANSITION_OUT:
	break;
	
	case PIPELINE_STATE.TRANSITION_IN:
	break;
	
	case PIPELINE_STATE.RESET:
	break;
}