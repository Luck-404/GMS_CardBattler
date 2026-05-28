//
//
// DRAW GUI: OBJ_POPUP_BANNER | DRAWS THE ERROR MESSAGE ACROSS THE SCREEN
//
//

//
// DRAW TEXT | DRAWS THE BANNER TEXT
//
#region DRAW TEXT
if (_text != "DEFAULT")
{
	draw_set_colour(c_red);
	draw_set_font(fnt_gui_medium);
	draw_text(room_width/2-(string_width(_text)/2),room_height/2,_text);
}
#endregion

//
// DEATH COUNTDOWN | COUNTS DOWN AND KILLS AFTER 1S LIFESPAN
//
#region DEATH COUNTDOWN
if (_life != 0){
	_life--;
	if (_life <= 0){
		instance_destroy();	
	}
}
#endregion