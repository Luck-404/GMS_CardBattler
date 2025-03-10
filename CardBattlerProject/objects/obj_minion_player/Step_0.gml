//////////////////////////////////////////////////////////////////////
//						OBJ_MINION_PLAYER STEP						//
//																	//
// > CAST EACH MINION'S SPELL IN ORDER							    //
//////////////////////////////////////////////////////////////////////
if (_execute == true && instance_exists(obj_timer) == false){
	if (ds_list_size(_playlist) > 0){
		//find minion
		var _minion = ds_list_find_value(_playlist,0);
		_cursor_x = _minion.x;
		_cursor_y = _minion.y+128;
		show_debug_message("cursor x: " + string(_cursor_x) + " cursor y: " + string(_cursor_y));
		
		//execute minion's script
		_minion._trigger_my_effect = true;
		


		
		//remove from playlist
		ds_list_delete(_playlist,0);
		
		//create timer 
		var _ref_timer = instance_create_layer(10,10,"GUI",obj_timer);
		_ref_timer._life = _play_speed; //0.25s
	} else {
		instance_destroy();	
	}
} 
else {

}










