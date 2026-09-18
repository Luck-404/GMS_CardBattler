//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_DISCHARGE
// FUNCTION: Resolves all available Stormstruck DISCHARGES on a Beast.
//           Each DISCHARGE consumes half the current threshold,
//           deals 15 NEU damage to the host, and spreads half the consumed
//           amount to adjacent living allies.
//           Unstable Coil spreads that amount to every other living ally.
//           Repeats while the host still meets its current threshold.
//
// ARGUMENTS: _ref_host is the Beast being checked.
// RETURNS: Number of DISCHARGES successfully resolved.
//
//===============================================================================//

function scr_battle_trigger_discharge(_ref_host){

	//----------------//
	//VALIDATE HOST//
	//----------------//
	if (!instance_exists(_ref_host)){
		return 0;
	}

	if (_ref_host._val_cur_hp <= 0){
		return 0;
	}

	var _ct_discharges = 0;
	var _ref_original_target = global.ref_target_beast;

	//===================//
	//RESOLVE DISCHARGES//
	//===================//
	while (
		instance_exists(_ref_host) &&
		_ref_host._val_cur_hp > 0
	){

		//================//
		//GET STORMSTRUCK//
		//================//
		var _ref_stormstruck = scr_status_check("STORMSTRUCK",_ref_host);

		if (
			_ref_stormstruck == -1 ||
			!instance_exists(_ref_stormstruck)
		){
			break;
		}

		//================//
		//GET THRESHOLD//
		//================//
		var _ct_threshold = scr_status_get_discharge_threshold(_ref_host);

		if (_ref_stormstruck._ct_status_stacks < _ct_threshold){
			break;
		}

		//==================//
		//CALCULATE STACKS//
		//==================//
		var _ct_consumed = max(1,floor(_ct_threshold * 0.5));
		var _ct_spread = max(1,floor(_ct_consumed * 0.5));
		var _ct_stacks_before = _ref_stormstruck._ct_status_stacks;

		//=====================//
		//CHECK UNSTABLE COIL//
		//=====================//
		var _ref_unstable_coil = scr_status_check("UNSTABLE_COIL",_ref_host);

		var _flag_unstable_coil = (
			_ref_unstable_coil != -1 &&
			instance_exists(_ref_unstable_coil)
		);

		//================//
		//CONSUME STACKS//
		//================//
		_ref_stormstruck._ct_status_stacks = max(
			0,
			_ref_stormstruck._ct_status_stacks - _ct_consumed
		);

		scr_status_refresh_lifetime(_ref_stormstruck,3);

		//================//
		//DISCHARGE VFX//
		//================//
		scr_battle_vfx(
			_ref_host,
			spr_battle_vfx_discharge,
			undefined,
			undefined,
			0,
			0,
			1.5,
			0,
			snd_battle_discharge
		);

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"DISCHARGE",
			undefined,
			c_aqua,
			_ref_host.x,
			_ref_host.y - 48
		);

		//================//
		//DEAL 15 NEU//
		//================//
		var _val_damage_remaining = 15;
		var _val_overhealth_damage = 0;
		var _val_hp_damage = 0;

		//----------------//
		//OVERHEALTH//
		//----------------//
		if (_ref_host._val_overhealth > 0){

			_val_overhealth_damage = min(_ref_host._val_overhealth,_val_damage_remaining);

			_ref_host._val_overhealth -= _val_overhealth_damage;
			_val_damage_remaining -= _val_overhealth_damage;
		}

		//----------------//
		//HP//
		//----------------//
		if (
			_val_damage_remaining > 0 &&
			_ref_host._val_cur_hp > 0
		){

			_val_hp_damage = min(_val_damage_remaining,_ref_host._val_cur_hp);

			_ref_host._val_cur_hp = max(
				0,
				_ref_host._val_cur_hp - _val_hp_damage
			);
		}

		//================//
		//GET SPREAD TARGETS//
		//================//
		var _arr_spread_targets = [];

		//----------------//
		//UNSTABLE COIL//
		//----------------//
		if (_flag_unstable_coil){

			var _list_allies = scr_battle_get_target_team_list(_ref_host);

			if (
				_list_allies != undefined &&
				ds_exists(_list_allies,ds_type_list)
			){

				for (var _it_ally = 0;_it_ally < ds_list_size(_list_allies);_it_ally++){

					var _ref_ally = ds_list_find_value(_list_allies,_it_ally);

					if (!instance_exists(_ref_ally)){
						continue;
					}

					if (_ref_ally == _ref_host){
						continue;
					}

					if (
						_ref_ally._str_list != "ALIVE" ||
						_ref_ally._val_cur_hp <= 0
					){
						continue;
					}

					array_push(_arr_spread_targets,_ref_ally);
				}
			}
		}

		//----------------//
		//NORMAL SPREAD//
		//----------------//
		else{

			var _ref_left_target = scr_battle_get_left_target(_ref_host);
			var _ref_right_target = scr_battle_get_right_target(_ref_host);

			if (instance_exists(_ref_left_target)){
				array_push(_arr_spread_targets,_ref_left_target);
			}

			if (instance_exists(_ref_right_target)){
				array_push(_arr_spread_targets,_ref_right_target);
			}
		}

		//===================//
		//SPREAD STORMSTRUCK//
		//===================//
		for (var _it_target = 0;_it_target < array_length(_arr_spread_targets);_it_target++){

			var _ref_target = _arr_spread_targets[_it_target];

			if (!instance_exists(_ref_target)){
				continue;
			}

			if (
				_ref_target._str_list != "ALIVE" ||
				_ref_target._val_cur_hp <= 0
			){
				continue;
			}

			global.ref_target_beast = _ref_target;

			repeat (_ct_spread){

				if (
					!instance_exists(_ref_target) ||
					_ref_target._val_cur_hp <= 0
				){
					break;
				}

				scr_status_apply_dot("STORMSTRUCK");
			}
		}

		//================//
		//DEBUG TRIGGER//
		//================//
		scr_debug_log_battle_trigger(
			"DISCHARGE",
			_ref_host,
			_ref_host,
			"THRESHOLD: " +
			string(_ct_threshold) +
			" | STORMSTRUCK: " +
			string(_ct_stacks_before) +
			" -> " +
			string(_ref_stormstruck._ct_status_stacks) +
			" | CONSUMED: " +
			string(_ct_consumed) +
			" | SPREAD EACH: " +
			string(_ct_spread) +
			" | SPREAD MODE: " +
			(_flag_unstable_coil ? "TEAMWIDE" : "ADJACENT") +
			" | NEU DAMAGE: " +
			string(_val_overhealth_damage + _val_hp_damage),
			"SCR_BATTLE_TRIGGER_DISCHARGE"
		);

		_ct_discharges++;

		scr_status_reposition(_ref_host);
	}

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;

	return _ct_discharges;
}