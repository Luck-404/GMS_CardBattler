//===============================================================================//
//
// SCRIPT: SCR_STATUS_AURA_HONEYED_SCENT
// FUNCTION: Handles Honeyed Scent as one source-bound Team Aura.
//		   Allied Attack casts summon Wasp Drones on the casting Beast.
//		   The Aura source has 0 Dodge and takes 10% increased damage.
//
// ARGUMENTS: _str_tag selects APPLY/TRIGGER/DEATH.
//			_ref_status is the existing Status instance for non-APPLY commands.
//			_val_magnitude is the source's incoming-damage penalty.
//			_ref_trigger_caster is the allied Attack caster for TRIGGER.
//			_ref_target is the Aura source Beast for APPLY.
// RETURNS: Command-specific Status reference, trigger result, or undefined.
//
//===============================================================================//

function scr_status_aura_honeyed_scent(_str_tag,_ref_status,_val_magnitude=undefined,_ref_trigger_caster=undefined,_ref_target=undefined){

	switch (_str_tag){

		case "APPLY":

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (
				_val_magnitude == undefined ||
				_val_magnitude <= 0
			){
				_val_magnitude = 10;
			}

			var _str_team = _ref_target._str_team;
			var _list_team_statuses = scr_status_get_team_status_list(_str_team);

			if (
				_list_team_statuses == undefined ||
				!ds_exists(_list_team_statuses,ds_type_list)
			){
				return undefined;
			}

			scr_status_prune_team_status_sources(_str_team);

			var _ref_existing_status =
				scr_status_check(
					"HONEYED_SCENT",
					_str_team
				);

			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){
				return _ref_existing_status;
			}

			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			_ref_new_status._scr_status = scr_status_aura_honeyed_scent;
			_ref_new_status._ref_host = _ref_target;
			_ref_new_status._ref_status_source = _ref_target;
			_ref_new_status._str_team = _str_team;
			_ref_new_status._str_status_scope = "TEAM";
			_ref_new_status._flag_status_source_bound = true;

			_ref_new_status._str_status_type = "AURA";
			_ref_new_status._str_status_name = "HONEYED_SCENT";
			_ref_new_status._str_status_desc = "ALLIED ATTACK CASTS SUMMON WASP DRONES; SOURCE DODGE 0; DAMAGE TAKEN +10%";
			_ref_new_status._spr_status = spr_status_aura_honeyed_scent;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = _val_magnitude;
			_ref_new_status._str_trigger_region = undefined;
			_ref_new_status._str_aura_scope = "TEAM";
			_ref_new_status._str_aura_trigger = "ATTACK_CAST";

			_ref_target._ct_dodge_disabled++;
			_ref_target._val_dmg_taken_scalar_bonus += _val_magnitude;

			//========================//
			//REGISTER SOURCE DEATH LINK//
			//========================//
			/*
				The Team registry owns presentation/turn processing. Keeping the same
				Status reference in the source Beast's Status list preserves the old
				immediate source-death and source-cleanse behavior. Host layout and
				turn queues explicitly ignore TEAM-scope entries.
			*/
			if (
				ds_exists(_ref_target._list_statuses,ds_type_list) &&
				ds_list_find_index(_ref_target._list_statuses,_ref_new_status) == -1
			){
				ds_list_add(
					_ref_target._list_statuses,
					_ref_new_status
				);
			}

			ds_list_add(
				_list_team_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);
			scr_status_reposition(_str_team);

			return _ref_new_status;

		break;

		case "TRIGGER":

			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_source = _ref_status._ref_status_source;

			if (
				!instance_exists(_ref_source) ||
				_ref_source._str_list != "ALIVE" ||
				_ref_source._val_cur_hp <= 0
			){
				scr_status_aura_honeyed_scent("DEATH",_ref_status);
				return false;
			}

			if (
				!instance_exists(_ref_trigger_caster) ||
				_ref_trigger_caster._str_team != _ref_status._str_team ||
				_ref_trigger_caster._val_cur_hp <= 0
			){
				return false;
			}

			var _ref_wasp = scr_minion_init(
				"WASP_DRONE",
				undefined,
				_ref_trigger_caster,
				_ref_trigger_caster
			);

			return instance_exists(_ref_wasp);

		break;

		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_source = _ref_status._ref_status_source;

			if (!instance_exists(_ref_source)){
				_ref_source = _ref_status._ref_host;
			}

			if (instance_exists(_ref_source)){

				_ref_source._ct_dodge_disabled =
					max(
						0,
						_ref_source._ct_dodge_disabled - 1
					);

				_ref_source._val_dmg_taken_scalar_bonus =
					max(
						0,
						_ref_source._val_dmg_taken_scalar_bonus -
						_ref_status._val_status_magnitude
					);
			}

			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
