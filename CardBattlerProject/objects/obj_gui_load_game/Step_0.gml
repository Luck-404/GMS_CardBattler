/// Left Pressed Event (inside obj_save_menu)
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

if (_mx < 1135 && _mx > 1114 && _my < 308 && _my> 289){
	image_index = 1;
	if (mouse_check_button(mb_left)){
		image_index = 2;
	}
	if (mouse_check_button_released(mb_left)){
		global.flag_gui_open = false;
		instance_destroy();
	}
} else {
	image_index = 0;
}



for (var _i = 0; _i < array_length(global.saves_list); _i++) {
    var _save = global.saves_list[_i];

    if (point_in_rectangle(_mx, _my, _save._x1, _save._y1, _save._x2, _save._y2)) {
		_hover = true;
		if (mouse_check_button_pressed(mb_left)){
		    var _file_path = global.save_folder + _save._name;
		    scr_load(_file_path);
		    break;
		}
    } else {
		_hover = false;
	}
}