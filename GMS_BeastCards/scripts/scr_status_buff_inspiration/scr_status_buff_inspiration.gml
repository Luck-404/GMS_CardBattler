//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_INSPIRATION
// FUNCTION: Handles the Inspiration global Mana Buff.
//           Grants +2 temporary Maximum and Current Mana.
//           Reapplication refreshes duration without stacking its Mana bonus.
//           Uses the shared Mana Gain presentation system.
//
//===============================================================================//

function scr_status_buff_inspiration(
	_str_tag,
	_ref_status,
	_val_lifetime=undefined
){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			//----------//
			//DEFAULTS//
			//----------//
			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_lifetime =
				max(
					1,
					_val_lifetime
				);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_check_for_status(
					"INSPIRATION",
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

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status =
				scr_status_buff_inspiration;

			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_name =
				"INSPIRATION";

			_ref_new_status._str_status_desc =
				"+2 MAXIMUM/CURRENT MANA FOR " +
				string(_val_lifetime) +
				" ROUNDS";

			_ref_new_status._spr_status =
				spr_status_buff_inspiration;

			_ref_new_status._str_trigger_region =
				"END";

			_ref_new_status._str_status_type =
				"GLOBAL";

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				2;

			//---------------------//
			//INCREASE MAXIMUM MANA//
			//---------------------//
			obj_battle_player_controller._val_max_mana +=
				_ref_new_status._val_status_magnitude;

			//-------------------//
			//GAIN CURRENT MANA//
			//-------------------//
			scr_gain_mana(
				_ref_new_status._val_status_magnitude
			);

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

			//-------------------//
			//REMOVE MAXIMUM MANA//
			//-------------------//
			obj_battle_player_controller._val_max_mana =
				max(
					obj_battle_player_controller._val_saved_max_mana,
					obj_battle_player_controller._val_max_mana -
						_val_mana_bonus
				);

			//-------------------//
			//CLAMP CURRENT MANA//
			//-------------------//
			obj_battle_player_controller._val_cur_mana =
				min(
					obj_battle_player_controller._val_cur_mana,
					obj_battle_player_controller._val_max_mana
				);

			//-------------------//
			//REFRESH MANA HUD//
			//-------------------//
			scr_reposition_mana();

			//---------------//
			//DESTROY STATUS//
			//---------------//
			scr_destroy_status(
				_ref_status
			);

		break;
	}

	return undefined;
}