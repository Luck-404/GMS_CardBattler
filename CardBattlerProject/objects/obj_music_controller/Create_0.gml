//////////////////////////////////////////////////////////////////////
//					OBJ_MUSIC_CONTROLLER CREATE						//
//																	//
// > ESTABLISH VARIABLES	 										//
//////////////////////////////////////////////////////////////////////
_flag_playing = false;
_current_zone = "Any"; //TODO - take form banners
_music_ref_playing = "None";
instance_create_layer(x,y,"GUI",obj_music_timer);