function scr_get_saves(){
	while (instance_exists(obj_gui_load_savefile) == true){ // Delete all previous saves
		instance_destroy(obj_gui_load_savefile);
	}
	
	var _file = file_find_first(global.save_folder + "Save_*.ini", fa_none);
	var _index = 0;
	var _y_offset = obj_gui_load_game.y-200; // Starting Y position for drawing
	var _x_offset = obj_gui_load_game.x;
	
	while (_file != "") {
		_ref_button = instance_create_layer(_x_offset,_y_offset+_index,"GUI",obj_gui_load_savefile);
		_ref_button._savename = _file;
		_index= _index+40;
	    _file = file_find_next();
	}
	file_find_close();
}