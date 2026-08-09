//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_MALLEABILITY
// FUNCTION: Handles the Malleability Buff.
//           Allows the host's next card to ignore caster requirements.
//           Infinite until consumed by a successful card cast.
//
//===============================================================================//
function scr_status_buff_malleability(_str_tag,_ref_status){

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

			var _ref_existing_status =
				scr_check_for_status(
					"MALLEABILITY",
					_ref_target
				);

			if (_ref_existing_status != -1){

				_ref_target._flag_ignore_caster_requirements =
					true;

				return _ref_existing_status;
			}

			var _ref_new_status =
				instance_create_layer(
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

			_ref_new_status._scr_status =
				scr_status_buff_malleability;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"MALLEABILITY";

			_ref_new_status._str_status_desc =
				"NEXT CARD IGNORES CASTER REQUIREMENTS";

			_ref_new_status._spr_status =
				spr_status_buff_malleability;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._str_trigger_region =
				undefined;

			_ref_target._flag_ignore_caster_requirements =
				true;

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

			// INFINITE EVENT-BOUND STATUS.
			// DOES NOT PROCESS EACH TURN.

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (instance_exists(_ref_host)){
				_ref_host._flag_ignore_caster_requirements = false;
			}

			scr_destroy_status(
				_ref_status
			);

		break;
	}

	return undefined;
}