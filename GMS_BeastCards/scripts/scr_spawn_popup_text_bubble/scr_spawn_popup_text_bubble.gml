//
//
// SCRIPT: SCR_SPAWN_POPUP_TEXT_BUBBLE | HELPER METHOD TO CREATE A NEW TEXT BUBBLE OBJECT IN ONE LINE OF CODE | VOID
//
//
function scr_spawn_popup_text_bubble(_x,_y,_txt){
	//SPAWN BUBBLE AND PROVIDE IT THE PASSED TEXT DESCRIPTION
	var _bubble = instance_create_layer(_x,_y,"ily_fx",obj_popup_text_bubble);
	_bubble._text = _txt;
}