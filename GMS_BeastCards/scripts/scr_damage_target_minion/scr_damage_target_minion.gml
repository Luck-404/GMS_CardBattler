//===============================================================================//
//
// SCRIPT: SCR_DAMAGE_TARGET_MINION
// FUNCTION: Deals fixed damage from a minion to a battle Beast.
//           Damage passes through defending minions, Armor, Overhealth, and HP.
//           Does not use Beast Power scaling, card scaling, crit, or card context.
//
//===============================================================================//

function scr_damage_target_minion(_val_damage,_ref_target){

	if (!instance_exists(_ref_target)){
		return false;
	}

	var _val_damage_left = max(0,_val_damage);

	if (_val_damage_left <= 0){
		return false;
	}

	//----------------//
	//DAMAGE REDIRECT//
	//----------------//
	_ref_target = scr_resolve_damage_redirect(_ref_target);

	if (!instance_exists(_ref_target)){
		return false;
	}

	//-------------------//
	//MINION ABSORPTION//
	//-------------------//
	var _list_minions = _ref_target._list_minions;

	for (
		var _it_minion = ds_list_size(_list_minions) - 1;
		_it_minion >= 0;
		_it_minion--
	){

		var _ref_minion =
			ds_list_find_value(
				_list_minions,
				_it_minion
			);

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
				ds_list_find_value(
					_list_minions,
					_it_minion
				);

			if (!instance_exists(_ref_minion)){
				continue;
			}

			var _val_take =
				_val_damage_per_minion;

			if (_val_remainder > 0){
				_val_take++;
				_val_remainder--;
			}

			var _val_actual =
				min(
					_val_take,
					_ref_minion._val_cur_hp
				);

			if (_val_actual <= 0){
				continue;
			}

			_ref_minion._val_cur_hp -=
				_val_actual;

			_val_total_applied +=
				_val_actual;

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

				scr_destroy_minion(_ref_minion);
			}
		}

		_val_damage_left -=
			_val_total_applied;
	}

	//-------//
	//ARMOR//
	//-------//
	if (
		_val_damage_left > 0 &&
		_ref_target._val_armor > 0
	){

		var _val_armor_damage =
			min(
				_ref_target._val_armor,
				_val_damage_left
			);

		_ref_target._val_armor -=
			_val_armor_damage;

		_val_damage_left -=
			_val_armor_damage;

		scr_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_armor_damage),
			undefined,
			c_blue,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	//------------//
	//OVERHEALTH//
	//------------//
	if (
		_val_damage_left > 0 &&
		_ref_target._val_overhealth > 0
	){

		var _val_overhealth_damage =
			min(
				_ref_target._val_overhealth,
				_val_damage_left
			);

		_ref_target._val_overhealth -=
			_val_overhealth_damage;

		_val_damage_left -=
			_val_overhealth_damage;

		scr_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_overhealth_damage),
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	//--------//
	//HOST HP//
	//--------//
	if (_val_damage_left > 0){

		var _val_hp_damage =
			min(
				_val_damage_left,
				_ref_target._val_cur_hp
			);

		if (_val_hp_damage > 0){

			_ref_target._val_cur_hp =
				max(
					0,
					_ref_target._val_cur_hp -
					_val_hp_damage
				);

			scr_spawn_popup_scrolling(
				"TEXT",
				"-" + string(_val_hp_damage),
				undefined,
				c_maroon,
				_ref_target.x + irandom_range(-32,32),
				_ref_target.y - 24 + irandom_range(-32,32)
			);
		}
	}

	return true;
}