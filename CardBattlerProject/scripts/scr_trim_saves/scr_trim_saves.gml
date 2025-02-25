//////////////////////////////////////////////////////////////////////
//							SCR_TRIM_SAVED							//
//																	//
// > DELETE ALL BUT THE 10 MOST RECENT FILES IN THE SAVES DIRECTORY	//										//
//////////////////////////////////////////////////////////////////////
function scr_trim_saves(){
	//FIND A FILE
	var _file = file_find_first(global.save_folder + "*.ini", fa_none);
	var _count = 1;
	//COUNT FOR 10 FILES
	while (_file != "") {
		//EXCESS FILES GET DELETED
		if (_count > 10){
			file_delete(global.save_folder + _file);
		}
		_file = file_find_next();
		_count++;
	}
	
}