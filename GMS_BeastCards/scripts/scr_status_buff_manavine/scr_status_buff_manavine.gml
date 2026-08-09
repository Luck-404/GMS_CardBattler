//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_MANAVINE
// FUNCTION: Handles the Manavine global Mana Buff.
//           Grants temporary maximum/current Mana.
//           Reapplication refreshes duration without stacking its Mana bonus.
//
//===============================================================================//
function scr_status_buff_manavine(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			if (_val_magnitude == undefined){
				_val_magnitude = 1;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_magnitude =
				max(0,_val_magnitude);

			_val_lifetime =
				max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_check_for_status(
					"MANAVINE",
					global.list_statuses
				);

			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status =
				instance_create_layer(
					room_width * 0.5,
					room_height * 0.5,
					"ily_status",
					obj_battle_status
				);

			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._scr_status =
				scr_status_buff_manavine;

			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_name =
				"MANAVINE";

			_ref_new_status._str_status_desc =
				"+" +
				string(_val_magnitude) +
				" MANA FOR " +
				string(_val_lifetime) +
				" ROUNDS";

			_ref_new_status._spr_status =
				spr_status_buff_manavine;

			_ref_new_status._str_trigger_region =
				"END";

			_ref_new_status._str_status_type =
				"GLOBAL";

			_ref_new_status._ct_status_stacks =
				1;

			//-----------------//
			//GRANT MANA BONUS//
			//-----------------//
			obj_battle_player_controller._val_max_mana +=
				_val_magnitude;

			obj_battle_player_controller._val_cur_mana +=
				_val_magnitude;

			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(
				global.list_statuses
			);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			scr_status_tick_lifetime(
				_ref_status
			);

			scr_reposition_statuses(
				global.list_statuses
			);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _val_mana_bonus =
				_ref_status._val_status_magnitude;

			obj_battle_player_controller._val_max_mana =
				max(
					obj_battle_player_controller._val_saved_max_mana,
					obj_battle_player_controller._val_max_mana -
					_val_mana_bonus
				);

			obj_battle_player_controller._val_cur_mana =
				min(
					obj_battle_player_controller._val_cur_mana,
					obj_battle_player_controller._val_max_mana
				);

			scr_destroy_status(
				_ref_status
			);

		break;
	}

	return undefined;
}