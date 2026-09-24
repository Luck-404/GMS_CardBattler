//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_CATACLYSM_RESOLVE_STAGE
// FUNCTION: Resolves one ERUPTION threshold across the complete target team.
//
//           Stage order is owned by the sequence context:
//           3 -> 5 -> 8 -> 10.
//
// ARGUMENTS: _stct_sequence.
// RETURNS: True if another stage remains.
//
//===============================================================================//

function scr_card_vermilion_cataclysm_resolve_stage(_stct_sequence){

	#region VALIDATION

	//================//
	//VALIDATE SEQUENCE//
	//================//
	if (!is_struct(_stct_sequence)){
		return false;
	}

	if (!instance_exists(_stct_sequence._ref_caster)){
		return false;
	}

	if (!instance_exists(_stct_sequence._ref_card)){
		return false;
	}

	//================//
	//CHECK STAGE//
	//================//
	if (_stct_sequence._it_stage >= array_length(_stct_sequence._arr_stages)){
		return false;
	}

	#endregion

	#region CAST CONTEXT

	//================//
	//STORE GLOBALS//
	//================//
	var _ref_original_card = global.ref_cast_card;
	var _ref_original_caster = global.ref_caster_beast;
	var _flag_original_resolving = global.flag_card_effect_resolving;

	//================//
	//RESTORE CARD CAST//
	//================//
	global.ref_cast_card = _stct_sequence._ref_card;
	global.ref_caster_beast = _stct_sequence._ref_caster;

	global.flag_card_effect_resolving = true;

	//================//
	//GET STAGE//
	//================//
	var _ct_eruption = _stct_sequence._arr_stages[
		_stct_sequence._it_stage
	];

	_stct_sequence._it_stage++;

	#endregion

	#region RESOLVE ERUPTION

	//================//
	//TRACK FIRESTORM//
	//================//
	var _flag_firestorm = false;

	//================//
	//PROCESS TARGETS//
	//================//
	for (
		var _it_target = 0;
		_it_target < array_length(_stct_sequence._arr_targets);
		_it_target++
	){

		var _stct_target = _stct_sequence._arr_targets[_it_target];

		var _ref_beast = _stct_target._ref_beast;

		//================//
		//CHECK TARGET//
		//================//
		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (
			_ref_beast._str_list != "ALIVE" ||
			_ref_beast._val_cur_hp <= 0
		){
			continue;
		}

		//================//
		//CHECK THRESHOLD//
		//================//
		if (_stct_target._ct_burn < scr_battle_get_eruption_threshold(_ct_eruption)){
			continue;
		}


		//================//
		//TRIGGER ERUPTION//
		//================//
		if (!scr_battle_trigger_eruption(_ref_beast,_ct_eruption)){
			continue;
		}

		switch (_ct_eruption){

			//===========//
			//ERUPTION 3//
			//===========//
			case 3:

				//================//
				//GET BURN//
				//================//
				var _ref_burn = scr_status_check(
					"BURN",
					_ref_beast
				);

				if (
					_ref_burn == -1 ||
					!instance_exists(_ref_burn)
				){
					break;
				}

				//================//
				//FORCE TWO TICKS / PRESERVE BURN LIFETIME//
				//================//
				repeat (2){

					if (
						!instance_exists(_ref_beast) ||
						_ref_beast._val_cur_hp <= 0 ||
						!instance_exists(_ref_burn)
					){
						break;
					}

					scr_status_dot_burn(
						"REPEAT",
						_ref_burn,
						undefined,
						true // Forced tick: no lifetime decrement.
					);
				}

			break;

			//===========//
			//ERUPTION 5//
			//===========//
			case 5:

				//================//
				//GET ADJACENT//
				//================//
				var _arr_adjacent = [
					scr_battle_get_left_target(_ref_beast),
					scr_battle_get_right_target(_ref_beast)
				];

				//================//
				//EXPLODE//
				//================//
				for (
					var _it_adjacent = 0;
					_it_adjacent < array_length(_arr_adjacent);
					_it_adjacent++
				){

					var _ref_adjacent = _arr_adjacent[_it_adjacent];

					if (!instance_exists(_ref_adjacent)){
						continue;
					}

					if (
						_ref_adjacent._str_list != "ALIVE" ||
						_ref_adjacent._val_cur_hp <= 0
					){
						continue;
					}


					scr_battle_damage_target(
						"LINEAR",
						_stct_sequence._ref_caster,
						_ref_adjacent,
						5,
						{card: _stct_sequence._ref_card._ref_card, card_instance: _stct_sequence._ref_card}
					);
				}

			break;

			//===========//
			//ERUPTION 8//
			//===========//
			case 8:

				//=====================//
				//QUEUE TEAM EFFECT//
				//=====================//
				_flag_firestorm = true;

			break;

			//============//
			//ERUPTION 10//
			//============//
			case 10:

				//================//
				//DEAL 20 MAG//
				//================//
				scr_battle_damage_target(
					"LINEAR",
					_stct_sequence._ref_caster,
					_ref_beast,
					20,
					{card: _stct_sequence._ref_card._ref_card, card_instance: _stct_sequence._ref_card}
				);

				//================//
				//CHECK SURVIVAL//
				//================//
				if (
					!instance_exists(_ref_beast) ||
					_ref_beast._str_list != "ALIVE" ||
					_ref_beast._val_cur_hp <= 0
				){
					break;
				}


				//================//
				//APPLY 5 CHAR//
				//================//
				repeat (5){

					scr_status_debuff_char("APPLY", undefined, undefined, _ref_beast);
				}

				//================//
				//CHAR FEEDBACK//
				//================//
				scr_battle_vfx_char(_ref_beast);

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"+5 CHAR",
					undefined,
					c_red,
					_ref_beast.x,
					_ref_beast.y - 48
				);

				//================//
				//APPLY STUN//
				//================//
				scr_status_apply_cc("STUN", _ref_beast, 1);

			break;
		}
	}

	#endregion

	#region FIRESTORM

	//=====================//
	//ERUPTION 8 EFFECT//
	//=====================//
	if (_flag_firestorm){

		//================//
		//BEGIN FIRESTORM//
		//================//
		scr_status_apply_weather(
			"FIRESTORM",
			5
		);

		//================//
		//GET ENEMY TEAM//
		//================//
		var _list_enemies = undefined;

		if (_stct_sequence._ref_caster._str_team == "PLAYER"){

			if (instance_exists(obj_battle_enemy_controller)){
				_list_enemies = obj_battle_enemy_controller._list_beasts_alive;
			}
		}
		else if (_stct_sequence._ref_caster._str_team == "ENEMY"){

			if (instance_exists(obj_battle_player_controller)){
				_list_enemies = obj_battle_player_controller._list_beasts_alive;
			}
		}

		//================//
		//STRIKE ENEMIES//
		//================//
		if (
			_list_enemies != undefined &&
			ds_exists(_list_enemies,ds_type_list)
		){

			//================//
			//SNAPSHOT ENEMIES//
			//================//
			var _arr_enemies = [];

			for (
				var _it_enemy = 0;
				_it_enemy < ds_list_size(_list_enemies);
				_it_enemy++
			){

				array_push(
					_arr_enemies,
					ds_list_find_value(_list_enemies,_it_enemy)
				);
			}

			//================//
			//DEAL 8 MAG//
			//================//
			for (
				var _it_enemy = 0;
				_it_enemy < array_length(_arr_enemies);
				_it_enemy++
			){

				var _ref_enemy = _arr_enemies[_it_enemy];

				if (!instance_exists(_ref_enemy)){
					continue;
				}

				if (
					_ref_enemy._str_list != "ALIVE" ||
					_ref_enemy._val_cur_hp <= 0
				){
					continue;
				}


				scr_battle_damage_target(
					"LINEAR",
					_stct_sequence._ref_caster,
					_ref_enemy,
					8,
					{card: _stct_sequence._ref_card._ref_card, card_instance: _stct_sequence._ref_card}
				);
			}
		}
	}

	#endregion

	#region CLEANUP

	//================//
	//RESTORE GLOBALS//
	//================//
	global.ref_cast_card = _ref_original_card;
	global.ref_caster_beast = _ref_original_caster;

	global.flag_card_effect_resolving = _flag_original_resolving;

	//================//
	//MORE STAGES?//
	//================//
	return (
		_stct_sequence._it_stage <
		array_length(_stct_sequence._arr_stages)
	);

	#endregion
}
