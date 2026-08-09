//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_TAUNT
// FUNCTION: Handles the Taunt Buff.
//           Makes the host the team's hostile single-target priority.
//           Only one Beast per team may carry Taunt.
//           Reapplication refreshes duration without stacking.
//
//===============================================================================//
function scr_status_buff_taunt(_str_tag,_ref_status,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target =
				global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 2;
			}

			_val_lifetime =
				max(1,_val_lifetime);

			//----------------//
			//CHECK OWN TAUNT//
			//----------------//
			var _ref_existing_status =
				scr_check_for_status(
					"TAUNT",
					_ref_target
				);

			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//------------------------//
			//REMOVE OTHER TEAM TAUNT//
			//------------------------//
			var _list_team =
				scr_get_target_team_list(
					_ref_target
				);

			if (_list_team != undefined){

				for (
					var _it_beast = 0;
					_it_beast < ds_list_size(_list_team);
					_it_beast++
				){

					var _ref_beast =
						ds_list_find_value(
							_list_team,
							_it_beast
						);

					if (
						!instance_exists(_ref_beast) ||
						_ref_beast == _ref_target
					){
						continue;
					}

					var _ref_old_taunt =
						scr_check_for_status(
							"TAUNT",
							_ref_beast
						);

					if (_ref_old_taunt != -1){

						scr_status_buff_taunt(
							"DEATH",
							_ref_old_taunt,
							undefined
						);
					}
				}
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status =
				instance_create_layer(
					_ref_target.x,
					_ref_target.y,
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
				scr_status_buff_taunt;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"TAUNT";

			_ref_new_status._str_status_desc =
				"ONLY AVAILABLE TARGET FOR HOSTILE ATTACKS.";

			_ref_new_status._spr_status =
				spr_status_buff_taunt;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._str_trigger_region =
				"END";

			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(
				_ref_target
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

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_destroy_status(
					_ref_status
				);

				return undefined;
			}

			scr_status_tick_lifetime(
				_ref_status
			);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_destroy_status(_ref_status);
			}

		break;
	}

	return undefined;
}