//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_MANAVINE
// FUNCTION: Handles Manavine as a PLAYER Team Status.
//           Enemy application is rejected because enemy combat has no Mana pool.
//           Grants temporary Maximum Mana on first application and equal Current
//           Mana on every application. Reapplication refreshes duration without
//           stacking the Maximum Mana contribution.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_magnitude=undefined, _val_lifetime=undefined.
//            _ref_target supplies Team/source context for APPLY.
// RETURNS: Command-specific Status reference or undefined.
//
//===============================================================================//

function scr_status_buff_manavine(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		case "APPLY":

			if (!instance_exists(obj_battle_player_controller)){
				return undefined;
			}

			if (_val_magnitude == undefined){
				_val_magnitude = 1;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_magnitude = max(0,_val_magnitude);
			_val_lifetime = max(1,_val_lifetime);

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

			var _ref_existing_status = scr_status_check("MANAVINE","PLAYER");

			if (_ref_existing_status != -1 && instance_exists(_ref_existing_status)){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				scr_battle_gain_mana(
					_ref_existing_status._val_status_magnitude
				);

				_ref_existing_status._str_status_desc =
					"+" + string(_ref_existing_status._val_status_magnitude) +
					" MAXIMUM MANA. GAIN " + string(_ref_existing_status._val_status_magnitude) +
					" CURRENT MANA ON APPLY. " + string(_ref_existing_status._val_status_lifetime) +
					" ROUNDS REMAINING.";

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
				_val_lifetime,
				false,
				false
			);

			_ref_new_status._scr_status = scr_status_buff_manavine;
			_ref_new_status._ref_host = undefined;
			_ref_new_status._ref_status_source = _ref_source;
			_ref_new_status._str_team = "PLAYER";
			_ref_new_status._str_status_scope = "TEAM";
			_ref_new_status._flag_status_source_bound = false;

			_ref_new_status._str_status_type = "GLOBAL";
			_ref_new_status._str_status_name = "MANAVINE";
			_ref_new_status._str_status_desc =
				"+" + string(_val_magnitude) +
				" MAXIMUM MANA. GAIN " + string(_val_magnitude) +
				" CURRENT MANA ON APPLY. " + string(_val_lifetime) +
				" ROUNDS REMAINING.";
			_ref_new_status._spr_status = spr_status_buff_manavine;
			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = _val_magnitude;
			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._str_trigger_region = "END";

			_ref_new_status._val_team_max_mana_bonus_applied =
				max(
					0,
					scr_battle_change_max_mana(
						_ref_new_status._val_status_magnitude
					)
				);

			scr_battle_gain_mana(
				_ref_new_status._val_status_magnitude
			);

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

			var _list_team_statuses = scr_status_get_team_status_list("PLAYER");

			//======================//
			//VALIDATE TEAM REGISTRY//
			//======================//
			if (
				_list_team_statuses == undefined ||
				!ds_exists(_list_team_statuses,ds_type_list)
			){
				/*
					Do not destroy this resource Status without its normal cleanup.
					Running DEATH guarantees its temporary Maximum Mana contribution
					is returned before the Status instance is removed.
				*/
				scr_status_buff_manavine(
					"DEATH",
					_ref_status
				);

				return undefined;
			}

			//========================//
			//REPAIR LOST REGISTRATION//
			//========================//
			if (
				ds_list_find_index(
					_list_team_statuses,
					_ref_status
				) == -1
			){
				ds_list_add(
					_list_team_statuses,
					_ref_status
				);

				scr_debug_log(
					"BATTLE",
					"STATUS",
					_ref_status,
					"MANAVINE TEAM STATUS REGISTRATION REPAIRED",
					"BATTLE",
					"SCR_STATUS_BUFF_MANAVINE"
				);
			}

			//================//
			//UPDATE LIFETIME//
			//================//
			scr_status_tick_lifetime(_ref_status);

			if (instance_exists(_ref_status)){
				_ref_status._str_status_desc =
					"+" + string(_ref_status._val_status_magnitude) +
					" MAXIMUM MANA. GAIN " + string(_ref_status._val_status_magnitude) +
					" CURRENT MANA ON APPLY. " + string(_ref_status._val_status_lifetime) +
					" ROUNDS REMAINING.";

				scr_status_reposition("PLAYER");
			}

		break;

		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _val_mana_bonus = 0;

			if (
				variable_instance_exists(
					_ref_status,
					"_val_team_max_mana_bonus_applied"
				)
			){
				_val_mana_bonus =
					max(
						0,
						_ref_status._val_team_max_mana_bonus_applied
					);
			}
			else{
				// Compatibility fallback for a Status created before this hotfix.
				_val_mana_bonus =
					max(
						0,
						_ref_status._val_status_magnitude
					);
			}

			if (_val_mana_bonus > 0){
				scr_battle_change_max_mana(
					-_val_mana_bonus
				);
			}

			_ref_status._val_team_max_mana_bonus_applied = 0;

			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
