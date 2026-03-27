function scr_save_room(_rminput){
	var _out = "";
	switch (_rminput){
		case rm_encounter:
			_out =  "encounter";
		break;
		case rm_main_menu:
			_out =  "main";
		break;
		case rm_overworld_green:
			_out =  "ow_green";
		break;
		case rm_route_green_3:
			_out =  "green_1";
		break;
		case rm_route_green_1:
			_out =  "green_3";
		break;
	}
	return _out;
}