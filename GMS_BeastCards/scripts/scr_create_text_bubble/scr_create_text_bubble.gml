//
//
// SCR_CREATE_TEXT_BUBBLE
//
//
function scr_create_text_bubble(_x,_y,_txt){
	var _bubble = instance_create_layer(_x,_y,"ily_fx",obj_text_bubble);
	_bubble._text = _txt;
}