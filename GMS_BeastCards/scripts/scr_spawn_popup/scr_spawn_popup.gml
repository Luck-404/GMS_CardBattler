//
//
// SCRIPT: SCR_SPAWN_POPUP | HELPER METHOD TO CREATE A NEW POPUP OBJECT IN ONE LINE OF CODE | VOID
//
//
function scr_spawn_popup(_type,_text,_sprite,_color,_x,_y){
	//SPAWN POPUP AND PROVIDE IT THE PASSED TEXT DESCRIPTION
	var _ref_popup = instance_create_layer(_x,_y,"ily_fx",obj_popup);
	_ref_popup._type = _type;
	_ref_popup._text = _text;
	_ref_popup._sprite = _sprite;
	_ref_popup._color = _color;
	
}