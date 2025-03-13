//////////////////////////////////////////////////////////////////////
//						SCR_CREATE_COMBAT_POPUP						//
//																	//
// > CREATE A POPUP AT THE DESIRED LOCATION							//	
//////////////////////////////////////////////////////////////////////
function scr_create_combat_popup(_target_obj,_text,_type,_tar_x,_tar_y){
	///////////////////////////
	// MAKE A RANDOM X VALUE //
	///////////////////////////
	var _rand_x = irandom_range(-25,25);
	
	////////////////////
	// DRAW ON TARGET //
	////////////////////
	if (_target_obj != undefined){
		var _popup = instance_create_layer(_target_obj.x+_rand_x, _target_obj.y+_rand_x, "GUI", obj_combat_values_popup);
		_popup._text = _text;
		_popup._type = _type;	
	}
	
	///////////////////////
	// DRAW AT X/Y COORD //
	///////////////////////
	else {
		var _popup = instance_create_layer(_tar_x+_rand_x, _tar_y+_rand_x, "GUI", obj_combat_values_popup);
		_popup._text = _text;
		_popup._type = _type;	
	}
}