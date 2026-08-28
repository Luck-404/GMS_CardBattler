//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_HEART_OF_THE_FOREST
// FUNCTION: Handles Heart of the Forest.
//           Global team-bound, Unstackable Timed Buff.
//           Records which team receives its healing-triggered effects.
//           Reapplication refreshes duration.
//
//===============================================================================//

function scr_status_buff_heart_of_the_forest(
	_str_tag,
	_ref_status,
	_val_magnitude=undefined,
	_val_lifetime=undefined
){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			if (_val_lifetime == undefined){
				_val_lifetime = 5;
			}

			_val_lifetime =
				max(
					1,
					_val_lifetime
				);

			//----------------//
			//GET CASTER TEAM//
			//----------------//
			if (!instance_exists(global.ref_caster_beast)){
				return undefined;
			}

			var _str_team =
				global.ref_caster_beast._str_team;

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_get_heart_of_forest_status(
					_str_team
				);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
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

			_ref_new_status._scr_status =
				scr_status_buff_heart_of_the_forest;

			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_name =
				"HEART_OF_THE_FOREST";

			_ref_new_status._str_status_desc =
				"HEALING ALSO GRANTS ARMOR AND GROWS HOSTED MINIONS";

			_ref_new_status._spr_status =
				spr_status_buff_heart_of_the_forest;

			_ref_new_status._str_status_type =
				"GLOBAL";

			_ref_new_status._str_trigger_region =
				"END";

			_ref_new_status._ct_status_stacks =
				1;

			//----------------//
			//STORE BUFF TEAM//
			//----------------//
			_ref_new_status._str_status_team =
				_str_team;

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

			if (instance_exists(_ref_status)){

				scr_destroy_status(
					_ref_status
				);
			}

		break;
	}

	return undefined;
}