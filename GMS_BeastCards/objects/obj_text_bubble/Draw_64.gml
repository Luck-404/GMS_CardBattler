//
//
// DRAW GUI: OBJ_TEXT_BUBBLE
//
//

if (_text != "DEFAULT")
{
    // text dimensions
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
//kill after 1s

if (_life != 0){
	_life--;
	if (_life <= 0){
		instance_destroy();	
	}
}

if (distance_to_object(obj_player) > 256){
	instance_destroy();	
}