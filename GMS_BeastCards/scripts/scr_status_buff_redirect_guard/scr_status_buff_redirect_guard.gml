//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_REDIRECT_GUARD
// FUNCTION: Displays the protector side of a Redirect relationship.
//           Infinite linked Buff attached to the Beast receiving redirected
//           damage.
//           Removing this Buff also removes its linked Redirect.
//
// ARGUMENTS: _str_tag selects the Status action.
//            _ref_status references an existing Redirect Guard Status.
//            _ref_redirect_status is the linked Redirect Status on the ally.
// RETURNS: The Redirect Guard Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_buff_redirect_guard(_str_tag,_ref_status,_ref_redirect_status=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//-------------------//
			//VALIDATE REDIRECT//
			//-------------------//
			if (!instance_exists(_ref_redirect_status)){
				return undefined;
			}

			var _ref_protected = _ref_redirect_status._ref_host;
			var _ref_guard = _ref_redirect_status._ref_status_target;

			if (!instance_exists(_ref_protected)){
				return undefined;
			}

			if (!instance_exists(_ref_guard)){
				return undefined;
			}

			if (!ds_exists(_ref_guard._list_statuses,ds_type_list)){
				return undefined;
			}

			//================//
			//CREATE STATUS//
			//================//
			var _ref_new_status = instance_create_layer(
				_ref_guard.x,
				_ref_guard.y,
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
			_ref_new_status._scr_status = scr_status_buff_redirect_guard;

			_ref_new_status._ref_host = _ref_guard;
			_ref_new_status._ref_status_target = _ref_protected;
			_ref_new_status._ref_redirect_status = _ref_redirect_status;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "REDIRECT_GUARD";
			_ref_new_status._str_status_desc = "NEXT DAMAGE TO LINKED ALLY IS REDIRECTED HERE";

			_ref_new_status._spr_status = spr_status_buff_redirect_guard;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region = undefined;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(_ref_guard._list_statuses,_ref_new_status);

			scr_status_reposition(_ref_guard);

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

			//=======================//
			//REMOVE LINKED REDIRECT//
			//=======================//
			if (
				variable_instance_exists(_ref_status,"_ref_redirect_status") &&
				instance_exists(_ref_status._ref_redirect_status)
			){

				var _ref_linked_redirect = _ref_status._ref_redirect_status;

				_ref_status._ref_redirect_status = undefined;
				_ref_linked_redirect._ref_redirect_guard_status = undefined;

				scr_status_buff_redirect("DEATH",_ref_linked_redirect);
			}

			//=====================//
			//REMOVE GUARD STATUS//
			//=====================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}