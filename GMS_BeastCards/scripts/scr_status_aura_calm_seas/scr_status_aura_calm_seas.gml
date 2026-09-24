//===============================================================================//
//
// SCRIPT: SCR_STATUS_AURA_CALM_SEAS
// FUNCTION: Handles Calm Seas.
//           Infinite Team Aura.
//           Allied Beasts heal 3 HP each round.
//           Allied Beasts deal 2 less Linear damage.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_magnitude=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_aura_calm_seas(_str_tag,_ref_status,_val_magnitude=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":


			if (!instance_exists(_ref_target)){
				return undefined;
			}

			//----------------//
			//GET TEAM LIST//
			//----------------//
			var _list_team = (_ref_target._str_team == "PLAYER") ? obj_battle_player_controller._list_beasts : obj_battle_enemy_controller._list_beasts;

			if (!ds_exists(_list_team,ds_type_list)){
				return undefined;
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			for (var _it_beast = 0;_it_beast < ds_list_size(_list_team);_it_beast++){

				var _ref_beast = ds_list_find_value(_list_team,_it_beast);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				var _ref_existing_status = scr_status_check("CALM_SEAS",_ref_beast);

				if (_ref_existing_status != -1){
					return _ref_existing_status;
				}
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			_ref_new_status._scr_status = scr_status_aura_calm_seas;

			_ref_new_status._ref_host = _ref_target;
			_ref_new_status._str_team = _ref_target._str_team;

			_ref_new_status._str_status_type = "AURA";
			_ref_new_status._str_status_name = "CALM_SEAS";
			_ref_new_status._str_status_desc = "ALLIES HEAL 3 EACH ROUND; LINEAR DAMAGE -2";

			_ref_new_status._spr_status = spr_status_aura_calm_seas;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = 0;

			_ref_new_status._val_aura_heal = 3;
			_ref_new_status._val_aura_linear_reduction = 2;

			_ref_new_status._str_trigger_region = "END";

			_ref_new_status._str_aura_scope = "TEAM";
			_ref_new_status._str_aura_trigger = "ROUND_END";

			//-----------------------//
			//REDUCE ALLIED DAMAGE//
			//-----------------------//
			for (var _it_beast = 0;_it_beast < ds_list_size(_list_team);_it_beast++){

				var _ref_beast = ds_list_find_value(_list_team,_it_beast);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				_ref_beast._val_dmg_linear_reduction += _ref_new_status._val_aura_linear_reduction;
			}

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			//----------------//
			//HOST LOST//
			//----------------//
			if (!instance_exists(_ref_host)){

				scr_status_aura_calm_seas(
					"DEATH",
					_ref_status
				);

				return undefined;
			}

			//----------------//
			//GET TEAM LIST//
			//----------------//
			var _list_team = (_ref_status._str_team == "PLAYER") ? obj_battle_player_controller._list_beasts : obj_battle_enemy_controller._list_beasts;

			if (!ds_exists(_list_team,ds_type_list)){
				return undefined;
			}

			//----------------//
			//HEAL ALL ALLIES//
			//----------------//
			for (var _it_beast = 0;_it_beast < ds_list_size(_list_team);_it_beast++){

				var _ref_beast = ds_list_find_value(_list_team,_it_beast);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				if (_ref_beast._val_cur_hp <= 0){
					continue;
				}

				scr_battle_heal_target(
					"FIXED",
					_ref_status._val_aura_heal,
					_ref_beast
				);
			}

			scr_status_tick_lifetime(_ref_status);
			scr_status_reposition(_ref_host);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//----------------//
			//GET TEAM LIST//
			//----------------//
			var _list_team = (_ref_status._str_team == "PLAYER") ? obj_battle_player_controller._list_beasts : obj_battle_enemy_controller._list_beasts;

			//-------------------------//
			//RESTORE ALLIED DAMAGE//
			//-------------------------//
			if (ds_exists(_list_team,ds_type_list)){

				for (var _it_beast = 0;_it_beast < ds_list_size(_list_team);_it_beast++){

					var _ref_beast = ds_list_find_value(_list_team,_it_beast);

					if (!instance_exists(_ref_beast)){
						continue;
					}

					_ref_beast._val_dmg_linear_reduction =
						max(
							0,
							_ref_beast._val_dmg_linear_reduction -
							_ref_status._val_aura_linear_reduction
						);
				}
			}

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
