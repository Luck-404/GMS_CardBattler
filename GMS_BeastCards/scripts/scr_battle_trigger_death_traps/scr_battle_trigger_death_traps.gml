//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_DEATH_TRAPS
// FUNCTION: Checks and activates DEATH Traps attached to a defeated Beast.
//           Runs before the Beast leaves its alive formation so adjacent
//           targeting can still use its original position.
//           Activates every valid DEATH Trap in the BEFORE phase.
//
// ARGUMENTS: _ref_host is the defeated Beast whose attached Traps are checked.
// RETURNS: The number of DEATH Traps that successfully trigger.
//
//===============================================================================//
function scr_battle_trigger_death_traps(_ref_host){

	//---------------//
	//VALIDATE HOST//
	//---------------//
	if (!instance_exists(_ref_host)){
		return 0;
	}

	// Death Traps resolve after HP reaches zero but before the DEAD list transition.
	if (_ref_host._val_cur_hp > 0){
		return 0;
	}

	//=======================//
	//ELITE DEATH MODIFIERS//
	//=======================//
	if (
		!variable_instance_exists(
			_ref_host,
			"_flag_elite_death_modifiers_resolved"
		) ||
		!_ref_host
			._flag_elite_death_modifiers_resolved
	){
		_ref_host
			._flag_elite_death_modifiers_resolved =
			true;

		var _list_team_all = undefined;
		var _list_team_alive = undefined;

		if (_ref_host._str_team == "PLAYER"){
			if (instance_exists(obj_battle_player_controller)){
				_list_team_all =
					obj_battle_player_controller
						._list_beasts;

				_list_team_alive =
					obj_battle_player_controller
						._list_beasts_alive;
			}
		}
		else if (_ref_host._str_team == "ENEMY"){
			if (instance_exists(obj_battle_enemy_controller)){
				_list_team_all =
					obj_battle_enemy_controller
						._list_beasts;

				_list_team_alive =
					obj_battle_enemy_controller
						._list_beasts_alive;
			}
		}

		//========//
		//MARTYR//
		//========//
		if (
			scr_battle_elite_get_modifier(
				_ref_host
			) ==
			"MARTYR" &&
			ds_exists(
				_list_team_alive,
				ds_type_list
			)
		){
			for (
				var _it_ally = 0;
				_it_ally <
					ds_list_size(
						_list_team_alive
					);
				_it_ally++
			){
				var _ref_ally =
					ds_list_find_value(
						_list_team_alive,
						_it_ally
					);

				if (
					!instance_exists(
						_ref_ally
					) ||
					_ref_ally ==
						_ref_host ||
					_ref_ally._val_cur_hp <= 0 ||
					_ref_ally._str_list !=
						"ALIVE"
				){
					continue;
				}

				var _ref_martyrs_gift =
					scr_status_buff_martyrs_gift(
						"APPLY",
						undefined,
						25,
						_ref_ally
					);

				if (
					instance_exists(
						_ref_martyrs_gift
					)
				){
					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"MARTYR +25%",
						undefined,
						c_yellow,
						_ref_ally.x,
						_ref_ally.y - 48
					);

					scr_battle_vfx(
						_ref_ally,
						spr_battle_vfx_buff,
						undefined,
						undefined,
						0,
						0,
						1,
						0,
						undefined
					);
				}
			}

			scr_gui_spawn_popup_trigger_banner(
				"MARTYR: ALLIES +25% PRIMARY STATS"
			);
		}

		//=========//
		//VENGEFUL//
		//=========//
		if (
			ds_exists(
				_list_team_all,
				ds_type_list
			) &&
			ds_exists(
				_list_team_alive,
				ds_type_list
			)
		){
			for (
				var _it_vengeful = 0;
				_it_vengeful <
					ds_list_size(
						_list_team_alive
					);
				_it_vengeful++
			){
				var _ref_vengeful =
					ds_list_find_value(
						_list_team_alive,
						_it_vengeful
					);

				if (
					!instance_exists(
						_ref_vengeful
					) ||
					_ref_vengeful ==
						_ref_host ||
					_ref_vengeful._val_cur_hp <= 0 ||
					_ref_vengeful._str_list !=
						"ALIVE" ||
					scr_battle_elite_get_modifier(
						_ref_vengeful
					) !=
						"VENGEFUL" ||
					!is_struct(
						_ref_vengeful
							._ref_unit
					)
				){
					continue;
				}

				var _stct_vengeful_unit =
					_ref_vengeful
						._ref_unit;

				//--------------------------------//
				//SNAPSHOT ACTUAL STARTING ALLIES//
				//--------------------------------//
				if (
					!variable_struct_exists(
						_stct_vengeful_unit,
						"_arr_elite_vengeful_starting_ally_uids"
					) ||
					!is_array(
						_stct_vengeful_unit
							._arr_elite_vengeful_starting_ally_uids
					) ||
					array_length(
						_stct_vengeful_unit
							._arr_elite_vengeful_starting_ally_uids
					) <= 0
				){
					_stct_vengeful_unit
						._arr_elite_vengeful_starting_ally_uids =
						[];

					for (
						var _it_start = 0;
						_it_start <
							ds_list_size(
								_list_team_all
							);
						_it_start++
					){
						var _ref_start_ally =
							ds_list_find_value(
								_list_team_all,
								_it_start
							);

						if (
							!instance_exists(
								_ref_start_ally
							) ||
							_ref_start_ally ==
								_ref_vengeful
						){
							continue;
						}

						array_push(
							_stct_vengeful_unit
								._arr_elite_vengeful_starting_ally_uids,
							_ref_start_ally
								._uid_beast
						);
					}
				}

				//----------------------//
				//VALID STARTING DEATH//
				//----------------------//
				if (
					!array_contains(
						_stct_vengeful_unit
							._arr_elite_vengeful_starting_ally_uids,
						_ref_host
							._uid_beast
					)
				){
					continue;
				}

				if (
					!variable_struct_exists(
						_stct_vengeful_unit,
						"_arr_elite_vengeful_counted_death_uids"
					) ||
					!is_array(
						_stct_vengeful_unit
							._arr_elite_vengeful_counted_death_uids
					)
				){
					_stct_vengeful_unit
						._arr_elite_vengeful_counted_death_uids =
						[];
				}

				if (
					array_contains(
						_stct_vengeful_unit
							._arr_elite_vengeful_counted_death_uids,
						_ref_host
							._uid_beast
					)
				){
					continue;
				}

				array_push(
					_stct_vengeful_unit
						._arr_elite_vengeful_counted_death_uids,
					_ref_host
						._uid_beast
				);

				//----------------//
				//APPLY +10%//
				//----------------//
				var _stct_vengeful_basis =
					_stct_vengeful_unit
						._stct_elite_vengeful_stat_basis;

				var _stct_vengeful_result =
					scr_battle_elite_apply_primary_stat_percent_bonus(
						_ref_vengeful,
						10,
						_stct_vengeful_basis,
						"VENGEFUL"
					);

				if (
					is_struct(
						_stct_vengeful_result
					)
				){
					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"VENGEFUL +10%",
						undefined,
						c_red,
						_ref_vengeful.x,
						_ref_vengeful.y - 48
					);

					scr_battle_vfx(
						_ref_vengeful,
						spr_battle_vfx_buff,
						undefined,
						undefined,
						0,
						0,
						1,
						0,
						undefined
					);

					scr_gui_spawn_popup_trigger_banner(
						"VENGEFUL: +10% PRIMARY STATS"
					);
				}
			}
		}
	}

	//================//
	//VALIDATE TRAPS//
	//================//
	if (!variable_instance_exists(_ref_host,"_list_traps")){
		return 0;
	}

	if (!ds_exists(_ref_host._list_traps,ds_type_list)){
		return 0;
	}

	var _ct_triggered = 0;

	//===================//
	//CHECK DEATH TRAPS//
	//===================//
	for (var _it_trap = ds_list_size(_ref_host._list_traps) - 1;_it_trap >= 0;_it_trap--){

		var _ref_trap = ds_list_find_value(_ref_host._list_traps,_it_trap);

		if (!instance_exists(_ref_trap)){
			continue;
		}

		if (_ref_trap._ref_host != _ref_host || _ref_trap._flag_triggered){
			continue;
		}

		if (_ref_trap._str_trigger_type != "DEATH"){
			continue;
		}

		if (_ref_trap._str_trigger_phase != "BEFORE"){
			continue;
		}

		if (!is_callable(_ref_trap._scr_trap_callback)){
			continue;
		}

		//================//
		//TRIGGER TRAP//
		//================//
		var _flag_triggered = _ref_trap._scr_trap_callback(
			"TRIGGER",
			_ref_trap,
			undefined,
			_ref_host,
			undefined
		);

		if (_flag_triggered){
			_ct_triggered++;
		}
	}

	return _ct_triggered;
}
