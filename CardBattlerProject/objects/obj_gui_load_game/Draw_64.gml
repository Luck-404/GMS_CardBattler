/// Draw event (inside obj_save_menu)
draw_self();
draw_set_color(c_white);
draw_set_font(fnt_fanwood_sm);

for (var _i = 0; _i < array_length(global.saves_list); _i++) {
    var _save = global.saves_list[_i];

    // Draw rectangle as a button
	if (_hover){
		draw_set_color(c_lime);	
	} else {
		draw_set_color(c_gray);
	}
    draw_rectangle(_save._x1, _save._y1, _save._x2, _save._y2, false);

    // Draw save file name
    draw_set_color(c_white);
    draw_text(_save._x1 + 10, _save._y1 + 5, _save._name);
}