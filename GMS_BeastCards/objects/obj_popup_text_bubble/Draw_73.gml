//
//
// DRAW GUI: OBJ_POPUP_TEXT_BUBBLE | DESCRIPTION
//
//

//
// DRAW TEXT BUBBLE AND TEXT | DRAWS TEXT BUBBLE WITH TEXT INSIDE OF IT
//
#region DRAW BUBBLE AND TEXT
if (_text != "DEFAULT")
{
    // text dimensions
	draw_set_font(fnt_small_gui);	
    var tw = string_width(_text);
    var th = string_height(_text);
    
    // bubble bounds
    var left   = x - (tw / 2) - _pad;
    var right  = x + (tw / 2) + _pad;
    var top    = y - _pad;
    var bottom = y + th + _pad;

    // background
    draw_set_colour(c_white);
    draw_rectangle(left, top, right, bottom, false);

    // text
    draw_set_colour(c_black);
    draw_text(x - (tw / 2), y, _text);
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

//
// DEATH ON DISTANCE | KILLS OBJECT IF IT IS TOO FAR FROM THE PLAYER
//
#region DEATH IF TOO FAR FROM PLAYER
if (distance_to_object(obj_player) > 256){
	instance_destroy();	
}
#endregion