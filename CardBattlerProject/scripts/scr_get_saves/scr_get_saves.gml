function scr_get_saves(){
	global.saves_list = []; // Clear previous saves

	var _file = file_find_first(global.save_folder + "Save_*.ini", fa_none);
	var _index = 0;
	var _y_offset = obj_gui_load_game.y; // Starting Y position for drawing

	while (_file != "") {
	    global.saves_list[_index] = {
	        _name: _file,
	        _x1: obj_gui_load_game.x-100,   // X start
	        _y1: _y_offset-15,
	        _x2: obj_gui_load_game.x+100,  // X end (button width)
	        _y2: _y_offset + 15
	    };
	    _index++;
	    _y_offset += 40; // Move down for next file

	    _file = file_find_next();
	}
	file_find_close();
}