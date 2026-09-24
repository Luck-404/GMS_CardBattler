//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_HUNGERING_FLAMES_ROUND_END
// FUNCTION: Resolves Hungering Flames once after both teams complete a round.
//           Each affected Beast heals for its Aura magnitude multiplied by
//           the number of living Burning Beasts on the opposing team.
//
//===============================================================================//

function scr_status_trigger_hungering_flames_round_end(){

	//================//
	//VALIDATE TEAMS//
	//================//
	if (
		!instance_exists(obj_battle_player_controller) ||
		!instance_exists(obj_battle_enemy_controller)
	){
		return false;
	}

	//================//
	//GET TEAM LISTS//
	//================//
	var _arr_team_lists = [
		obj_battle_player_controller._list_beasts_alive,
		obj_battle_enemy_controller._list_beasts_alive
	];

	var _flag_triggered = false;

	//================//
	//PROCESS TEAMS//
	//================//
	for (var _it_team = 0;_it_team < 2;_it_team++){

		var _list_allies = _arr_team_lists[_it_team];
		var _list_enemies = _arr_team_lists[1 - _it_team];

		if (
			!ds_exists(_list_allies,ds_type_list) ||
			!ds_exists(_list_enemies,ds_type_list)
		){
			continue;
		}

		//======================//
		//COUNT BURNING ENEMIES//
		//======================//
		var _ct_burning_enemies = 0;

		for (
			var _it_enemy = 0;
			_it_enemy < ds_list_size(_list_enemies);
			_it_enemy++
		){

			var _ref_enemy = ds_list_find_value(
				_list_enemies,
				_it_enemy
			);

			if (!instance_exists(_ref_enemy)){
				continue;
			}

			if (_ref_enemy._val_cur_hp <= 0){
				continue;
			}

			//----------------//
			//CHECK BURN//
			//----------------//
			var _ref_burn = scr_status_check(
				"BURN",
				_ref_enemy
			);

			if (
				_ref_burn == -1 ||
				!instance_exists(_ref_burn)
			){
				continue;
			}

			if (_ref_burn._ct_status_stacks <= 0){
				continue;
			}

			_ct_burning_enemies++;
		}

		//================//
		//CHECK ALL ALLIES//
		//================//
		for (
			var _it_ally = 0;
			_it_ally < ds_list_size(_list_allies);
			_it_ally++
		){

			var _ref_ally = ds_list_find_value(
				_list_allies,
				_it_ally
			);

			if (!instance_exists(_ref_ally)){
				continue;
			}

			if (_ref_ally._val_cur_hp <= 0){
				continue;
			}

			//======================//
			//CHECK HUNGERING FLAMES//
			//======================//
			var _ref_aura = scr_status_check(
				"HUNGERING_FLAMES",
				_ref_ally
			);

			if (
				_ref_aura == -1 ||
				!instance_exists(_ref_aura)
			){
				continue;
			}

			//================//
			//TRIGGER AURA//
			//================//
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
	}

	return _flag_triggered;
}