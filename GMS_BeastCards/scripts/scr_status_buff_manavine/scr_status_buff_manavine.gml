//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_MANAVINE
// FUNCTION: Handles the Manavine global mana buff.
//           Grants one temporary maximum/current mana for three rounds.
//           Refreshes its own duration when reapplied.
//           Removes only its own mana bonus when the effect expires.
//
//===============================================================================//
function scr_status_buff_manavine(_str_tag,_ref_status,_val_magnitude,_val_lifetime){

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

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_check_for_status(
				"MANAVINE",
				global.list_statuses
			);

			//----------------//
			//REFRESH STATUS//
			//----------------//
			if (_ref_existing_status != -1){

				_ref_existing_status._val_status_lifetime =
					_val_lifetime;

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_status",
				obj_battle_status
			);

			_ref_new_status._val_status_lifetime =
				_val_lifetime;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._scr_status =
				scr_status_buff_manavine;

			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_name =
				"MANAVINE";

			_ref_new_status._str_status_desc =
				"+1 MANA FOR 3 ROUNDS";

			_ref_new_status._spr_status =
				spr_status_buff_manavine;

			_ref_new_status._str_trigger_region =
				"END";

			_ref_new_status._str_status_type =
				"GLOBAL";

			//-----------------//
			//GRANT MANA BONUS//
			//-----------------//
			obj_battle_player_controller._val_max_mana +=
				_val_magnitude;

			obj_battle_player_controller._val_cur_mana +=
				_val_magnitude;

			//----------------//
			//REGISTER STATUS//
			//----------------//
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

			_ref_status._val_status_lifetime--;

			if (_ref_status._val_status_lifetime <= 0){

				_ref_status._str_status_command =
					"DEATH";
			}
			else{

				_ref_status._str_status_command =
					"WAIT";
			}

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

			//-----------------//
			//REMOVE OWN BONUS//
			//-----------------//
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