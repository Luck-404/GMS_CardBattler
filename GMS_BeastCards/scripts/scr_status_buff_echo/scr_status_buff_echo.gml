//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_ECHO
// FUNCTION: Creates and manages the global Echo Buff.
//           Each stack causes the next eligible card to repeat one additional time.
//           Echo is infinite and remains until consumed.
//
//===============================================================================//

function scr_status_buff_echo(_str_tag,_ref_status,_ct_stacks_added=1){

	switch(_str_tag){

		//-----//
		//APPLY//
		//-----//
		case "APPLY":

			_ct_stacks_added =
				max(1,_ct_stacks_added);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_check_for_status(
					"ECHO",
					global.list_statuses
				);

			//----------------//
			//ADD TO EXISTING//
			//----------------//
			if (_ref_existing_status != -1){

				_ref_existing_status._ct_status_stacks +=
					_ct_stacks_added;

				scr_reposition_statuses(
					global.list_statuses
				);

				return _ref_existing_status;
			}

			//-------------//
			//CREATE STATUS//
			//-------------//
			var _ref_new_status =
				instance_create_layer(
					room_width * 0.5,
					room_height * 0.5,
					"ily_status",
					obj_battle_status
				);

			//--------//
			//SCRIPT//
			//--------//
			_ref_new_status._scr_status =
				scr_status_buff_echo;

			//------//
			//HOST//
			//------//
			_ref_new_status._ref_host =
				undefined;

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._str_status_type =
				"GLOBAL";

			_ref_new_status._str_status_name =
				"ECHO";

			_ref_new_status._str_status_desc =
				"THE NEXT ELIGIBLE CARD REPEATS ONCE PER ECHO STACK.";

			_ref_new_status._spr_status =
				spr_status_buff_echo;

			//--------//
			//STACKS//
			//--------//
			_ref_new_status._ct_status_stacks =
				_ct_stacks_added;

			_ref_new_status._flag_status_stackable =
				true;

			//----------//
			//INFINITE//
			//----------//
			_ref_new_status._flag_status_infinite =
				true;

			_ref_new_status._val_status_lifetime =
				-1;

			_ref_new_status._val_status_lifetime_max =
				-1;

			//----------------//
			//NO ROUND TRIGGER//
			//----------------//
			_ref_new_status._str_trigger_region =
				undefined;

			//----------------//
			//RESOURCE STATUS//
			//----------------//
			_ref_new_status._flag_status_uncleansable =
				true;

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


		//-------//
		//CONSUME//
		//-------//
		case "CONSUME":

			if (!instance_exists(_ref_status)){
				return false;
			}

			/*
				Current Echo behavior consumes the entire
				accumulated Echo resource when the next
				eligible card triggers it.
			*/

			scr_status_buff_echo(
				"DEATH",
				_ref_status
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