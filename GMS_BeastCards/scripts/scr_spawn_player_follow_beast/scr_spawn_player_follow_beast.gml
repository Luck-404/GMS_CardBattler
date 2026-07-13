function scr_spawn_player_follow_beast(){

	if (room == rm_battle){
		exit;
	}

	with (obj_beast_world){
		if (_str_team == "PLAYER"){
			instance_destroy();
		}
	}

	if (!global.flag_companion_summoned){
		exit;
	}

	if (!instance_exists(obj_player)){
		exit;
	}

	if (ds_list_size(global.list_player_party) <= 0){
		exit;
	}

	var _ref_unit = ds_list_find_value(global.list_player_party,0);

	if (_ref_unit == undefined){
		exit;
	}

	var _ref_beast = instance_create_layer(obj_player.x,obj_player.y + 32,"ily_npcs",obj_beast_world);

	_ref_beast._str_team = "PLAYER";
	_ref_beast._ref_unit = _ref_unit;
	_ref_beast._spr_shadow = scr_get_beast_type_shadow(_ref_unit._str_beast_color_type);
	_ref_beast._spr_beast = _ref_unit._spr_beast;
	

}