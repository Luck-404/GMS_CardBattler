//===============================================================================//
//
// SCR_DAMAGE_TARGET
// FUNCTION: Deals damage to a target battle beast.
//           Applies caster stat scaling, dodge, crits, weather, weakness,
//           defender mitigation, minion absorption, armor, overhealth, and HP loss.
//
//===============================================================================//
function scr_damage_target(_val_damage,_ref_target){

	var _val_damage_left = _val_damage;

	//
	// ATTACKER STAT SCALING
	//
	var _str_card_stat = global.ref_cast_card._ref_card._str_card_stat;

	if (_str_card_stat == "PHY"){

		var _val_ppow_stat = global.ref_caster_beast._ref_unit._val_beast_ppow_stat;
		var _val_ppow_mod = scr_get_beast_grade_modifier(_val_ppow_stat);

		_val_damage_left = ceil(_val_damage_left * _val_ppow_mod);
	}

	if (_str_card_stat == "MAG"){

		var _val_mpow_stat = global.ref_caster_beast._ref_unit._val_beast_mpow_stat;
		var _val_mpow_mod = scr_get_beast_grade_modifier(_val_mpow_stat);

		_val_damage_left = ceil(_val_damage_left * _val_mpow_mod);
	}

	//
	// TARGET DODGE
	//
	var _val_dodge = global.ref_target_beast._ref_unit._val_beast_dod_stat;
	var _val_dodge_roll = irandom_range(0,100);

	if (_val_dodge_roll < _val_dodge){

		scr_spawn_popup_scrolling("TEXT","DODGED",undefined,c_white,_ref_target.x + irandom_range(-32,32),_ref_target.y - 24 + irandom_range(-32,32));

		exit;
	}

	//
	// CRIT
	//
	var _val_crit = global.ref_caster_beast._ref_unit._val_beast_crit_stat;
	var _val_crit_roll = irandom_range(0,100);

	if (_val_crit_roll < _val_crit){

		_val_damage_left *= 2;

		scr_spawn_popup_scrolling("TEXT","CRIT",undefined,c_maroon,_ref_target.x + irandom_range(-32,32),_ref_target.y - 24 + irandom_range(-32,32));
	}

	//
	// RAPID GROWTH BONUS
	//
	var _ref_status = scr_check_for_status("WEATHER: RAPID GROWTH",global.list_statuses);

	if (_ref_status != -1){

		var _arr_card_colors = global.ref_cast_card._ref_card._arr_card_colors;

		if (_arr_card_colors[0] == "VIRIDIAN"){
			_val_damage_left = ceil(_val_damage_left * 1.25);
		}
	}

	//
	// WEAKNESS
	//
	_ref_status = scr_check_for_status("WEAKNESS",global.ref_caster_beast);

	var _ct_weak_stacks = 0;

	if (_ref_status != -1){
		_ct_weak_stacks = _ref_status._ct_status_stacks;
	}

	_val_damage_left -= (_ct_weak_stacks * 2);

	if (_val_damage_left <= 0){

		scr_spawn_popup_scrolling("TEXT","TOO WEAK",undefined,c_white,global.ref_caster_beast.x + irandom_range(-32,32),global.ref_caster_beast.y - 24 + irandom_range(-32,32));

		exit;
	}

	//
	// DEFENDER MITIGATION
	//
	if (_str_card_stat == "PHY"){

		var _val_pdef_stat = global.ref_target_beast._ref_unit._val_beast_pdef_stat;
		var _val_pdef_mod = scr_get_beast_grade_modifier(_val_pdef_stat);

		_val_damage_left = ceil(_val_damage_left * (1 / _val_pdef_mod));
	}

	if (_str_card_stat == "MAG"){

		var _val_mdef_stat = global.ref_target_beast._ref_unit._val_beast_mdef_stat;
		var _val_mdef_mod = scr_get_beast_grade_modifier(_val_mdef_stat);

		_val_damage_left = ceil(_val_damage_left * (1 / _val_mdef_mod));
	}

	//
	// MINION ABSORPTION
	//
	var _list_minions = _ref_target._list_minions;
	var _ct_minions = ds_list_size(_list_minions);

	if (_ct_minions > 0 && _val_damage_left > 0){

		var _val_damage_per_minion = _val_damage_left div _ct_minions;
		var _val_remainder = _val_damage_left mod _ct_minions;

		var _val_total_applied = 0;

		for (var _it_minion = _ct_minions - 1; _it_minion >= 0; _it_minion--){

			var _ref_minion = ds_list_find_value(_list_minions,_it_minion);

			if (!instance_exists(_ref_minion)){
				continue;
			}

			var _val_take = _val_damage_per_minion;

			if (_val_remainder > 0){
				_val_take++;
				_val_remainder--;
			}

			var _val_actual = min(_val_take,_ref_minion._val_cur_hp);

			_ref_minion._val_cur_hp -= _val_actual;
			_val_total_applied += _val_actual;

			if (_ref_minion._val_cur_hp <= 0){

				_ref_minion._val_cur_hp = 0;

				scr_spawn_popup_scrolling("TEXT","-" + string(_val_actual),undefined,c_maroon,_ref_target.x + irandom_range(-32,32),_ref_target.y - 24 + irandom_range(-32,32));

				ds_list_delete(_list_minions,_it_minion);
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
	if (_val_damage_left > 0 && _ref_target._val_armor > 0){

		var _val_blocked = min(_ref_target._val_armor,_val_damage_left);

		scr_spawn_popup_scrolling("TEXT","-" + string(_val_blocked),undefined,c_blue,_ref_target.x + irandom_range(-32,32),_ref_target.y - 24 + irandom_range(-32,32));

		_ref_target._val_armor -= _val_blocked;
		_val_damage_left -= _val_blocked;
	}

	//
	// OVERHEALTH
	//
	if (_val_damage_left > 0 && _ref_target._val_overhealth > 0){

		var _val_blocked = min(_ref_target._val_overhealth,_val_damage_left);

		scr_spawn_popup_scrolling("TEXT","-" + string(_val_blocked),undefined,c_green,_ref_target.x + irandom_range(-32,32),_ref_target.y - 24 + irandom_range(-32,32));

		_ref_target._val_overhealth -= _val_blocked;
		_val_damage_left -= _val_blocked;
	}

	//
	// HOST HP
	//
	if (_val_damage_left > 0){

		scr_spawn_popup_scrolling("TEXT","-" + string(_val_damage_left),undefined,c_maroon,_ref_target.x + irandom_range(-32,32),_ref_target.y - 24 + irandom_range(-32,32));

		_ref_target._val_cur_hp -= _val_damage_left;
	}
}