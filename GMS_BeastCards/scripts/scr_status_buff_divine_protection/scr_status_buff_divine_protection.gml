//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_DIVINE_PROTECTION
// FUNCTION: Creates and manages Divine Protection.
//           Each stack blocks one incoming Attack.
//           Divine Protection remains until all stacks are consumed.
//
//===============================================================================//

function scr_status_buff_divine_protection(_str_tag,_ref_status,_ct_stacks_added=1){

	switch(_str_tag){

		//-----//
		//APPLY//
		//-----//
		case "APPLY":

			var _ref_target =
				global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			_ct_stacks_added =
				max(1,_ct_stacks_added);

			//---------------------//
			//CHECK EXISTING STATUS//
			//---------------------//
			var _ref_existing_status =
				scr_check_for_status(
					"DIVINE_PROTECTION",
					_ref_target
				);

			if (_ref_existing_status != -1){

				_ref_existing_status._ct_status_stacks +=
					_ct_stacks_added;

				scr_reposition_statuses(
					_ref_target
				);

				return _ref_existing_status;
			}

			//-------------//
			//CREATE STATUS//
			//-------------//
			var _ref_new_status =
				instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

			_ref_new_status._scr_status =
				scr_status_buff_divine_protection;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"DIVINE_PROTECTION";

			_ref_new_status._str_status_desc =
				"BLOCK THE NEXT ATTACK. EACH STACK BLOCKS 1 ATTACK.";

			_ref_new_status._spr_status =
				spr_status_buff_divine_protection;

			_ref_new_status._ct_status_stacks =
				_ct_stacks_added;

			_ref_new_status._flag_status_stackable =
				true;

			_ref_new_status._flag_status_infinite =
				true;

			_ref_new_status._val_status_lifetime =
				-1;

			_ref_new_status._val_status_lifetime_max =
				-1;

			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(
				_ref_target
			);

			return _ref_new_status;

		break;


		//-------//
		//CONSUME//
		//-------//
		case "CONSUME":

			if (!instance_exists(_ref_status)){
				return false;
			}

			_ref_status._ct_status_stacks--;

			if (_ref_status._ct_status_stacks <= 0){

				scr_status_buff_divine_protection(
					"DEATH",
					_ref_status
				);

				return true;
			}

			scr_reposition_statuses(
				_ref_status._ref_host
			);

			return true;

		break;


		//-----//
		//DEATH//
		//-----//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			scr_destroy_status(
				_ref_status
			);

		break;
	}

	return undefined;
}