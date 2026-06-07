//
//
// DRAW GUI: OBJ_POPUP_BANNER | OPENS THE BANNER UP (VISUALLY) AND DISPLAYS THE TEXT FOR ITS LIFETIME
//
//

//DRAW SELF
draw_sprite(spr_popup_banner,_index,x,y);

//
// UNFURL BANNER | VISUALLY UNFURLS THE BANNER
//
#region UNFURL BANNER
if (_flag_opened == false){
	_index++;
	if (_index == 3){
		_flag_opened = true;
	}
}
#endregion

//
// DRAW TEXT | DRAWS THE BANNER TEXT
//
#region DRAW TEXT
if (_text != "DEFAULT"){
	draw_set_colour(c_black);
	draw_set_font(fnt_gui_large);
	draw_text(x-(string_width(_text)/2),y,_text);
}
#endregion

//
// DEATH COUNTDOWN | COUNTS DOWN AND KILLS AFTER 1S LIFESPAN
//
#region DEATH COUNTDOWN
if (_life <= 60){
	_life++;
	if (_life > 60){
		instance_destroy();	
	}
}
#endregion