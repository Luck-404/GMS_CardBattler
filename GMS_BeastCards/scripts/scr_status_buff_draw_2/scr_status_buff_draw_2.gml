//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_DRAW_2
// FUNCTION: Handles Draw 2 as a PLAYER Team Status.
//           The enemy battle system has no draw-pile event equivalent, so ENEMY
//           application is rejected instead of modifying the player's draw flow.
//
//           Stackable Infinite Buff with consumable charges. Each charge adds
//           2 Cards to one player draw event. Default application grants 3 charges.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/CONSUME/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_lifetime specifies charges added and defaults to 3.
//            _ref_target supplies Team/source context for APPLY.
// RETURNS: Command-specific Status reference or result.
//
//===============================================================================//

function scr_status_buff_draw_2(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		case "APPLY":

			if (!instance_exists(obj_battle_player_controller)){
				return undefined;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			var _ct_charges_added = max(1,floor(_val_lifetime));
			var _str_team = "";
			var _ref_source = undefined;

			if (instance_exists(_ref_target)){
				_str_team = _ref_target._str_team;
				_ref_source = _ref_target;
			}
			else if (is_string(_ref_target)){
				var _str_target_team = string_upper(string(_ref_target));

				if (_str_target_team == "PLAYER" || _str_target_team == "ENEMY"){
					_str_team = _str_target_team;
				}
			}

			if (_str_team == "" && instance_exists(global.ref_caster_beast)){
				_str_team = global.ref_caster_beast._str_team;
				_ref_source = global.ref_caster_beast;
			}

			if (_str_team != "PLAYER"){
				return undefined;
			}

			var _list_team_statuses = scr_status_get_team_status_list("PLAYER");

			if (
				_list_team_statuses == undefined ||
				!ds_exists(_list_team_statuses,ds_type_list)
			){
				return undefined;
			}

			var _ref_existing_status = scr_status_check("DRAW_2","PLAYER");

			if (_ref_existing_status != -1 && instance_exists(_ref_existing_status)){

				_ref_existing_status._ct_status_stacks += _ct_charges_added;
				_ref_existing_status._str_status_desc =
					"NEXT " +
					string(_ref_existing_status._ct_status_stacks) +
					" DRAW EVENTS: +2 CARDS EACH";

				scr_status_reposition("PLAYER");

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
				true,
				true
			);

			_ref_new_status._scr_status = scr_status_buff_draw_2;
			_ref_new_status._ref_host = undefined;
			_ref_new_status._ref_status_source = _ref_source;
			_ref_new_status._str_team = "PLAYER";
			_ref_new_status._str_status_scope = "TEAM";
			_ref_new_status._flag_status_source_bound = false;

			_ref_new_status._str_status_type = "GLOBAL";
			_ref_new_status._str_status_name = "DRAW_2";
			_ref_new_status._str_status_desc =
				"NEXT " + string(_ct_charges_added) +
				" DRAW EVENTS: +2 CARDS EACH";
			_ref_new_status._spr_status = spr_status_buff_draw_2;
			_ref_new_status._ct_status_stacks = _ct_charges_added;
			_ref_new_status._val_status_magnitude = 2;
			_ref_new_status._flag_status_stackable = true;
			_ref_new_status._str_trigger_region = undefined;

			ds_list_add(
				_list_team_statuses,
				_ref_new_status
			);

			scr_status_reposition("PLAYER");

			return _ref_new_status;

		break;

		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			scr_status_tick_lifetime(_ref_status);

		break;

		case "CONSUME":

			if (!instance_exists(_ref_status)){
				return false;
			}

			if (_ref_status._ct_status_stacks <= 0){
				return false;
			}

			_ref_status._ct_status_stacks--;

			if (_ref_status._ct_status_stacks <= 0){
				scr_status_buff_draw_2("DEATH",_ref_status);
				return true;
			}

			_ref_status._str_status_desc =
				"NEXT " +
				string(_ref_status._ct_status_stacks) +
				" DRAW EVENTS: +2 CARDS EACH";

			scr_status_reposition("PLAYER");

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
