//////////////////////////////////////////////////////////////////////
//					scr_create_passive								//
//																	//
// > CREATES A PASSIVE WITH MAPPED VALUES							//
//////////////////////////////////////////////////////////////////////
function scr_create_passive(_name, _desc, _script, _unit){
	show_debug_message("creating passive");
    var _ref_new_passive = instance_create_layer(room_width/2,room_height/2,"GUI",obj_passive);
    _ref_new_passive._passive_name =  _name;
	_ref_new_passive._passive_desc =  _desc;
	_ref_new_passive._passive_script =  _script;
	_ref_new_passive._passive_unit_attached =  _unit;
   return _ref_new_passive;
}