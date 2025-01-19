function scr_card_grow_manavine_repeat(_target,_repeat){
	if (_repeat == false){
		global.max_mana--;
	} else {
		var _ref_effect = instance_create_layer(room_width/2,room_height/2,"Effects",obj_card_effect);
		_ref_effect.sprite_index = spr_effect_grow_manavine_repeat;
	}
}