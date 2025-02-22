//////////////////////////////////////////////////////////////////////
//					OBJ_BANNER_TRIGGER STEP							//
//																	//
// > SPAWN A BANNER WHEN A PLAYER ENTERS, THEN SET TO TRIGGERED		//
//////////////////////////////////////////////////////////////////////
if (instance_place(x,y,obj_player) && !instance_exists(obj_zone_banner) && _flag_triggered == false){
	//show_debug_message("PLAYER HAS ENTERED BANNER TRIGGER");
	//reset all other triggers
	with (obj_banner_trigger){
		_flag_triggered = false;	
	}
	//trigger this one
	_flag_triggered = true;
	//show_debug_message("Triggering, will create a banner with " + string(self._color) + " " + self._text);
	var _ref_banner = instance_create_layer(room_width/2,room_height/5,"GUI",obj_zone_banner);
	_ref_banner._ban_color = _color;
	_ref_banner._ban_text = _text;
	
}

if (instance_exists(obj_player) && (distance_to_object(obj_player) > 128)){
	_flag_triggered = false;
}