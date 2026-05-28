//
//
// SCRIPT: SCR_SPAWN_POPUP_BANNER | HELPER METHOD TO CREATE A NEW BANNER OBJECT IN ONE LINE OF CODE | VOID
//
//
function scr_spawn_popup_banner(_txt){
	//SPAWN BANNER AND PROVIDE IT THE PASSED TEXT DESCRIPTION
	var _ref_banner = instance_create_layer(room_width/2,room_height/4,"ily_fx",obj_popup_banner);
	_ref_banner._text = _txt;
}