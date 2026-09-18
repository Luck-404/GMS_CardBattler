//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_BACKDRAFT
// FUNCTION: Handles Backdraft.
//           Unstackable Infinite Buff with one charge.
//           The next direct damage instance is split according to the stored
//           reflection percentage and the Buff is then consumed.
//
// ARGUMENTS: _str_tag selects the Status action.
//            _ref_status references an existing Backdraft Status.
//            _val_magnitude is the percentage of damage reflected.
//            _val_lifetime is unused because Backdraft is infinite.
// RETURNS: The active Backdraft Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_buff_backdraft(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			//----------------//
			//VALIDATE TARGET//
			//----------------//
			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//==========//
			//DEFAULTS//
			//==========//
			if (_val_magnitude == undefined){
				_val_magnitude = 50;
			}

			_val_magnitude = clamp(_val_magnitude,0,100);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("BACKDRAFT",_ref_target);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._val_status_magnitude = _val_magnitude;
				_ref_existing_status._ct_status_stacks = 1;

				return _ref_existing_status;
			}

			//===============//
			//CREATE STATUS//
			//===============//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			//-------------------//
			//INFINITE LIFETIME//
			//-------------------//
			scr_status_init_lifetime(_ref_new_status,-1,false,true);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_buff_backdraft;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "BACKDRAFT";
			_ref_new_status._str_status_desc = "NEXT DIRECT DAMAGE REFLECTS 50% TO ITS SOURCE";

			_ref_new_status._spr_status = spr_status_buff_backdraft;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._str_trigger_region = undefined;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(_ref_target._list_statuses,_ref_new_status);

			scr_status_reposition(_ref_target);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			// Infinite event-bound Buff.
			// Does not process each turn.

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_status_destroy(_ref_status);
			}

		break;
	}

	return undefined;
}