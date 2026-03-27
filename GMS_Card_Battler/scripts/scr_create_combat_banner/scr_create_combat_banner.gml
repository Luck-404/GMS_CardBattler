//////////////////////////////////////////////////////////////////////
//					SCR_CREATE_COMBAT_BANNER						//
//																	//
// > CREATES A BANNER WITH THE CHOSEN COLOR AND TEXT				//	
//////////////////////////////////////////////////////////////////////
function scr_create_combat_banner(_color,_text){
		var _ref_banner = instance_create_layer(room_width/2,room_height/2-500,"GUI",obj_banner);
		_ref_banner._ban_color = _color;
		_ref_banner._ban_text = _text;	
}