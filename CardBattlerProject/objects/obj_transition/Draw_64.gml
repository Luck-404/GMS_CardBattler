///////////////////////////////////////////////////////////////////////
//						OBJ_TRANSITION DRAW							//
//																	//
// > DRAW A LOADING BAR BASED ON THE LOADING STAGE OF THE PIPELINE	//
//////////////////////////////////////////////////////////////////////

//draw spinner

//draw bar outline

//draw text and fill in bar as we move farther
switch(_loading_step){
	//MM => OW
	//OW => OW
	//Encounter => OW	
	case LOADING_STATE.CREATE_GUI
		//if (global.overworld_pipeline_state == PIPELINE_STATE.CREATE_GUI){
		//	s
		//}
	break;
	
	case LOADING_STATE.CREATE_AMBIANCE:
	
	break;
	
	case LOADING_STATE.DATA_RETRIEVAL:
	
	break;
	
	case LOADING_STATE.SPAWN_TREASURES:
	
	break;
	
	case LOADING_STATE.SPAWN_PLAYER:
	
	break;

	case LOADING_STATE.SPAWN_LOGGER:
	
	break;
	
	

	//OW => Encounter
	case LOADING_STATE.SPAWN_ENEMY_TEAM:
	
	break;	
	
	case LOADING_STATE.SPAWN_ALLY_TEAM:
	
	break;	
	
	case LOADING_STATE.SPAWN_DECK:
	
	break;	
	
	case LOADING_STATE.INIT_LOGGER:
	
	break;	
	
	
	
	//OW => MM
	case LOADING_STATE.SAVING:
	
	break;		
	
}