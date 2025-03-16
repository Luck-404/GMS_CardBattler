//////////////////////////////////////////////////////////////////////
//					SCR_CREATE_CARD_OBJECT							//
//																	//
// > CREATE A CARD OBJECT											//
//////////////////////////////////////////////////////////////////////
function scr_create_card_object(_list,_card_ref){
	
	//new card object	
	var _new_card_object = instance_create_layer(86,952,"GUI",obj_card);

	//implement all data needed
	_new_card_object._list = _list;		
    _new_card_object._card_name = _card_ref[? "name"];
    _new_card_object._card_desc = _card_ref[? "description"];
    _new_card_object._card_cost = _card_ref[? "cost"];
    _new_card_object._card_script = _card_ref[? "script"];
    _new_card_object._card_sprite = _card_ref[? "sprite"];
	_new_card_object.sprite_index = _card_ref[? "sprite"];
	_new_card_object.image_index = 2;
	_new_card_object.image_speed = 0;
	_new_card_object._card_color = _card_ref[? "color"];
	_new_card_object._card_type = _card_ref[? "type"];
	_new_card_object._card_spec_req = _card_ref[? "spec"];
	_new_card_object._card_class_req = _card_ref[? "class"];
	_new_card_object._card_range = _card_ref[? "range"];
	_new_card_object._card_ref = _card_ref;
	_new_card_object._card_target_count = _card_ref[? "targets"];
	_new_card_object._card_animation_time = _card_ref[? "time"];
			
			
	if(_card_ref[? "range"] == "Targetless"){
		_new_card_object._flag_targetless = true;			
	}
			
	return _new_card_object;
}