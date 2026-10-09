//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_PLAGUE_GARDEN
// FUNCTION: Handles Plague Garden as a timed Team Status.
//           Registers in the owning PLAYER / ENEMY Team Status list.
//           Reapplication by the same team refreshes duration.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_magnitude and _val_lifetime retain their original order.
//            _ref_target may be a Beast on the owning team, PLAYER/ENEMY, or
//            undefined when GLOBAL.REF_CASTER_BEAST supplies the team.
// RETURNS: Command-specific Status reference or undefined.
//
//===============================================================================//

function scr_status_buff_plague_garden(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		case "APPLY":

			if (_val_lifetime == undefined){
				_val_lifetime = 5;
			}

			_val_lifetime = max(1,_val_lifetime);

			var _str_team = "";
			var _ref_source = undefined;

			if (instance_exists(_ref_target)){
				_str_team = _ref_target._str_team;
				_ref_source = _ref_target;
			}
			else if (is_string(_ref_target)){
				var _str_target_team = string_upper(string(_ref_target));

				if (
					_str_target_team == "PLAYER" ||
					_str_target_team == "ENEMY"
				){
					_str_team = _str_target_team;
				}
			}

			if (
				_str_team == "" &&
				instance_exists(global.ref_caster_beast)
			){
				_str_team = global.ref_caster_beast._str_team;
				_ref_source = global.ref_caster_beast;
			}

			if (
				_str_team != "PLAYER" &&
				_str_team != "ENEMY"
			){
				return undefined;
			}

			var _list_team_statuses =
				scr_status_get_team_status_list(
					_str_team
				);

			if (
				_list_team_statuses == undefined ||
				!ds_exists(_list_team_statuses,ds_type_list)
			){
				return undefined;
			}

			var _ref_existing_status =
				scr_status_check(
					"PLAGUE_GARDEN",
					_str_team
				);

			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){
				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

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
				_val_lifetime,
				false,
				false
			);

			_ref_new_status._scr_status = scr_status_buff_plague_garden;
			_ref_new_status._ref_host = undefined;
			_ref_new_status._ref_status_source = _ref_source;
			_ref_new_status._str_team = _str_team;
			_ref_new_status._str_status_scope = "TEAM";
			_ref_new_status._flag_status_source_bound = false;

			// Retain GLOBAL as the gameplay category during staged migration so the
			// existing shared Buff presentation/logging path remains compatible.
			_ref_new_status._str_status_type = "GLOBAL";
			_ref_new_status._str_status_name = "PLAGUE_GARDEN";
			_ref_new_status._str_status_desc = "ENEMY BLEED, POISON, AND VENOM GAINS SUMMON SPORELINGS";
			_ref_new_status._spr_status = spr_status_buff_plague_garden;
			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._str_trigger_region = "END";

			ds_list_add(
				_list_team_statuses,
				_ref_new_status
			);

			scr_status_reposition(_str_team);

			return _ref_new_status;

		break;

		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _list_team_statuses =
				scr_status_get_team_status_list(
					_ref_status._str_team
				);

			if (
				_list_team_statuses == undefined ||
				!ds_exists(_list_team_statuses,ds_type_list) ||
				ds_list_find_index(_list_team_statuses,_ref_status) == -1
			){
				scr_status_destroy(_ref_status);
				return undefined;
			}

			scr_status_tick_lifetime(_ref_status);

			if (instance_exists(_ref_status)){
				scr_status_reposition(_ref_status._str_team);
			}

		break;

		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_status_destroy(_ref_status);
			}

		break;
	}

	return undefined;
}
