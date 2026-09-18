//===============================================================================//
//
// SCRIPT: SCR_MINION_DAMAGE_TARGET
// FUNCTION: Deals fixed damage from a Minion to a battle Beast.
//           Damage passes through defending Minions, Armor, Overhealth, and HP.
//           Does not use Beast Power scaling, Card scaling, Crit, or Card context.
//           Logs the final damage distribution when a source Minion is supplied.
//
// ARGUMENTS: _val_damage is the fixed damage amount.
//            _ref_target is the battle Beast receiving the damage.
//            _ref_source_minion optionally identifies the attacking Minion.
// RETURNS: True when a valid damage instance resolves; otherwise false.
//
//===============================================================================//

function scr_minion_damage_target(_val_damage,_ref_target,_ref_source_minion=undefined){

	//================//
	//VALIDATION//
	//================//

	//-----------------//
	//VALIDATE TARGET//
	//-----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	var _val_damage_left = max(0,_val_damage);

	if (_val_damage_left <= 0){
		return false;
	}

	var _val_final_damage = _val_damage_left;

	//================//
	//DAMAGE REDIRECT//
	//================//
	_ref_target = scr_status_resolve_damage_redirect(_ref_target);

	if (!instance_exists(_ref_target)){
		return false;
	}

	//===================//
	//MINION ABSORPTION//
	//===================//
	var _val_minion_damage = 0;

	if (ds_exists(_ref_target._list_minions,ds_type_list)){

		var _list_minions = _ref_target._list_minions;

		//-----------------------//
		//REMOVE INVALID MINIONS//
		//-----------------------//
		for (var _it_minion = ds_list_size(_list_minions) - 1;_it_minion >= 0;_it_minion--){

			var _ref_minion = ds_list_find_value(
				_list_minions,
				_it_minion
			);

			if (!instance_exists(_ref_minion)){
				ds_list_delete(_list_minions,_it_minion);
			}
		}

		var _ct_minions = ds_list_size(_list_minions);

		if (
			_ct_minions > 0 &&
			_val_damage_left > 0
		){

			var _val_damage_per_minion =
				_val_damage_left div
				_ct_minions;

			var _val_remainder =
				_val_damage_left mod
				_ct_minions;

			//-----------------------//
			//DISTRIBUTE MINION HIT//
			//-----------------------//
			for (var _it_minion = _ct_minions - 1;_it_minion >= 0;_it_minion--){

				var _ref_minion = ds_list_find_value(
					_list_minions,
					_it_minion
				);

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
				_val_minion_damage += _val_actual;

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"-" + string(_val_actual),
					undefined,
					c_maroon,
					_ref_minion.x + irandom_range(-16,16),
					_ref_minion.y - 16 + irandom_range(-16,16)
				);
				
				//---------------//
				//DESTROY MINION//
				//---------------//
				if (_ref_minion._val_cur_hp <= 0){

					_ref_minion._val_cur_hp = 0;

					scr_minion_destroy(
						_ref_minion,
						"DEATH",
						_ref_source_minion
					);
				}
			}

			_val_damage_left -= _val_minion_damage;
		}
	}

	//================//
	//BEAST DAMAGE//
	//================//
	var _val_beast_damage = 0;

	var _val_armor_damage = 0;
	var _val_overhealth_damage = 0;
	var _val_hp_damage = 0;

	//-------//
	//ARMOR//
	//-------//
	if (
		_val_damage_left > 0 &&
		_ref_target._val_armor > 0
	){

		_val_armor_damage = min(
			_ref_target._val_armor,
			_val_damage_left
		);

		_ref_target._val_armor -= _val_armor_damage;
		_val_damage_left -= _val_armor_damage;

		scr_gui_spawn_popup_scrolling(
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

		_val_overhealth_damage = min(
			_ref_target._val_overhealth,
			_val_damage_left
		);

		_ref_target._val_overhealth -= _val_overhealth_damage;
		_val_damage_left -= _val_overhealth_damage;

		_val_beast_damage += _val_overhealth_damage;

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_overhealth_damage),
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	//---------//
	//BEAST HP//
	//---------//
	if (_val_damage_left > 0){

		_val_hp_damage = min(
			_val_damage_left,
			_ref_target._val_cur_hp
		);

		if (_val_hp_damage > 0){

			_ref_target._val_cur_hp = max(
				0,
				_ref_target._val_cur_hp -
				_val_hp_damage
			);

			_val_beast_damage += _val_hp_damage;

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"-" + string(_val_hp_damage),
				undefined,
				c_maroon,
				_ref_target.x + irandom_range(-32,32),
				_ref_target.y - 24 + irandom_range(-32,32)
			);
		}
	}

	//================//
	//DEBUG DAMAGE//
	//================//
	if (instance_exists(_ref_source_minion)){

		scr_debug_log(
			"MINIONS",
			"DAMAGE",
			_ref_source_minion,
			string_upper(_ref_source_minion._str_team) + " " +
			string_upper(_ref_source_minion._str_name) +
			" DEALT " + string(_val_final_damage) +
			" FIXED DAMAGE TO " +
			string_upper(_ref_target._str_team) + " " +
			string_upper(_ref_target._ref_unit._str_beast_name) +
			" | MINIONS: " + string(_val_minion_damage) +
			" | ARMOR: " + string(_val_armor_damage) +
			" | OVERHEALTH: " + string(_val_overhealth_damage) +
			" | HP: " + string(_val_hp_damage) +
			" | TARGET HP: " +
			string(_ref_target._val_cur_hp) +
			"/" +
			string(_ref_target._val_max_hp),
			"BATTLE",
			"SCR_MINION_DAMAGE_TARGET"
		);
	}

	//================//
	//DAMAGE TRAPS//
	//================//
	if (_val_armor_damage + _val_beast_damage > 0){
		scr_battle_trigger_damage_traps(
			_ref_target,
			_val_armor_damage + _val_beast_damage
		);
	}

	//============//
	//WAKE SLEEP//
	//============//
	if (_val_beast_damage > 0){
		scr_status_wake_sleep_on_damage(_ref_target);
	}

	return true;
}