function scr_trim_saves(){
	var _file = file_find_first(global.save_folder + "*.ini", fa_none);
	var _count = 1;
	while (_file != "") {
		if (_count > 10){
			file_delete(global.save_folder + _file);
		}
		_file = file_find_next();
		_count++;
	}
	
}