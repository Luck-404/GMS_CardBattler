//===============================================================================//
//
// SCRIPT: scr_status_trigger_damage_auras
// FUNCTION: Triggers opposing Team Auras when a Beast takes damage.
//
//===============================================================================//

function scr_status_trigger_damage_auras(_ref_damaged_beast,_val_damage){

	if (!instance_exists(_ref_damaged_beast)){
		return false;
	}

	if (_val_damage <= 0){
		return false;
	}

	if (_ref_damaged_beast._val_cur_hp <= 0){
		return false;
	}

	var _list_aura_team =
		undefined;

	if (_ref_damaged_beast._str_team == "PLAYER"){

		_list_aura_team =
			obj_battle_enemy_controller._list_beasts_alive;
	}
	else{

		_list_aura_team =
			obj_battle_player_controller._list_beasts_alive;
	}

	var _flag_triggered =
		false;

	for (
		var _it_beast = 0;
		_it_beast < ds_list_size(_list_aura_team);
		_it_beast++
	){

		var _ref_beast =
			ds_list_find_value(
				_list_aura_team,
				_it_beast
			);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		for (
			var _it_status = 0;
			_it_status < ds_list_size(_ref_beast._list_statuses);
			_it_status++
		){

			var _ref_status =
				ds_list_find_value(
					_ref_beast._list_statuses,
					_it_status
				);

			if (!instance_exists(_ref_status)){
				continue;
			}

			if (_ref_status._str_status_type != "AURA"){
				continue;
			}

			if (_ref_status._str_aura_scope != "TEAM"){
				continue;
			}

			if (_ref_status._str_aura_trigger != "ENEMY_DAMAGED"){
				continue;
			}

			if (_ref_status._scr_status == undefined){
				continue;
			}

			if (
				_ref_status._scr_status(
					"TRIGGER",
					_ref_status,
					undefined,
					_ref_damaged_beast
				)
			){

				_flag_triggered =
					true;
			}
		}
	}

	return _flag_triggered;
}