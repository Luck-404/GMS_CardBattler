function scr_load_room(_rminput){
	var _out = "";
	switch (_rminput){
		case "encounter":
			_out = rm_encounter;
		break;
		case "main":
			_out = rm_main_menu;
		break;
		case "ow_green":
			_out = rm_overworld_green;
		break;
		case "green_1":
			_out = rm_route_green_1;
		break;
		case "green_3":
			_out = rm_route_green_3;
		break;
	}
	return _out;
}