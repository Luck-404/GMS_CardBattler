//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_MALLEABILITY
// FUNCTION: Handles Malleability.
//           Unstackable Infinite Buff.
//           Allows the host's next card to ignore caster requirements.
//           Remains active until consumed by a successful card cast.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_malleability(_str_tag,_ref_status,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":


			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("MALLEABILITY",_ref_target);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_target._flag_ignore_caster_requirements = true;

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			//-------------------//
			//INFINITE LIFETIME//
			//-------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_buff_malleability;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "MALLEABILITY";
			_ref_new_status._str_status_desc = "NEXT CARD IGNORES CASTER REQUIREMENTS";

			_ref_new_status._spr_status = spr_status_buff_malleability;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region = undefined;

			//----------------------------//
			//IGNORE CASTER REQUIREMENTS//
			//----------------------------//
			_ref_target._flag_ignore_caster_requirements = true;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

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

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			//-----------------------------//
			//RESTORE CASTER REQUIREMENTS//
			//-----------------------------//
			if (instance_exists(_ref_host)){
				_ref_host._flag_ignore_caster_requirements = false;
			}

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
