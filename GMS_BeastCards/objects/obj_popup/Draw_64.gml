//
//
// DRAW GUI: OBJ_POPUP
//
//

if (_text != "DEFAULT")
{
	switch(_type){
		case "TEXT":
		//show text
			draw_set_colour(_color);
			draw_text(x-(string_width(_text)/2),y,_text);
		break;
		
		case "ICON":
			//show icon
			draw_sprite(_sprite,0,x,y);
		break;
		
		case "DUAL":
			//show text
			draw_set_colour(_color);
			draw_text(x-(string_width(_text)/2),y,_text);
			//show icon (slightly higher)
			draw_sprite(_sprite,0,x,y-15);
		break;
	}
}



//kill after 1s
if (_life != 0){
	_life--;
	if (_life <= 0){
		instance_destroy();	
	}
}