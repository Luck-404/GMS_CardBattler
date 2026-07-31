//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_MALLEABILITY
// FUNCTION: Handles the Malleability buff status.
//           Allows the host's next card to ignore color, archetype,
//           and class caster requirements.
//           Remains active until the host successfully casts a card.
//
//===============================================================================//
function scr_status_buff_malleability(_str_tag,_ref_status){

	switch(_str_tag){

		//-------//
		// APPLY
		//-------//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			var _ref_existing_status = scr_check_for_status(
				"MALLEABILITY",
				_ref_target
			);

			// MALLEABILITY DOES NOT STACK
			if (_ref_existing_status != -1){

				_ref_target._flag_ignore_caster_requirements = true;

				return _ref_existing_status;
			}

			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			_ref_new_status._val_status_lifetime = -1;

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

			_ref_new_status._ct_status_stacks = 1;

			// NEVER TRIGGERS DURING TURN START OR TURN END
			_ref_new_status._str_trigger_region = undefined;

			_ref_target._flag_ignore_caster_requirements = true;

			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(_ref_target);

			return _ref_new_status;

		//--------//
		// REPEAT
		//--------//
		case "REPEAT":

			// MALLEABILITY DOES NOT PROCESS EACH TURN

		break;

		//-------//
		// DEATH
		//-------//
		case "DEATH":

			var _ref_host = _ref_status._ref_host;

			if (instance_exists(_ref_host)){
				_ref_host._flag_ignore_caster_requirements = false;
			}

			scr_destroy_status(_ref_status);

		break;
	}
}