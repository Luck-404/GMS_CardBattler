//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_ECHO
// FUNCTION: Handles Echo as a PLAYER / ENEMY Team Status.
//           Each stack causes the owning team's next eligible Card to resolve
//           one additional time. All Echo stacks are consumed when triggered.
//
// ARGUMENTS: _str_tag selects APPLY/CONSUME/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _ct_stacks_added defaults to 1.
//            _ref_source may be a Beast or PLAYER/ENEMY Team string.
// RETURNS: Command-specific Status reference or result.
//
//===============================================================================//

function scr_status_buff_echo(_str_tag,_ref_status,_ct_stacks_added=undefined,_ref_source=undefined){

	switch (_str_tag){

		case "APPLY":

			if (_ct_stacks_added == undefined){
				_ct_stacks_added = 1;
			}

			_ct_stacks_added = max(1,floor(_ct_stacks_added));

			var _str_team = "";
			var _ref_status_source = undefined;

			// Team-string sources are an intentional public input for Echo. Test the
			// string form before INSTANCE_EXISTS because GameMaker rejects strings
			// passed to INSTANCE_EXISTS instead of simply returning false.
			if (is_string(_ref_source)){
				var _str_source_team = string_upper(string(_ref_source));

				if (_str_source_team == "PLAYER" || _str_source_team == "ENEMY"){
					_str_team = _str_source_team;
				}
			}
			else if (instance_exists(_ref_source)){
				_str_team = _ref_source._str_team;
				_ref_status_source = _ref_source;
			}

			if (_str_team == "" && instance_exists(global.ref_caster_beast)){
				_str_team = global.ref_caster_beast._str_team;
				_ref_status_source = global.ref_caster_beast;
			}

			if (_str_team != "PLAYER" && _str_team != "ENEMY"){
				return undefined;
			}

			var _list_team_statuses = scr_status_get_team_status_list(_str_team);

			if (
				_list_team_statuses == undefined ||
				!ds_exists(_list_team_statuses,ds_type_list)
			){
				return undefined;
			}

			var _ref_existing_status = scr_status_check("ECHO",_str_team);

			if (_ref_existing_status != -1 && instance_exists(_ref_existing_status)){
				_ref_existing_status._ct_status_stacks += _ct_stacks_added;
				scr_status_reposition(_str_team);
				return _ref_existing_status;
			}

			var _ref_new_status = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_status",
				obj_battle_status
			);

			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			_ref_new_status._scr_status = scr_status_buff_echo;
			_ref_new_status._ref_host = undefined;
			_ref_new_status._ref_status_source = _ref_status_source;
			_ref_new_status._str_team = _str_team;
			_ref_new_status._str_status_scope = "TEAM";
			_ref_new_status._flag_status_source_bound = false;

			_ref_new_status._str_status_type = "GLOBAL";
			_ref_new_status._str_status_name = "ECHO";
			_ref_new_status._str_status_desc = "THE NEXT ELIGIBLE ALLIED CARD REPEATS ONCE PER ECHO STACK";
			_ref_new_status._spr_status = spr_status_buff_echo;
			_ref_new_status._ct_status_stacks = _ct_stacks_added;
			_ref_new_status._flag_status_stackable = true;
			_ref_new_status._flag_status_uncleansable = true;
			_ref_new_status._str_trigger_region = undefined;

			ds_list_add(
				_list_team_statuses,
				_ref_new_status
			);

			scr_status_reposition(_str_team);

			return _ref_new_status;

		break;

		case "CONSUME":

			if (!instance_exists(_ref_status)){
				return false;
			}

			if (_ref_status._ct_status_stacks <= 0){
				return false;
			}

			scr_status_buff_echo("DEATH",_ref_status);

			return true;

		break;

		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
