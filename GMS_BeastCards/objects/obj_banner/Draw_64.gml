//
//
// DRAW GUI: OBJ_BANNER
//
//

draw_self();
if (_flag_opened == false){
	image_index++;
	if (image_index == 3){
		_flag_opened = true;
	}
}

if (_text != "DEFAULT"){
	draw_set_colour(c_black);
	draw_text(x-(string_width(_text)/2),y,_text);
}

//kill after 1s
if (_life <= 60){
	_life++;
	if (_life > 60){
		instance_destroy();	
	}
}