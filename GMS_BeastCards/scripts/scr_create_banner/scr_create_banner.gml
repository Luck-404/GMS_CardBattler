//
//
// SCR_CREATE_BANNER
//
//
function scr_create_banner(_txt){
	var _ref_banner = instance_create_layer(room_width/2,room_height/4,"ily_fx",obj_banner);
	_ref_banner._text = _txt;
}