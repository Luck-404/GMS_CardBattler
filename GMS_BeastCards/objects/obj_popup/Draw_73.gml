//
//
// DRAW GUI: OBJ_POPUP | DISPLAYS A NEW TEXT OR ICON (OR BOTH) POPUP AT DESIGNATED LOCATION
//
//

//
// SWITCH BY TYPE | SWITCHES THE TYPE OF POPUP ACTION BASED ON PASSED TYPE
//
#region POPUP ACTION
if (_text != "DEFAULT")
{
	switch(_type){
		
		#region TEXT
		case "TEXT":
			//DRAW TEXT
			draw_set_colour(_color);
			draw_set_font(fnt_small_gui);
			draw_text(x-(string_width(_text)/2),y,_text);
		break;
		#endregion
		
		#region ICON
		case "ICON":
			//DRAW ICON
			draw_sprite(_sprite,0,x,y);
		break;
		#endregion
		
		#region DUAL
		case "DUAL":
			//DRAW TEXT
			draw_set_colour(_color);
			draw_set_font(fnt_medium_gui);
			draw_text(x-(string_width(_text)/2),y,_text);
			//DRAW ICON (SLIGHTLY HIGHER)
			draw_sprite(_sprite,0,x,y-15);
		break;
		#endregion
	}
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