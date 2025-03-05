//////////////////////////////////////////////////////////////////////
//						SCR_INIT_ENEMY_CARD							//
//																	//
// > SPAWNS AN ENEMY CARD FROM THEIR POOL, THE CARD INHERITS		//
//	 THE INFO IT NEEDS.												//
//////////////////////////////////////////////////////////////////////
function scr_init_enemy_card(_ref_card,_ref_unit){
	var _ref_card_instance = instance_create_layer(room_width/2, room_height/2, "GUI", obj_enemy_card);
        _ref_card_instance._card_name = _ref_card[? "name"];
        _ref_card_instance._card_desc = _ref_card[? "description"];
        _ref_card_instance._card_script = _ref_card[? "script"];
        _ref_card_instance._card_sprite = _ref_card[? "sprite"];
		_ref_card_instance._card_target = _ref_card[? "target"];
		_ref_card_instance._card_color = _ref_card[? "color"];
		_ref_card_instance._card_type = _ref_card[? "type"];
		_ref_card_instance._card_spec_req = _ref_card[? "spec"]
		_ref_card_instance._card_class_req = _ref_card[? "class"]
		_ref_unit._card_selected = _ref_card_instance;
		_ref_card_instance._card_ref = _ref_card;		
		_ref_card_instance._unit = _ref_unit;
}