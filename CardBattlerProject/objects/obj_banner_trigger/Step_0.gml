//////////////////////////////////////////////////////////////////////
//					OBJ_BANNER_TRIGGER STEP							//
//																	//
// > SPAWN A BANNER WHEN A PLAYER ENTERS, THEN SET TO TRIGGERED		//
//////////////////////////////////////////////////////////////////////
if (place_meeting(x,y,obj_player) && !instance_exists(obj_zone_banner) && _flag_triggered == false){
	//reset all other triggers
	with (obj_banner_trigger){
		_flag_triggered = false;	
	}
	//trigger this one
	_flag_triggered = true;
	show_debug_message("Triggering, will create a banner with " + string(self._color) + " " + self._text);
}