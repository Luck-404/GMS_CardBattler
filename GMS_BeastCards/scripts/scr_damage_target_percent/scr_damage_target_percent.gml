//===============================================================================//
//
// SCRIPT: SCR_DAMAGE_TARGET_SCALAR
// FUNCTION: Deals percentage-based maximum-HP damage to a battle beast.
//           A supplied value of 15 represents 15% of the target's maximum HP.
//           Applies all standard offensive and defensive damage modifiers.
//
//===============================================================================//

function scr_damage_target_percent(_val_damage_percent,_ref_target){

	//----------------//
	// VALIDATE INPUT //
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_ref_target._ref_unit == undefined){
		return false;
	}

	if (_val_damage_percent <= 0){
		return false;
	}

	var _ref_caster = global.ref_caster_beast;
	var _ref_cast_card = global.ref_cast_card;

	if (!instance_exists(_ref_caster)){
		return false;
	}

	if (_ref_caster._ref_unit == undefined){
		return false;
	}

	if (!instance_exists(_ref_cast_card)){
		return false;
	}

	if (_ref_cast_card._ref_card == undefined){
		return false;
	}

	var _stct_card = _ref_cast_card._ref_card;
	var _str_card_stat = _stct_card._str_card_stat;

	//
	// BASE PERCENTAGE DAMAGE
	//
	// 15 becomes 0.15.
	// Example: 101 max HP * 0.15 = 15.15, rounded up to 16.
	//
	var _val_damage_scalar = _val_damage_percent / 100;
	var _val_damage_left = ceil(
		_ref_target._val_max_hp * _val_damage_scalar
	);

	//
	// ATTACKER STAT SCALING
	//
	if (_str_card_stat == "PHY"){

		var _val_ppow_stat =
			_ref_caster._ref_unit._val_beast_ppow_stat;

		var _val_ppow_mod =
			scr_get_beast_grade_modifier(_val_ppow_stat);

		_val_damage_left = ceil(
			_val_damage_left * _val_ppow_mod
		);
	}
	else if (_str_card_stat == "MAG"){

		var _val_mpow_stat =
			_ref_caster._ref_unit._val_beast_mpow_stat;

		var _val_mpow_mod =
			scr_get_beast_grade_modifier(_val_mpow_stat);

		_val_damage_left = ceil(
			_val_damage_left * _val_mpow_mod
		);
	}

	//
	// TARGET DODGE
	//
	var _val_dodge = clamp(
		_ref_target._ref_unit._val_beast_dod_stat,
		0,
		100
	);

	var _val_dodge_roll = irandom_range(1,100);

	if (_val_dodge_roll <= _val_dodge){

		scr_spawn_popup_scrolling(
			"TEXT",
			"DODGED",
			undefined,
			c_white,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		return false;
	}

	//
	// CRIT
	//
	var _val_crit = clamp(
		_ref_caster._ref_unit._val_beast_crit_stat,
		0,
		100
	);

	var _val_crit_roll = irandom_range(1,100);

	if (_val_crit_roll <= _val_crit){

		_val_damage_left *= 2;

		scr_spawn_popup_scrolling(
			"TEXT",
			"CRIT",
			undefined,
			c_maroon,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	//
	// RAPID GROWTH BONUS
	//
	var _ref_status = scr_check_for_status(
		"WEATHER: RAPID GROWTH",
		global.list_statuses
	);

	if (_ref_status != -1){

		var _arr_card_colors = _stct_card._arr_card_colors;
		var _flag_viridian_card = false;

		if (is_array(_arr_card_colors)){

			for (
				var _it_color = 0;
				_it_color < array_length(_arr_card_colors);
				_it_color++
			){

				if (_arr_card_colors[_it_color] == "VIRIDIAN"){
					_flag_viridian_card = true;
					break;
				}
			}
		}

		if (_flag_viridian_card){

			_val_damage_left = ceil(
				_val_damage_left * 1.25
			);
		}
	}

	//
	// WEAKNESS
	//
	_ref_status = scr_check_for_status(
		"WEAKNESS",
		_ref_caster
	);

	var _ct_weak_stacks = 0;

	if (_ref_status != -1){
		_ct_weak_stacks = _ref_status._ct_status_stacks;
	}

	_val_damage_left -= _ct_weak_stacks * 2;

	if (_val_damage_left <= 0){

		scr_spawn_popup_scrolling(
			"TEXT",
			"TOO WEAK",
			undefined,
			c_white,
			_ref_caster.x + irandom_range(-32,32),
			_ref_caster.y - 24 + irandom_range(-32,32)
		);

		return false;
	}

	//
	// DEFENDER MITIGATION
	//
	if (_str_card_stat == "PHY"){

		var _val_pdef_stat =
			_ref_target._ref_unit._val_beast_pdef_stat;

		var _val_pdef_mod = max(
			0.1,
			scr_get_beast_grade_modifier(_val_pdef_stat)
		);

		_val_damage_left = ceil(
			_val_damage_left / _val_pdef_mod
		);
	}
	else if (_str_card_stat == "MAG"){

		var _val_mdef_stat =
			_ref_target._ref_unit._val_beast_mdef_stat;

		var _val_mdef_mod = max(
			0.1,
			scr_get_beast_grade_modifier(_val_mdef_stat)
		);

		_val_damage_left = ceil(
			_val_damage_left / _val_mdef_mod
		);
	}

	//
	// MINION ABSORPTION
	//
	var _list_minions = _ref_target._list_minions;

	// Remove stale references before dividing damage.
	for (
		var _it_minion = ds_list_size(_list_minions) - 1;
		_it_minion >= 0;
		_it_minion--
	){

		var _ref_minion =
			ds_list_find_value(_list_minions,_it_minion);

		if (!instance_exists(_ref_minion)){
			ds_list_delete(_list_minions,_it_minion);
		}
	}

	var _ct_minions = ds_list_size(_list_minions);

	if (_ct_minions > 0 && _val_damage_left > 0){

		var _val_damage_per_minion =
			_val_damage_left div _ct_minions;

		var _val_remainder =
			_val_damage_left mod _ct_minions;

		var _val_total_applied = 0;

		for (
			var _it_minion = _ct_minions - 1;
			_it_minion >= 0;
			_it_minion--
		){

			var _ref_minion =
				ds_list_find_value(_list_minions,_it_minion);

			if (!instance_exists(_ref_minion)){
				continue;
			}

			var _val_take = _val_damage_per_minion;

			if (_val_remainder > 0){
				_val_take++;
				_val_remainder--;
			}

			var _val_actual = min(
				_val_take,
				_ref_minion._val_cur_hp
			);

			if (_val_actual <= 0){
				continue;
			}

			_ref_minion._val_cur_hp -= _val_actual;
			_val_total_applied += _val_actual;

			scr_spawn_popup_scrolling(
				"TEXT",
				"-" + string(_val_actual),
				undefined,
				c_maroon,
				_ref_minion.x + irandom_range(-16,16),
				_ref_minion.y - 16 + irandom_range(-16,16)
			);

			if (_ref_minion._val_cur_hp <= 0){

				_ref_minion._val_cur_hp = 0;

				ds_list_delete(
					_list_minions,
					_it_minion
				);

				instance_destroy(_ref_minion);
			}
		}

		_val_damage_left -= _val_total_applied;

		scr_reposition_minions(_ref_target);
		scr_reposition_statuses(_ref_target);
	}

	//
	// ARMOR
	//
	if (
		_val_damage_left > 0 &&
		_ref_target._val_armor > 0
	){

		var _val_blocked = min(
			_ref_target._val_armor,
			_val_damage_left
		);

		scr_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_blocked),
			undefined,
			c_blue,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		_ref_target._val_armor -= _val_blocked;
		_val_damage_left -= _val_blocked;
	}

	//
	// OVERHEALTH
	//
	if (
		_val_damage_left > 0 &&
		_ref_target._val_overhealth > 0
	){

		var _val_blocked = min(
			_ref_target._val_overhealth,
			_val_damage_left
		);

		scr_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_blocked),
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		_ref_target._val_overhealth -= _val_blocked;
		_val_damage_left -= _val_blocked;
	}

	//
	// HOST HP
	//
	var _val_hp_damage = 0;

	if (_val_damage_left > 0){

		_val_hp_damage = min(
			_val_damage_left,
			_ref_target._val_cur_hp
		);

		if (_val_hp_damage > 0){

			scr_spawn_popup_scrolling(
				"TEXT",
				"-" + string(_val_hp_damage),
				undefined,
				c_maroon,
				_ref_target.x + irandom_range(-32,32),
				_ref_target.y - 24 + irandom_range(-32,32)
			);

			_ref_target._val_cur_hp = max(
				0,
				_ref_target._val_cur_hp - _val_hp_damage
			);
		}
	}

	//
	// ON TARGET HELD ITEM
	//
	if (_val_hp_damage > 0){

		var _stct_target_item =
			_ref_target._stct_held_item;

		if (
			_stct_target_item != undefined &&
			_stct_target_item != "EMPTY"
		){

			if (
				_stct_target_item._str_item_trigger_type ==
				"ON_TARGET"
			){

				if (_stct_target_item._scr_item != undefined){

					var _flag_triggered = script_execute(
						_stct_target_item._scr_item,
						"TRIGGER",
						_stct_target_item,
						_ref_target
					);

					if (_flag_triggered){
						_ref_target._stct_held_item = "EMPTY";
					}
				}
			}
		}
	}

	//
	// ON HIT HELD ITEM
	//
	var _stct_caster_item =
		_ref_caster._stct_held_item;

	if (
		_stct_caster_item != undefined &&
		_stct_caster_item != "EMPTY"
	){

		if (
			_stct_caster_item._str_item_trigger_type ==
			"ON_HIT"
		){

			if (_stct_caster_item._scr_item != undefined){

				script_execute(
					_stct_caster_item._scr_item,
					"TRIGGER",
					_stct_caster_item,
					_ref_caster,
					_ref_target,
					_str_card_stat
				);
			}
		}
	}

	return true;
}