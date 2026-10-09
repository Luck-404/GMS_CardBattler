//===============================================================================//
//
// SCRIPT: SCR_STATUS_AURA_ROUGH_SEAS
// FUNCTION: Handles Rough Seas as one source-bound Team Aura.
//		   Damaged enemies are randomly repositioned 1 position.
//		   Allied Beasts take 10% increased damage while the Aura is active.
//
// ARGUMENTS: _str_tag selects APPLY/TRIGGER/DEATH.
//			_ref_status is the existing Status instance for non-APPLY commands.
//			_val_magnitude retains the original optional argument.
//			_ref_trigger_target is the damaged enemy for TRIGGER.
//			_ref_target is the Aura source Beast for APPLY.
// RETURNS: Command-specific Status reference, trigger result, or undefined.
//
//===============================================================================//

function scr_status_aura_rough_seas(_str_tag,_ref_status,_val_magnitude=undefined,_ref_trigger_target=undefined,_ref_target=undefined){

	switch (_str_tag){

		case "APPLY":

			if (!instance_exists(_ref_target)){
				return undefined;
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
					"ROUGH_SEAS",
					_str_team
				);

			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){
				return _ref_existing_status;
			}

			var _list_team =
				(_str_team == "PLAYER")
				? obj_battle_player_controller._list_beasts
				: obj_battle_enemy_controller._list_beasts;

			if (!ds_exists(_list_team,ds_type_list)){
				return undefined;
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

			_ref_new_status._scr_status = scr_status_aura_rough_seas;
			_ref_new_status._ref_host = _ref_target;
			_ref_new_status._ref_status_source = _ref_target;
			_ref_new_status._str_team = _str_team;
			_ref_new_status._str_status_scope = "TEAM";
			_ref_new_status._flag_status_source_bound = true;

			_ref_new_status._str_status_type = "AURA";
			_ref_new_status._str_status_name = "ROUGH_SEAS";
			_ref_new_status._str_status_desc = "ENEMIES MOVE WHEN DAMAGED; ALLIES TAKE 10% MORE DAMAGE";
			_ref_new_status._spr_status = spr_status_aura_rough_seas;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = 0;
			_ref_new_status._val_aura_damage_taken_bonus = 10;
			_ref_new_status._str_trigger_region = undefined;
			_ref_new_status._str_aura_scope = "TEAM";
			_ref_new_status._str_aura_trigger = "ENEMY_DAMAGED";

			for (var _it_beast = 0; _it_beast < ds_list_size(_list_team); _it_beast++){

				var _ref_beast = ds_list_find_value(_list_team,_it_beast);

				if (!instance_exists(_ref_beast)){
					continue;
				}

				_ref_beast._val_dmg_taken_scalar_bonus +=
					_ref_new_status._val_aura_damage_taken_bonus;
			}

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
				scr_status_aura_rough_seas("DEATH",_ref_status);
				return false;
			}

			if (
				!instance_exists(_ref_trigger_target) ||
				_ref_trigger_target._val_cur_hp <= 0 ||
				_ref_trigger_target._str_team == _ref_status._str_team
			){
				return false;
			}

			var _list_target_team =
				(_ref_trigger_target._str_team == "PLAYER")
				? obj_battle_player_controller._list_beasts_alive
				: obj_battle_enemy_controller._list_beasts_alive;

			if (!ds_exists(_list_target_team,ds_type_list)){
				return false;
			}

			var _it_position =
				ds_list_find_index(
					_list_target_team,
					_ref_trigger_target
				);

			if (_it_position == -1){
				return false;
			}

			var _arr_moves = [];

			if (_it_position > 0){
				array_push(_arr_moves,-1);
			}

			if (_it_position < ds_list_size(_list_target_team) - 1){
				array_push(_arr_moves,1);
			}

			if (array_length(_arr_moves) <= 0){
				return false;
			}

			var _val_move =
				_arr_moves[
					irandom(array_length(_arr_moves) - 1)
				];

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"ROUGH SEAS",
				undefined,
				c_aqua,
				_ref_trigger_target.x,
				_ref_trigger_target.y - 48
			);

			return scr_battle_reposition_beast(
				_ref_trigger_target,
				_val_move
			);

		break;

		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _list_team =
				(_ref_status._str_team == "PLAYER")
				? obj_battle_player_controller._list_beasts
				: obj_battle_enemy_controller._list_beasts;

			if (ds_exists(_list_team,ds_type_list)){

				for (var _it_beast = 0; _it_beast < ds_list_size(_list_team); _it_beast++){

					var _ref_beast = ds_list_find_value(_list_team,_it_beast);

					if (!instance_exists(_ref_beast)){
						continue;
					}

					_ref_beast._val_dmg_taken_scalar_bonus =
						max(
							0,
							_ref_beast._val_dmg_taken_scalar_bonus -
							_ref_status._val_aura_damage_taken_bonus
						);
				}
			}

			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}
