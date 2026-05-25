//
//
// DRAW GUI: OBJ_ERROR_POPUP
//
//

if (_text != "DEFAULT")
{
	draw_set_colour(c_red);
	draw_text(room_width/2-(string_width(_text)/2),room_height/2,_text);
}

//kill after 1s
if (_life != 0){
	_life--;
	if (_life <= 0){
		instance_destroy();	
	}
}