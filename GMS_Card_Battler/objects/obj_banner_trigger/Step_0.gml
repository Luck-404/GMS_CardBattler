//////////////////////////////////////////////////////////////////////
//					OBJ_BANNER_TRIGGER STEP							//
//																	//
// > SPAWN A BANNER WHEN A PLAYER ENTERS, THEN SET TO TRIGGERED		//
//////////////////////////////////////////////////////////////////////
if (instance_place(x,y,obj_player) && !instance_exists(obj_banner) && _flag_triggered == false){
	//reset all other triggers
	with (obj_banner_trigger){
		_flag_triggered = false;	
	}
	//trigger this one
	_flag_triggered = true;
	var _ref_banner = instance_create_layer(room_width/2,room_height/5,"GUI",obj_banner);
	_ref_banner._ban_color = _color;
	_ref_banner._ban_text = _text;
	
}

if (instance_exists(obj_player) && (distance_to_object(obj_player) > 128)){
	_flag_triggered = false;
}