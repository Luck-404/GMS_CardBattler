///////////////////////////////////////////////////////////////////////
//						OBJ_TRANSITION DRAW							//
//																	//
// > DRAW A LOADING BAR BASED ON THE LOADING STAGE OF THE PIPELINE	//
//////////////////////////////////////////////////////////////////////

//draw spinner
	draw_sprite_ext(spr_spinner,0,room_width/2,room_height/2,1,1,_rot,c_white,1);
	_rot++;
	if (_rot > 360){
	_rot = 0;	
	}
//draw bar outline
draw_set_color(c_white);
draw_rectangle(room_width/2-200,room_height/2-15,room_width/2+200,room_height/2+15,true);

var _x_center = room_width/2; // Target x position
var _y_center = room_height/2-45; // Target y position
//draw text and fill in bar as we move farther
switch(_loading_step){
	//MM => OW
	//OW => OW
	//Encounter => OW	
	case LOADING_STATE.CREATE_GUI:
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
			_loading_step = LOADING_STATE.CREATE_AMBIANCE;
		}
	break;
	
	case LOADING_STATE.CREATE_AMBIANCE:
		_txt = "Creating Ambiance...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
		draw_set_color(c_aqua);
		draw_rectangle(room_width/2-195,room_height/2-10,room_width/2-115,room_height/2+10,false);
		//if the next step triggers
		if (global.overworld_pipeline_state == PIPELINE_STATE.CHECK_NPC){
			_loading_step = LOADING_STATE.DATA_RETRIEVAL;
		}	
	break;
	
	case LOADING_STATE.DATA_RETRIEVAL:
		_txt = "Setting up quests...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
		draw_set_color(c_aqua);
		draw_rectangle(room_width/2-195,room_height/2-10,room_width/2-35,room_height/2+10,false);
		//if the next step triggers
		if (global.overworld_pipeline_state == PIPELINE_STATE.SPAWN_TREASURE){
			_loading_step = LOADING_STATE.SPAWN_TREASURES;
		}	
	break;
	
	case LOADING_STATE.SPAWN_TREASURES:
		_txt = "Creating Treasures...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		draw_set_color(c_aqua);
		draw_rectangle(room_width/2-195,room_height/2-10,room_width/2+45,room_height/2+10,false);
		//draw fill box
		
		//if the next step triggers
		if (global.overworld_pipeline_state == PIPELINE_STATE.SPAWN_PLAYER){
			_loading_step = LOADING_STATE.SPAWN_PLAYER;
		}	
	break;
	
	case LOADING_STATE.SPAWN_PLAYER:
		_txt = "Creating player...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
		draw_set_color(c_aqua);
		draw_rectangle(room_width/2-195,room_height/2-10,room_width/2+125,room_height/2+10,false);
		//if the next step triggers
		if (global.overworld_pipeline_state == PIPELINE_STATE.CREATE_AMBIANCE){
			_loading_step = LOADING_STATE.SPAWN_LOGGER;
		}	
	break;

	case LOADING_STATE.SPAWN_LOGGER:
		_txt = "Creating logger...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
		draw_set_color(c_aqua);
		draw_rectangle(room_width/2-195,room_height/2-10,room_width/2+195,room_height/2+10,false);
	break;
	
	

	//OW => Encounter
	case LOADING_STATE.SPAWN_ENEMY_TEAM:
		_txt = "Creating enemy team...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
			//no fill
		//if the next step triggers
		if (global.encounter_pipeline_state == PIPELINE_STATE.CREATE_AMBIANCE){
			_loading_step = LOADING_STATE.SPAWN_ALLY_TEAM;
		}	
	break;	
	
	case LOADING_STATE.SPAWN_ALLY_TEAM:
		_txt = "Creating ally team...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
		draw_set_color(c_aqua);
		draw_rectangle(room_width/2-195,room_height/2-10,room_width/2-65,room_height/2+10,false);
		//if the next step triggers
		if (global.encounter_pipeline_state == PIPELINE_STATE.CREATE_AMBIANCE){
			_loading_step = LOADING_STATE.SPAWN_DECK;
		}	
	break;	
	
	case LOADING_STATE.SPAWN_DECK:
		_txt = "Creating deck...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
			draw_set_color(c_aqua);
			draw_rectangle(room_width/2-195,room_height/2-10,room_width/2+65,room_height/2+10,false);
		//if the next step triggers
		if (global.encounter_pipeline_state == PIPELINE_STATE.CREATE_AMBIANCE){
			_loading_step = LOADING_STATE.INIT_LOGGER;
		}	
	break;	
	
	case LOADING_STATE.INIT_LOGGER:
		_txt = "Initializing logger...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
			draw_set_color(c_aqua);
			draw_rectangle(room_width/2-195,room_height/2-10,room_width/2+195,room_height/2+10,false);
	break;	
	
	
	
	//OW => MM
	case LOADING_STATE.SAVING:
		_txt = "Saving...";
		// Get text width and height
		_text_width = string_width(_txt);
		_text_height = string_height(_txt);

		// Draw centered text
		draw_text(_x_center - _text_width / 2, _y_center - _text_height / 2, _txt);
		
		//draw fill box
			draw_set_color(c_aqua);
			draw_rectangle(room_width/2-195,room_height/2-10,room_width/2+195,room_height/2+10,false);
	break;		
	
}