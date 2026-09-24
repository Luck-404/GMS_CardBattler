//===============================================================================//
//
// SCRIPT: SCR_BATTLE_SACRIFICE
// FUNCTION: Resolves standardized battle sacrifice costs for host Health,
//           Minions, and selected corpses. Host Health sacrifice bypasses
//           Armor, Overhealth, damage prevention, and damage reactions.
//           Minion sacrifice always routes through scr_minion_destroy with the
//           SACRIFICE reason. Corpse sacrifice preserves the corpse instance
//           but marks it consumed.
//
// ARGUMENTS: _str_type - HOST_HEALTH, MINION, or CORPSE.
//            _ref_source - Beast paying Health / owning Minions, or selected corpse.
//            _value - Health amount, Minion count, OLDEST, NEWEST, or ALL.
//            _stct_options - optional percent_max_hp, teamwide,
//            suppress_endless_bloom flags.
// RETURNS: Result struct with success, sacrifice count, actual HP sacrificed,
//          and total Maximum HP of sacrificed Minions.
//
//===============================================================================//
function scr_battle_sacrifice(_str_type,_ref_source,_value=1,_stct_options=undefined){
	var _stct_result = {
		_flag_success : false,
		_ct_sacrificed : 0,
		_val_hp_sacrificed : 0,
		_val_minion_max_hp : 0
	};

	if (!is_string(_str_type)){
		return _stct_result;
	}

	_str_type = string_upper(_str_type);

	//================//
	//HOST HEALTH//
	//================//
	if (_str_type == "HOST_HEALTH"){
		if (!instance_exists(_ref_source) || _ref_source._val_cur_hp <= 0 || !is_real(_value)){
			return _stct_result;
		}

		var _flag_percent_max_hp = false;

		if (
			is_struct(_stct_options) &&
			variable_struct_exists(_stct_options,"percent_max_hp")
		){
			_flag_percent_max_hp = (_stct_options.percent_max_hp == true);
		}

		var _val_requested = max(0,_value);

		if (_flag_percent_max_hp){
			_val_requested = ceil(_ref_source._val_max_hp * (_val_requested / 100));
		}

		var _val_hp_loss = min(_val_requested,_ref_source._val_cur_hp);

		if (_val_hp_loss <= 0){
			return _stct_result;
		}

		_ref_source._val_cur_hp = max(0,_ref_source._val_cur_hp - _val_hp_loss);

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_hp_loss) + " HP",
			undefined,
			c_red,
			_ref_source.x,
			_ref_source.y - 48
		);

		_stct_result._flag_success = true;
		_stct_result._ct_sacrificed = 1;
		_stct_result._val_hp_sacrificed = _val_hp_loss;

		scr_debug_log(
			"BATTLE",
			"SACRIFICE",
			_ref_source,
			string_upper(_ref_source._str_team) +
			" HOST HEALTH SACRIFICED: " + string(_val_hp_loss),
			"BATTLE",
			"SCR_BATTLE_SACRIFICE"
		);

		return _stct_result;
	}

	//================//
	//MINION//
	//================//
	if (_str_type == "MINION"){
		if (!instance_exists(_ref_source)){
			return _stct_result;
		}

		var _flag_teamwide = false;
		var _flag_suppress_endless_bloom = false;

		if (is_struct(_stct_options)){
			if (variable_struct_exists(_stct_options,"teamwide")){
				_flag_teamwide = (_stct_options.teamwide == true);
			}

			if (variable_struct_exists(_stct_options,"suppress_endless_bloom")){
				_flag_suppress_endless_bloom = (_stct_options.suppress_endless_bloom == true);
			}
		}

		var _arr_candidates = [];

		if (_flag_teamwide){
			var _list_allies = scr_battle_get_target_team_list(_ref_source);

			if (_list_allies == undefined || !ds_exists(_list_allies,ds_type_list)){
				return _stct_result;
			}

			for (var _it_ally = 0;_it_ally < ds_list_size(_list_allies);_it_ally++){
				var _ref_ally = ds_list_find_value(_list_allies,_it_ally);

				if (
					!instance_exists(_ref_ally) ||
					_ref_ally._str_list != "ALIVE" ||
					_ref_ally._val_cur_hp <= 0 ||
					!ds_exists(_ref_ally._list_minions,ds_type_list)
				){
					continue;
				}

				for (var _it_minion = 0;_it_minion < ds_list_size(_ref_ally._list_minions);_it_minion++){
					var _ref_minion = ds_list_find_value(_ref_ally._list_minions,_it_minion);

					if (instance_exists(_ref_minion)){
						array_push(_arr_candidates,_ref_minion);
					}
				}
			}
		}
		else{
			if (!ds_exists(_ref_source._list_minions,ds_type_list)){
				return _stct_result;
			}

			for (var _it_minion = 0;_it_minion < ds_list_size(_ref_source._list_minions);_it_minion++){
				var _ref_minion = ds_list_find_value(_ref_source._list_minions,_it_minion);

				if (instance_exists(_ref_minion)){
					array_push(_arr_candidates,_ref_minion);
				}
			}
		}

		if (array_length(_arr_candidates) <= 0){
			return _stct_result;
		}

		var _it_start = 0;
		var _ct_requested = 1;

		if (is_string(_value)){
			switch (string_upper(_value)){
				case "ALL":
					_ct_requested = array_length(_arr_candidates);
				break;

				case "NEWEST":
					_it_start = array_length(_arr_candidates) - 1;
					_ct_requested = 1;
				break;

				case "OLDEST":
					_ct_requested = 1;
				break;

				default:
					return _stct_result;
			}
		}
		else if (is_real(_value)){
			_ct_requested = clamp(floor(_value),0,array_length(_arr_candidates));
		}
		else{
			return _stct_result;
		}

		for (var _it_sacrifice = 0;_it_sacrifice < _ct_requested;_it_sacrifice++){
			var _it_candidate = _it_start + _it_sacrifice;

			if (_it_candidate < 0 || _it_candidate >= array_length(_arr_candidates)){
				break;
			}

			var _ref_minion = _arr_candidates[_it_candidate];

			if (!instance_exists(_ref_minion)){
				continue;
			}

			var _val_minion_max_hp = _ref_minion._val_max_hp;

			if (!scr_minion_destroy(
				_ref_minion,
				"SACRIFICE",
				undefined,
				_flag_suppress_endless_bloom
			)){
				continue;
			}

			_stct_result._ct_sacrificed++;
			_stct_result._val_minion_max_hp += _val_minion_max_hp;
		}

		_stct_result._flag_success = (_stct_result._ct_sacrificed > 0);

		return _stct_result;
	}

	//================//
	//CORPSE//
	//================//
	if (_str_type == "CORPSE"){
		if (!instance_exists(_ref_source)){
			return _stct_result;
		}

		if (
			!is_struct(_ref_source._ref_unit) ||
			_ref_source._str_list != "DEAD" ||
			_ref_source._val_cur_hp > 0 ||
			_ref_source._flag_captured ||
			_ref_source._flag_corpse_consumed
		){
			return _stct_result;
		}

		_ref_source._flag_corpse_consumed = true;

		scr_battle_vfx_expend(_ref_source);

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"CORPSE RECYCLED",
			undefined,
			c_green,
			_ref_source.x,
			_ref_source.y - 48
		);

		var _str_source = "SYSTEM";

		if (
			instance_exists(global.ref_cast_card) &&
			is_struct(global.ref_cast_card._ref_card)
		){
			_str_source = string_upper(global.ref_cast_card._ref_card._str_card_name);
		}

		scr_debug_log(
			"BATTLE",
			"SACRIFICE",
			_ref_source,
			string_upper(_ref_source._str_team) + " " +
			string_upper(_ref_source._ref_unit._str_beast_name) +
			" (LVL " + string(_ref_source._ref_unit._val_beast_level) + ")" +
			" CORPSE SACRIFICED" +
			" | SOURCE: " + _str_source,
			"BATTLE",
			"SCR_BATTLE_SACRIFICE"
		);

		_stct_result._flag_success = true;
		_stct_result._ct_sacrificed = 1;

		return _stct_result;
	}

	return _stct_result;
}