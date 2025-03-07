//////////////////////////////////////////////////////////////////////
//						SCR_INIT_ENEMY_CARD							//
//																	//
// > SPAWNS AN ENEMY CARD FROM THEIR POOL, THE CARD INHERITS		//
//	 THE INFO IT NEEDS.												//
//////////////////////////////////////////////////////////////////////
function scr_init_enemy_card(_ref_card,_ref_unit){
	var _ref_card_instance = instance_create_layer(_ref_unit.x, _ref_unit.y-200, "GUI", obj_enemy_card);
        _ref_card_instance._card_name = _ref_card[? "name"];
        _ref_card_instance._card_desc = _ref_card[? "description"];
        _ref_card_instance._card_script = _ref_card[? "script"];
        _ref_card_instance._card_sprite = _ref_card[? "sprite"];
		_ref_card_instance.sprite_index = _ref_card[? "sprite"];
		_ref_card_instance.image_index = 2;
		_ref_card_instance.image_speed = 0;
		_ref_card_instance._card_target = _ref_card[? "target"];
		_ref_card_instance._card_color = _ref_card[? "color"];
		_ref_card_instance._card_type = _ref_card[? "type"];
		_ref_card_instance._card_spec_req = _ref_card[? "spec"]
		_ref_card_instance._card_class_req = _ref_card[? "class"]
		_ref_card_instance._card_ref = _ref_card;		
		_ref_card_instance._unit = _ref_unit;
		_ref_unit._card_to_play = _ref_card_instance;
}