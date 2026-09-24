
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_REDIRECT_GUARD
// FUNCTION: Displays the protector side of an individual Redirect link.
//           One protector may have only one active Guard relationship.
//           Each Guard is paired with exactly one Redirect.
//           Removing either Status removes its counterpart.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Guard for non-APPLY commands.
//            _ref_redirect_status is the linked Redirect on APPLY.
// RETURNS: Guard Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_buff_redirect_guard(_str_tag,_ref_status,_ref_redirect_status=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//===================//
			//VALIDATE REDIRECT//
			//===================//
			if (!instance_exists(_ref_redirect_status)){
				return undefined;
			}

			var _ref_protected = _ref_redirect_status._ref_host;
			var _ref_guard = _ref_redirect_status._ref_status_target;

			if (
				!instance_exists(_ref_protected) ||
				!instance_exists(_ref_guard)
			){
				return undefined;
			}

			if (
				_ref_protected._str_team != _ref_guard._str_team ||
				_ref_protected == _ref_guard
			){
				return undefined;
			}

			if (!ds_exists(_ref_guard._list_statuses,ds_type_list)){
				return undefined;
			}

			//================//
			//GET LINK LABEL//
			//================//
			var _str_link_label =
				_ref_redirect_status._str_redirect_link_label;

			var _str_protected_name = string_upper(
				_ref_protected._ref_unit._str_beast_name
			);

			var _str_guard_name = string_upper(
				_ref_guard._ref_unit._str_beast_name
			);

			//================//
			//CREATE GUARD//
			//================//
			var _ref_new_status = instance_create_layer(
				_ref_guard.x,
				_ref_guard.y,
				"ily_status",
				obj_battle_status
			);

			if (!instance_exists(_ref_new_status)){
				return undefined;
			}

			//===================//
			//INFINITE LIFETIME//
			//===================//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_redirect_guard;

			_ref_new_status._ref_host = _ref_guard;
			_ref_new_status._ref_status_target = _ref_protected;
			_ref_new_status._ref_redirect_status = _ref_redirect_status;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "REDIRECT_GUARD";

			_ref_new_status._str_status_desc =
				"LINK [" + _str_link_label + "] | " +
				"GUARDING " + _str_protected_name +
				" | DAMAGE GOES TO " + _str_guard_name;

			_ref_new_status._spr_status = spr_status_buff_redirect_guard;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_redirect_link_label = _str_link_label;

			_ref_new_status._str_trigger_region = undefined;

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				_ref_guard._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_guard);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			// Infinite, event-bound Buff.
			// No turn-based decrement.

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//========================//
			//REMOVE MATCHING REDIRECT//
			//========================//
			if (
				variable_instance_exists(
					_ref_status,
					"_ref_redirect_status"
				) &&
				instance_exists(_ref_status._ref_redirect_status)
			){

				var _ref_linked_redirect =
					_ref_status._ref_redirect_status;

				_ref_status._ref_redirect_status = undefined;
				_ref_linked_redirect._ref_redirect_guard_status = undefined;

				scr_status_buff_redirect(
					"DEATH",
					_ref_linked_redirect
				);
			}

			//================//
			//REMOVE GUARD//
			//================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}