//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_CALL_THE_DEEP
// FUNCTION: Handles the expendable Call the Deep Buff.
//           The host's next direct damage instance gains +5 damage.
//           The Buff is consumed when that damage is dealt.
//
//===============================================================================//

function scr_status_buff_call_the_deep(
	_str_tag,
	_ref_status,
	_val_magnitude=undefined
){

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

			if (_val_magnitude == undefined){
				_val_magnitude = 5;
			}

			_val_magnitude =
				max(
					0,
					_val_magnitude
				);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_status_check(
					"CALL_THE_DEEP",
					_ref_target
				);

			if (_ref_existing_status != -1){

				_ref_existing_status._val_status_magnitude =
					_val_magnitude;

				return _ref_existing_status;
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

			//---------------------//
			//INFINITE UNTIL USED//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			_ref_new_status._scr_status =
				scr_status_buff_call_the_deep;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"CALL_THE_DEEP";

			_ref_new_status._str_status_desc =
				"NEXT DIRECT DAMAGE DEALS +5 DAMAGE";

			_ref_new_status._spr_status =
				spr_status_buff_call_the_deep;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._flag_status_stackable =
				false;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._str_trigger_region =
				undefined;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(
				_ref_target
			);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (instance_exists(_ref_status)){

				scr_status_destroy(
					_ref_status
				);
			}

		break;
	}

	return undefined;
}