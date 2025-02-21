function scr_load(){
	var _file_path = argument0;

	if (file_exists(_file_path)) {
	    ini_open(_file_path);
	    obj_passer.stax = ini_read_real("Player", "x", 0);
	    obj_passer.y = ini_read_real("Player", "y", 0);
	    ini_close();

	    show_message("Game loaded successfully!");
	} else {
	    show_message("Error: Save file not found.");
	}
}