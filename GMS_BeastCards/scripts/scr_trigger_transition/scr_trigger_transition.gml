function scr_trigger_transition(_dest){
	var _transition = instance_create_layer(room_width/2,room_height/2,"ily_fx",obj_transition);
	_transition._destination = _dest;
}