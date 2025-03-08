function scr_card_grow_manavine_repeat(_target,_repeat){
	if (_repeat == false){
		//decrement bonus mana
		global.bonus_mana = global.bonus_mana - 2;
		global.cur_mana = global.cur_mana - 2;
		
		//remove from active utility list
		for (var _i = 0; _i < ds_list_size(global.encounter_utility_active); _i++){
			var _util = ds_list_find_value(global.encounter_utility_active,_i);
			if(_util._counter_name == "Manavine"){
				ds_list_delete(global.encounter_utility_active,_i);
			}
		}	

	} else {
		var _ref_effect = instance_create_layer(room_width/2,room_height/2,"Effects",obj_card_effect);
		_ref_effect.sprite_index = spr_effect_grow_manavine_repeat;
	}
}