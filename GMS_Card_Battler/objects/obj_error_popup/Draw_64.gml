//////////////////////////////////////////////////////////////////////
//						OBJ_ERROR_POPUP DRAW						//
//																	//
// > REDUCE LIFE PER TICK											//
//////////////////////////////////////////////////////////////////////
if (_life > 0){
	_life--;	
	draw_set_color(c_red);
	draw_set_font(fnt_fanwood);
	draw_text(room_width/2 - string_width(_text)/2,room_height/2+300,_text);
}
else {		
	instance_destroy();
}