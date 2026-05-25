//
//
// SCR_CREATE_POPUP
//
//
function scr_create_error_popup(_text){
	var _ref_popup = instance_create_layer(_x,_y,"ily_fx",obj_error_popup);
	_ref_popup._text = _text;
	
}