///////////////////////////////////////////////////////////////////////
//						OBJ_TRANSITION DRAW							//
//																	//
// > DRAW A LOADING BAR BASED ON THE LOADING STAGE OF THE PIPELINE	//
//////////////////////////////////////////////////////////////////////
//draw self
draw_sprite(spr_fx_black,0,(display_get_gui_width()/2),(display_get_gui_height()/2));

//draw spinner
	draw_sprite_ext(spr_spinner,0,display_get_gui_width()/2,(display_get_gui_height()/2)-200,1,1,_rot,c_white,1);
	_rot++;
	if (_rot > 360){
	_rot = 0;	
	}
//draw bar outline
draw_set_color(c_white);
draw_rectangle((display_get_gui_width()/2)-200,(display_get_gui_height()/2)-15,(display_get_gui_width()/2)+200,(display_get_gui_height()/2)+15,true);

var _x_center = display_get_gui_width()/2; // Target x position
var _y_center = (display_get_gui_height()/2)-45; // Target y position
//draw text and fill in bar as we move farther
switch(_loading_step){
	/////////////////////////////////////////
	// MM => OW, OW => OW, ENCOUNTER -> OW //
	/////////////////////////////////////////
	
	/////////////////////////////////////////////
	// CREATE THE GUI GOING INTO THE OVERWORLD //
	/////////////////////////////////////////////
	case LOADING_STATE.OW_CREATE_GUI:
		var _txt = "Creating GUI...";
		// Get text width and height
		var _text_width = string_width(_txt);
		var _text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
			//no progress
		//if the next step triggers
		if (global.overworld_pipeline_state == PIPELINE_STATE.CREATE_AMBIANCE){
			_loading_step = LOADING_STATE.OW_CREATE_AMBIANCE;
		}
	break;
	
	/////////////////////////
	// CREATE THE AMBIANCE //
	/////////////////////////
	case LOADING_STATE.OW_CREATE_AMBIANCE:
		_txt = "Creating Ambiance...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
		draw_set_color(c_aqua);
		draw_rectangle((display_get_gui_width()/2)-195,(display_get_gui_height()/2)-10,(display_get_gui_width()/2)-115,(display_get_gui_height()/2)+10,false);
		//if the next step triggers
		if (global.overworld_pipeline_state == PIPELINE_STATE.CHECK_NPC){
			_loading_step = LOADING_STATE.OW_DATA_RETRIEVAL;
		}	
		draw_set_color(c_white);
	break;
	
	//////////////////////////
	// LOAD QUESTS AND SUCH //
	//////////////////////////
	case LOADING_STATE.OW_DATA_RETRIEVAL:
		_txt = "Setting up quests...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
		draw_set_color(c_aqua);
		draw_rectangle((display_get_gui_width()/2)-195,(display_get_gui_height()/2)-10,(display_get_gui_width()/2)-35,(display_get_gui_height()/2)+10,false);
		//if the next step triggers
		if (global.overworld_pipeline_state == PIPELINE_STATE.SPAWN_TREASURE){
			_loading_step = LOADING_STATE.OW_SPAWN_TREASURES;
		}	
	break;
	
	/////////////////////
	// SPAWN TREASURES //
	/////////////////////	
	case LOADING_STATE.OW_SPAWN_TREASURES:
		_txt = "Creating Treasures...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		draw_set_color(c_aqua);
		draw_rectangle((display_get_gui_width()/2)-195,(display_get_gui_height()/2)-10,(display_get_gui_width()/2)+45,(display_get_gui_height()/2)+10,false);
		//draw fill box
		
		//if the next step triggers
		if (global.overworld_pipeline_state == PIPELINE_STATE.SPAWN_PLAYER){
			_loading_step = LOADING_STATE.OW_SPAWN_PLAYER;
		}	
	break;
	
	///////////////////
	// SPAWN PLAYERS //
	///////////////////
	case LOADING_STATE.OW_SPAWN_PLAYER:
		_txt = "Creating player...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
		draw_set_color(c_aqua);
		draw_rectangle((display_get_gui_width()/2)-195,(display_get_gui_height()/2)-10,(display_get_gui_width()/2)+125,(display_get_gui_height()/2)+10,false);
		//if the next step triggers
		if (global.overworld_pipeline_state == PIPELINE_STATE.CREATE_AMBIANCE){
			_loading_step = LOADING_STATE.OW_SPAWN_LOGGER;
		}	
	break;

	//////////////////
	// SPAWN LOGGER //
	//////////////////
	case LOADING_STATE.OW_SPAWN_LOGGER:
		_txt = "Creating logger...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
		draw_set_color(c_aqua);
		draw_rectangle((display_get_gui_width()/2)-195,(display_get_gui_height()/2)-10,(display_get_gui_width()/2)+195,(display_get_gui_height()/2)+10,false);
	break;
	
	
	///////////////////////
	//// OW => Encounter //
	///////////////////////
	
	///////////////////////////////////////////////
	//// CREATE THE GUI GOING INTO THE ENCOUNTER //
	///////////////////////////////////////////////
	case LOADING_STATE.ENC_INIT:
		_txt = "Loading encounter";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
			draw_set_color(c_aqua);
			draw_rectangle((display_get_gui_width()/2)-195,(display_get_gui_height()/2)-10,(display_get_gui_width()/2)+195,(display_get_gui_height()/2)+10,false);
	break;		
	
	//////////
	// SAVE //
	//////////
	case LOADING_STATE.SAVING:
		_txt = "Saving...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
			draw_set_color(c_aqua);
			draw_rectangle((display_get_gui_width()/2)-195,(display_get_gui_height()/2)-10,(display_get_gui_width()/2)+195,(display_get_gui_height()/2)+10,false);
	break;		

	//////////
	// IDLE //
	//////////
	case LOADING_STATE.IDLE:

	break;	
}