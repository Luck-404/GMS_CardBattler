//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_SPAWN_TEXT_BUBBLE
// FUNCTION: Creates a world-space text bubble.
//           Assigns its display text.
//           Displays the bubble at the specified room position.
//
// ARGUMENTS: _val_x and _val_y are the room-space position.
//            _str_text is the text displayed by the bubble.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_overworld_spawn_text_bubble(_val_x,_val_y,_str_text){

	//===================//
	//CREATE TEXT BUBBLE//
	//===================//
	var _ref_bubble = instance_create_layer(_val_x,_val_y,"ily_fx",obj_overworld_text_bubble);

	//================//
	//SET BUBBLE TEXT//
	//================//
	_ref_bubble._str_text = _str_text;
}