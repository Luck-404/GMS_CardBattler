//===============================================================================//
//
// SCR_INIT_MINION
// FUNCTION: Creates a battle minion from a minion ID.
//           Attaches it to the target beast.
//           Replaces the oldest minion if the target is already at capacity.
//
//===============================================================================//
function scr_init_minion(_str_id,_ref_card,_ref_caster,_ref_target){

	var _ref_new_minion = instance_create_layer(_ref_target.x,_ref_target.y,"ily_minions",obj_battle_minion);

	switch(_str_id){

		case "LIFE_SPIRIT":
			_ref_new_minion._str_team = _ref_target._str_team;
			_ref_new_minion._str_name = "LIFE SPIRIT";
			_ref_new_minion._val_cur_hp = 2;
			_ref_new_minion._val_max_hp = 2;
			_ref_new_minion._ref_host = _ref_target;
			_ref_new_minion._spr_minion = spr_minion_life_spirit;
		break;
	}
	
	if (ds_list_size(_ref_target._list_minions) < _ref_target._ct_minions_max){

		ds_list_add(_ref_target._list_minions,_ref_new_minion);

		scr_spawn_popup_scrolling("TEXT","+ MINION",undefined,c_black,_ref_target.x + irandom_range(-32,32),_ref_target.y - 24 + irandom_range(-32,32));
	}
	else{

		var _ref_old_minion = ds_list_find_value(_ref_target._list_minions,0);

		ds_list_replace(_ref_target._list_minions,0,_ref_new_minion);

		if (instance_exists(_ref_old_minion)){
			instance_destroy(_ref_old_minion);
		}

		scr_spawn_popup_scrolling("TEXT","+ MINION (REPLACED OLDEST)",undefined,c_black,_ref_target.x + irandom_range(-32,32),_ref_target.y - 24 + irandom_range(-32,32));
	}

	scr_reposition_minions(_ref_target);
	scr_reposition_statuses(_ref_target);
}