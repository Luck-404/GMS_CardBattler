//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_HUNGERING_FLAMES_ROUND_END
// FUNCTION: Resolves each team's Hungering Flames once after both normal team
//           turns complete. Each Team Status counts living Burning enemies and
//           heals the Beasts recorded when that Aura was applied.
// RETURNS: True when at least one Hungering Flames heal resolves.
//
//===============================================================================//

function scr_status_trigger_hungering_flames_round_end(){

	if (
		!instance_exists(obj_battle_player_controller) ||
		!instance_exists(obj_battle_enemy_controller)
	){
		return false;
	}

	var _arr_teams = ["PLAYER","ENEMY"];
	var _arr_enemy_lists = [
		obj_battle_enemy_controller._list_beasts_alive,
		obj_battle_player_controller._list_beasts_alive
	];

	var _flag_triggered = false;

	for (var _it_team = 0; _it_team < 2; _it_team++){

		var _str_team = _arr_teams[_it_team];
		var _list_enemies = _arr_enemy_lists[_it_team];

		if (!ds_exists(_list_enemies,ds_type_list)){
			continue;
		}

		var _ref_aura =
			scr_status_check(
				"HUNGERING_FLAMES",
				_str_team
			);

		if (
			_ref_aura == -1 ||
			!instance_exists(_ref_aura)
		){
			continue;
		}

		var _ct_burning_enemies = 0;

		for (var _it_enemy = 0; _it_enemy < ds_list_size(_list_enemies); _it_enemy++){

			var _ref_enemy = ds_list_find_value(_list_enemies,_it_enemy);

			if (
				!instance_exists(_ref_enemy) ||
				_ref_enemy._val_cur_hp <= 0
			){
				continue;
			}

			var _ref_burn =
				scr_status_check(
					"BURN",
					_ref_enemy
				);

			if (
				_ref_burn == -1 ||
				!instance_exists(_ref_burn) ||
				_ref_burn._ct_status_stacks <= 0
			){
				continue;
			}

			_ct_burning_enemies++;
		}

		if (
			scr_status_aura_hungering_flames(
				"TRIGGER",
				_ref_aura,
				undefined,
				_ct_burning_enemies
			)
		){
			_flag_triggered = true;
		}
	}

	return _flag_triggered;
}
