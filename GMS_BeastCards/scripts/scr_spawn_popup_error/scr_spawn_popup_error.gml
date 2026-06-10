//
//
// SCRIPT: SCR_SPAWN_POPUP_ERROR | HELPER METHOD TO CREATE A NEW ERROR OBJECT IN ONE LINE OF CODE | VOID
//
//
function scr_spawn_popup_error(_text,_life){
	//SPAWN ERROR AND PROVIDE IT THE PASSED TEXT DESCRIPTION
	var _ref_popup = instance_create_layer(room_width/2,room_width/2+200,"ily_fx",obj_popup_error);
	_ref_popup._text = _text;
	_ref_popup._life = _life;
}