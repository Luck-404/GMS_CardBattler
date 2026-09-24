//===============================================================================//
//
// SCRIPT: SCR_MINION_CAST_EFFECT
// FUNCTION: Validates Minion/Host ownership and independent action eligibility.
//           Resolves the original per-Minion behaviors in their original order.
//           Individual enemy-target effects use scr_minion_get_target.
//
// ARGUMENTS: _ref_minion - Battle Minion acting during its team's Minion phase.
// RETURNS: No value.
//
//===============================================================================//

function scr_minion_cast_effect(_ref_minion){

	#region PREFLIGHT

	//================//
	//VALIDATE MINION//
	//================//
	if (!instance_exists(_ref_minion) || _ref_minion._val_cur_hp <= 0){
		return;
	}

	//================//
	//VALIDATE HOST//
	//================//
	var _ref_host = _ref_minion._ref_host;
	if (!instance_exists(_ref_host) || _ref_host._str_list != "ALIVE" || _ref_host._val_cur_hp <= 0){
		return;
	}

	if (!variable_instance_exists(_ref_host,"_list_minions") || !ds_exists(_ref_host._list_minions,ds_type_list)){
		return;
	}

	if (ds_list_find_index(_ref_host._list_minions,_ref_minion) == -1 || _ref_host._str_team != _ref_minion._str_team){
		return;
	}

	//========================//
	//VALIDATE ACTIVATION PHASE//
	//========================//
	if (!instance_exists(obj_battle_player_controller) || !instance_exists(obj_battle_enemy_controller) || !instance_exists(obj_battle_turn_controller)){
		return;
	}

	var _ref_turn = obj_battle_turn_controller;
	if (!_ref_turn._flag_started_game || _ref_turn._flag_battle_ended){
		return;
	}

	// Minions act in their own phase; the host's Stun/Sleep/Frozen must not suppress them.
	var _str_minion_team = _ref_minion._str_team;
	var _list_host_team = undefined;
	var _list_enemy = undefined;

	switch (_str_minion_team){
		case "PLAYER":
			if (_ref_turn._val_turn_tracker != 0 || obj_battle_player_controller._state_player != ENUM_PLAYER_STATE.TRIGGER_MINIONS){
				return;
			}
			_list_host_team = obj_battle_player_controller._list_beasts_alive;
			_list_enemy = obj_battle_enemy_controller._list_beasts_alive;
		break;

		case "ENEMY":
			if (_ref_turn._val_turn_tracker != 1 || obj_battle_enemy_controller._state_enemy != ENUM_ENEMY_STATE.TRIGGER_MINIONS){
				return;
			}
			_list_host_team = obj_battle_enemy_controller._list_beasts_alive;
			_list_enemy = obj_battle_player_controller._list_beasts_alive;
		break;

		default:
			return;
	}

	if (!ds_exists(_list_host_team,ds_type_list) || !ds_exists(_list_enemy,ds_type_list) || ds_list_find_index(_list_host_team,_ref_host) == -1){
		return;
	}

	var _str_minion_name = _ref_minion._str_name;

	#endregion

	//================//
	//MINION EFFECTS//
	//================//
	switch (_str_minion_name){

		//------------//
		//MAGMA CANNON//
		//------------//
		case "MAGMA CANNON":

			//================//
			//GET RANDOM ENEMY//
			//================//
			var _ref_target = scr_minion_get_target(_list_enemy);

			if (!instance_exists(_ref_target)){
				break;
			}

			//================//
			//MINION CAST VFX//
			//================//
			scr_battle_vfx_minion_cast(_ref_minion,"ENEMY");

			//================//
			//CALCULATE DAMAGE//
			//================//
			var _val_damage = _ref_minion._val_magnitude;

			//================//
			//CHECK BURN//
			//================//
			var _ref_burn = scr_status_check("BURN",_ref_target);

			var _flag_burning = (
				_ref_burn != -1 &&
				instance_exists(_ref_burn) &&
				_ref_burn._ct_status_stacks > 0
			);

			//==================//
			//BURN DAMAGE BONUS//
			//==================//
			if (_flag_burning){
				_val_damage += 2;
			}

			//================//
			//DEBUG ACTION//
			//================//
			scr_debug_log_minion_action(
				_ref_minion,
				"ATTACKED",
				_ref_target,
				"NEU DAMAGE: " + string(_val_damage) +
				" | TARGET BURNING: " + (_flag_burning ? "YES" : "NO"),
				"SCR_MINION_CAST_EFFECT"
			);

			//================//
			//DEAL NEU DAMAGE//
			//================//
			scr_battle_damage_target(
				"FIXED",
				_ref_minion,
				_ref_target,
				_val_damage
			);

		break;

//============//
//ASH PHOENIX//
//============//
case "ASH PHOENIX":

	//================//
	//SELECT TARGET//
	//================//
	var _ref_target = scr_minion_get_target(
		_list_enemy
	);

	if (!instance_exists(_ref_target)){
		break;
	}

	//================//
	//CAST VFX//
	//================//
	scr_battle_vfx_minion_cast(
		_ref_minion,
		"ENEMY"
	);

	//================//
	//CALCULATE DAMAGE//
	//================//
	var _val_damage = max(
		0,
		_ref_minion._val_magnitude * 3
	);

	//================//
	//DEBUG ACTION//
	//================//
	scr_debug_log_minion_action(
		_ref_minion,
		"ATTACKED",
		_ref_target,
		"NEU DAMAGE: " + string(_val_damage) +
		" | WEAKNESS: 1 ROUND",
		"SCR_MINION_CAST_EFFECT"
	);

	//================//
	//DEAL NEU DAMAGE//
	//================//
	scr_battle_damage_target(
		"FIXED",
		_ref_minion,
		_ref_target,
		_val_damage
	);

	//================//
	//CHECK TARGET//
	//================//
	if (!instance_exists(_ref_target)){
		break;
	}

	if (
		_ref_target._str_list != "ALIVE" ||
		_ref_target._val_cur_hp <= 0
	){
		break;
	}

	//================//
	//APPLY WEAKNESS//
	//================//
	scr_status_apply_debuff("WEAKNESS", _ref_target, 1);


break;

//-------------//
//LIVING FLAME//
//-------------//
case "LIVING FLAME":

	//================//
	//GET RANDOM ENEMY//
	//================//
	var _ref_target = scr_minion_get_target(
		_list_enemy
	);

	if (!instance_exists(_ref_target)){
		break;
	}

	//----------------//
	//MINION CAST VFX//
	//----------------//
	scr_battle_vfx_minion_cast(
		_ref_minion,
		"ENEMY"
	);

	//================//
	//CALCULATE DAMAGE//
	//================//
	var _val_magnitude = max(
		0,
		_ref_minion._val_magnitude
	);

	var _val_damage = _val_magnitude;
	var _val_bonus_damage = 0;

	//====================//
	//CHECK TARGET ARMOR//
	//====================//
	var _flag_target_armored = (
		_ref_target._val_armor > 0
	);

	if (_flag_target_armored){

		_val_bonus_damage = ceil(
			_val_magnitude / 2
		);

		_val_damage += _val_bonus_damage;
	}

	//================//
	//DEBUG ACTION//
	//================//
	scr_debug_log_minion_action(
		_ref_minion,
		"ATTACKED",
		_ref_target,
		"NEU DAMAGE: " + string(_val_damage) +
		" | MAGNITUDE: " + string(_val_magnitude) +
		" | TARGET ARMORED: " + (_flag_target_armored ? "YES" : "NO") +
		" | ARMOR BONUS: " + string(_val_bonus_damage),
		"SCR_MINION_CAST_EFFECT"
	);

	//================//
	//DEAL NEU DAMAGE//
	//================//
	scr_battle_damage_target(
		"FIXED",
		_ref_minion,
		_ref_target,
		_val_damage
	);

break;

		//----------//
		//CINDERLING//
		//----------//
		case "CINDERLING":

			//----------------//
			//GET ENEMY TARGET//
			//----------------//
			var _ref_target = scr_minion_get_target(
				_list_enemy
			);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//================//
			//CALCULATE DAMAGE//
			//================//
			var _val_damage = _ref_minion._val_magnitude;

			//----------------//
			//DEBUG ACTION//
			//----------------//
			scr_debug_log_minion_action(
				_ref_minion,
				"ATTACKED",
				_ref_target,
				"NEU DAMAGE: " + string(_val_damage),
				"SCR_MINION_CAST_EFFECT"
			);

			//================//
			//DEAL NEU DAMAGE//
			//================//
			scr_battle_damage_target(
				"FIXED",
				_ref_minion,
				_ref_target,
				_val_damage
			);

		break;

		//-------------//
		//EMBER TURRET//
		//-------------//
		case "EMBER TURRET":

			//----------------//
			//GET ENEMY TARGET//
			//----------------//
			var _ref_target = scr_minion_get_target(
				_list_enemy
			);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//================//
			//CHECK BURN//
			//================//
			var _ref_burn = scr_status_check(
				"BURN",
				_ref_target
			);

			var _flag_burning = (
				_ref_burn != -1 &&
				instance_exists(_ref_burn) &&
				_ref_burn._ct_status_stacks > 0
			);

			//======================//
			//BURNING — DEAL DAMAGE//
			//======================//
			if (_flag_burning){

				var _val_damage =
					_ref_minion._val_magnitude *
					2;

				//----------------//
				//DEBUG ACTION//
				//----------------//
				scr_debug_log_minion_action(
					_ref_minion,
					"ATTACKED",
					_ref_target,
					"NEU DAMAGE: " + string(_val_damage) +
					" | TARGET BURNING: YES",
					"SCR_MINION_CAST_EFFECT"
				);

				//------------//
				//DEAL DAMAGE//
				//------------//
				scr_battle_damage_target(
					"FIXED",
					_ref_minion,
					_ref_target,
					_val_damage
				);
			}

			//=======================//
			//NOT BURNING — APPLY 1//
			//=======================//
			else{

				//----------------//
				//APPLY 1 BURN//
				//----------------//
				scr_status_apply_dot("BURN", _ref_target);


				//----------------//
				//DEBUG ACTION//
				//----------------//
				scr_debug_log_minion_action(
					_ref_minion,
					"APPLIED BURN",
					_ref_target,
					"BURN: +1 | TARGET BURNING: NO",
					"SCR_MINION_CAST_EFFECT"
				);
			}

		break;

		//--------//
		//TENTACLE//
		//--------//
		case "TENTACLE":

			//----------------//
			//GET RANDOM ENEMY//
			//----------------//
			var _ref_target = scr_minion_get_target(_list_enemy);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------//
			//CALCULATE DAMAGE//
			//----------------//
			var _val_damage = _ref_minion._val_magnitude;

			//----------------//
			//DEBUG ACTION//
			//----------------//
			scr_debug_log_minion_action(
				_ref_minion,
				"ATTACKED",
				_ref_target,
				"BASE DAMAGE: " + string(_val_damage),
				"SCR_MINION_CAST_EFFECT"
			);

			//------------//
			//DEAL DAMAGE//
			//------------//
			scr_battle_damage_target(
				"FIXED",
				_ref_minion,
				_ref_target,
				_val_damage
			);

		break;

		//----------------//
		//ABYSSAL HARPOON//
		//----------------//
		case "ABYSSAL HARPOON":

			//----------------------//
			//GET PREFERRED TARGET//
			//----------------------//
			var _ref_target = scr_minion_get_target(
				_list_enemy,
				undefined,
				"BACK_HALF"
			);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------//
			//CALCULATE DAMAGE//
			//----------------//
			var _val_damage =
				_ref_minion._val_magnitude *
				2;

			//----------------//
			//DEBUG ACTION//
			//----------------//
			scr_debug_log_minion_action(
				_ref_minion,
				"FIRED",
				_ref_target,
				"BASE DAMAGE: " + string(_val_damage) +
				" | PULL: FORWARD 1",
				"SCR_MINION_CAST_EFFECT"
			);

			//------------//
			//DEAL DAMAGE//
			//------------//
			scr_battle_damage_target(
				"FIXED",
				_ref_minion,
				_ref_target,
				_val_damage
			);

			//----------------//
			//PULL FORWARD 1//
			//----------------//
			if (
				instance_exists(_ref_target) &&
				_ref_target._str_list == "ALIVE" &&
				_ref_target._val_cur_hp > 0
			){

				scr_battle_reposition_beast(
					_ref_target,
					-1
				);
			}

		break;

		//--------------//
		//CORAL GUARDIAN//
		//--------------//
		case "CORAL GUARDIAN":

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"HOST"
			);

			//----------------//
			//CALCULATE ARMOR//
			//----------------//
			var _val_armor =
				_ref_minion._val_magnitude *
				2;

			//----------------//
			//DEBUG ACTION//
			//----------------//
			scr_debug_log_minion_action(
				_ref_minion,
				"DEFENDED",
				_ref_minion._ref_host,
				"ARMOR: " + string(_val_armor),
				"SCR_MINION_CAST_EFFECT"
			);

			//-----------//
			//GRANT ARMOR//
			//-----------//
			scr_battle_armor_target(
				"FIXED",
				_val_armor,
				_ref_minion._ref_host
			);


		break;

		//----------------------//
		//RIMEFROST ELEMENTAL//
		//----------------------//
		case "RIMEFROST ELEMENTAL":

			//------------------//
			//GET RANDOM ENEMY//
			//------------------//
			var _ref_frostbite_target = scr_minion_get_target(_list_enemy);

			if (!instance_exists(_ref_frostbite_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------//
			//DEBUG ACTION//
			//----------------//
			scr_debug_log_minion_action(
				_ref_minion,
				"CAST",
				_ref_frostbite_target,
				"FROSTBITE: +" + string(_ref_minion._val_magnitude),
				"SCR_MINION_CAST_EFFECT"
			);

			//----------------//
			//APPLY FROSTBITE//
			//----------------//
			repeat (_ref_minion._val_magnitude){
				scr_status_apply_dot("FROSTBITE", _ref_frostbite_target);
			}


		break;

		//----------//
		//STORM WISP//
		//----------//
		case "STORM WISP":

			//----------------//
			//GET RANDOM ENEMY//
			//----------------//
			var _ref_target = scr_minion_get_target(_list_enemy);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------//
			//CALCULATE DAMAGE//
			//----------------//
			var _val_damage =
				_ref_minion._val_magnitude *
				3;

			//----------------//
			//DEBUG ACTION//
			//----------------//
			scr_debug_log_minion_action(
				_ref_minion,
				"ATTACKED",
				_ref_target,
				"BASE DAMAGE: " + string(_val_damage),
				"SCR_MINION_CAST_EFFECT"
			);

			//------------//
			//DEAL DAMAGE//
			//------------//
			scr_battle_damage_target(
				"FIXED",
				_ref_minion,
				_ref_target,
				_val_damage
			);

			//============================//
			//FIND HIGHEST STORMSTRUCK//
			//============================//
			var _ct_highest_stormstruck = -1;
			var _arr_stormstruck_targets = [];

			for (var _it_enemy = 0;_it_enemy < ds_list_size(_list_enemy);_it_enemy++){

				var _ref_enemy = ds_list_find_value(
					_list_enemy,
					_it_enemy
				);

				if (!instance_exists(_ref_enemy)){
					continue;
				}

				if (
					_ref_enemy._str_list != "ALIVE" ||
					_ref_enemy._val_cur_hp <= 0
				){
					continue;
				}

				//----------------//
				//GET STORMSTRUCK//
				//----------------//
				var _ct_stormstruck = 0;
				var _ref_stormstruck = scr_status_check(
					"STORMSTRUCK",
					_ref_enemy
				);

				if (
					_ref_stormstruck != -1 &&
					instance_exists(_ref_stormstruck)
				){
					_ct_stormstruck = _ref_stormstruck._ct_status_stacks;
				}

				//----------------//
				//NEW HIGHEST//
				//----------------//
				if (_ct_stormstruck > _ct_highest_stormstruck){

					_ct_highest_stormstruck = _ct_stormstruck;
					_arr_stormstruck_targets = [_ref_enemy];

					continue;
				}

				//----------------//
				//TIED HIGHEST//
				//----------------//
				if (_ct_stormstruck == _ct_highest_stormstruck){
					array_push(_arr_stormstruck_targets,_ref_enemy);
				}
			}

			//===================//
			//APPLY STORMSTRUCK//
			//===================//
			if (array_length(_arr_stormstruck_targets) > 0){

				var _ref_stormstruck_target =
					_arr_stormstruck_targets[
						irandom(array_length(_arr_stormstruck_targets) - 1)
					];

				//----------------//
				//APPLY 1 STACK//
				//----------------//
				var _ref_applied_stormstruck =
					scr_status_apply_dot("STORMSTRUCK", _ref_stormstruck_target);


				//----------------//
				//DEBUG ACTION//
				//----------------//
				if (instance_exists(_ref_applied_stormstruck)){

					scr_debug_log_minion_action(
						_ref_minion,
						"APPLIED STORMSTRUCK",
						_ref_stormstruck_target,
						"HIGHEST EXISTING STORMSTRUCK: " +
						string(_ct_highest_stormstruck),
						"SCR_MINION_CAST_EFFECT"
					);
				}
			}

		break;

		//-----//
		//FUNGI//
		//-----//
		case "FUNGI":

			if (_str_minion_team != "PLAYER"){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"HOST"
			);

			//----------------//
			//CALCULATE DRAW//
			//----------------//
			var _ct_draw =
				1 +
				floor(
					_ref_minion._val_max_hp /
					5
				);

			//----------------//
			//DEBUG ACTION//
			//----------------//
			scr_debug_log_minion_action(
				_ref_minion,
				"DREW CARDS",
				_ref_minion._ref_host,
				"CARDS: " + string(_ct_draw),
				"SCR_MINION_CAST_EFFECT"
			);

			//-----------//
			//DRAW CARDS//
			//-----------//
			scr_battle_draw_cards(_ct_draw);

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"+" + string(_ct_draw) + " CARD DRAW",
				undefined,
				c_green,
				_ref_minion.x,
				_ref_minion.y - 24
			);

		break;

		//-------------//
		//GROVE SPIRIT//
		//-------------//
		case "GROVE SPIRIT":

			//----------------//
			//MINION CAST VFX//
			//----------------//
			if (
				_ref_minion._val_max_hp >= 10 &&
				ds_list_size(_list_enemy) > 0
			){

				scr_battle_vfx_minion_cast(
					_ref_minion,
					"ENEMY"
				);
			}
			else{

				scr_battle_vfx_minion_cast(
					_ref_minion,
					"HOST"
				);
			}

			//-------------------//
			//CALCULATE HEALING//
			//-------------------//
			/*
				Starts at 3 healing with Magnitude 1.
				Each +1 Magnitude adds +1 healing.
			*/
			var _val_healing =
				2 +
				_ref_minion._val_magnitude;

			var _flag_attack_unlocked = (_ref_minion._val_max_hp >= 10);
			var _flag_stun_unlocked = (_ref_minion._val_max_hp >= 20);

			//----------------//
			//DEBUG ACTION//
			//----------------//
			scr_debug_log_minion_action(
				_ref_minion,
				"ACTED",
				_ref_minion._ref_host,
				"HEAL: " + string(_val_healing) +
				" | ATTACK UNLOCKED: " + (_flag_attack_unlocked ? "YES" : "NO") +
				" | STUN UNLOCKED: " + (_flag_stun_unlocked ? "YES" : "NO"),
				"SCR_MINION_CAST_EFFECT"
			);

			//---------//
			//HEAL HOST//
			//---------//
			scr_battle_heal_target(
				"FIXED",
				_val_healing,
				_ref_minion._ref_host
			);

			//================================//
			//10 MAX HP — UNLOCK ATTACK//
			//================================//
			if (
				_ref_minion._val_max_hp >= 10 &&
				ds_list_size(_list_enemy) > 0
			){

				//----------------//
				//GET FRONT ENEMY//
				//----------------//
				var _ref_attack_target = ds_list_find_value(
					_list_enemy,
					0
				);

				if (
					instance_exists(_ref_attack_target) &&
					_ref_attack_target._str_list == "ALIVE" &&
					_ref_attack_target._val_cur_hp > 0
				){

					//------------//
					//DEAL DAMAGE//
					//------------//
					var _val_damage = _ref_minion._val_magnitude;

					scr_battle_damage_target(
						"FIXED",
						_ref_minion,
						_ref_target,
						_val_damage
					);

					//============================//
					//20 MAX HP — UNLOCK STUN//
					//============================//
					if (
						_ref_minion._val_max_hp >= 20 &&
						instance_exists(_ref_attack_target) &&
						_ref_attack_target._val_cur_hp > 0
					){

						//-----------//
						//APPLY STUN//
						//-----------//
						scr_status_apply_cc("STUN", _ref_attack_target, 1);

					}
				}
			}

		break;

		//------------//
		//WASP DRONE//
		//------------//
		case "WASP DRONE":

			//-------------------//
			//GET DAMAGE TARGET//
			//-------------------//
			var _ref_damage_target = scr_minion_get_target(_list_enemy);

			if (!instance_exists(_ref_damage_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------//
			//CALCULATE DAMAGE//
			//----------------//
			var _val_damage = _ref_minion._val_magnitude;

			//------------//
			//DEAL DAMAGE//
			//------------//
			scr_battle_damage_target(
				"FIXED",
				_ref_minion,
				_ref_target,
				_val_damage
			);

			//----------------------//
			//GET WEAKNESS TARGET//
			//----------------------//
			var _ref_weakness_target = scr_minion_get_target(
				_list_enemy,
				_ref_damage_target
			);

			//--------------------------------//
			//FALL BACK TO SAME ENEMY IF ALONE//
			//--------------------------------//
			if (
				!instance_exists(_ref_weakness_target) &&
				instance_exists(_ref_damage_target) &&
				_ref_damage_target._str_list == "ALIVE" &&
				_ref_damage_target._val_cur_hp > 0
			){
				_ref_weakness_target = _ref_damage_target;
			}

			//----------------------//
			//GET WEAKNESS NAME//
			//----------------------//
			var _str_weakness_target = "NONE";

			if (
				instance_exists(_ref_weakness_target) &&
				is_struct(_ref_weakness_target._ref_unit)
			){
				_str_weakness_target = string_upper(
					_ref_weakness_target._ref_unit._str_beast_name
				);
			}

			//----------------//
			//DEBUG ACTION//
			//----------------//
			scr_debug_log_minion_action(
				_ref_minion,
				"ATTACKED",
				_ref_damage_target,
				"BASE DAMAGE: " + string(_val_damage) +
				" | WEAKNESS TARGET: " + _str_weakness_target,
				"SCR_MINION_CAST_EFFECT"
			);

			//----------------//
			//APPLY WEAKNESS//
			//----------------//
			if (instance_exists(_ref_weakness_target)){

				scr_status_apply_debuff("WEAKNESS", _ref_weakness_target, 1);

			}

		break;

		//-----------//
		//SPORELING//
		//-----------//
		case "SPORELING":

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"HOST"
			);

			//----------------//
			//DEBUG ACTION//
			//----------------//
			scr_debug_log_minion_action(
				_ref_minion,
				"CAST",
				_ref_minion._ref_host,
				"POISON: +" + string(_ref_minion._val_magnitude),
				"SCR_MINION_CAST_EFFECT"
			);


			//--------------//
			//POISON HOST//
			//--------------//

			repeat (_ref_minion._val_magnitude){
				scr_status_apply_dot("POISON", _ref_minion._ref_host);
			}


		break;

		//--------//
		//SERPENT//
		//--------//
		case "SERPENT":

			//----------------//
			//GET ENEMY TARGET//
			//----------------//
			var _ref_target = scr_minion_get_target(_list_enemy);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------//
			//DEBUG ACTION//
			//----------------//
			scr_debug_log_minion_action(
				_ref_minion,
				"CAST",
				_ref_target,
				"VENOM: +" + string(_ref_minion._val_magnitude),
				"SCR_MINION_CAST_EFFECT"
			);


			//-------------//
			//APPLY VENOM//
			//-------------//

			repeat (_ref_minion._val_magnitude){
				scr_status_apply_dot("VENOM", _ref_target);
			}


		break;

		//--------------//
		//DORMANT SEED//
		//--------------//
		case "DORMANT SEED":

			/*
				Dormant Seed intentionally has no cast motion.
				Its visible feedback comes from the Hatch/Spawn VFX
				when it transforms into another Minion.
			*/

			_ref_minion._ct_age++;

			if (_ref_minion._ct_age >= 2){

				scr_debug_log_minion_action(
					_ref_minion,
					"HATCHING",
					_ref_minion._ref_host,
					"AGE: " + string(_ref_minion._ct_age),
					"SCR_MINION_CAST_EFFECT"
				);

				scr_minion_hatch_dormant_seed(_ref_minion);
			}

		break;

		//----------//
		//THORNLING//
		//----------//
		case "THORNLING":

			//----------------//
			//GET ENEMY TARGET//
			//----------------//
			var _ref_target = scr_minion_get_target(_list_enemy);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"ENEMY"
			);

			//----------------//
			//CALCULATE DAMAGE//
			//----------------//
			var _val_damage =
				_ref_minion._val_magnitude *
				2;

			//----------------//
			//DEBUG ACTION//
			//----------------//
			scr_debug_log_minion_action(
				_ref_minion,
				"ATTACKED",
				_ref_target,
				"BASE DAMAGE: " + string(_val_damage),
				"SCR_MINION_CAST_EFFECT"
			);

			//------------//
			//DEAL DAMAGE//
			//------------//
			scr_battle_damage_target(
				"FIXED",
				_ref_minion,
				_ref_target,
				_val_damage
			);
		break;

		//-------------//
		//LIFE SPIRIT//
		//-------------//
		case "LIFE SPIRIT":

			//----------------//
			//MINION CAST VFX//
			//----------------//
			scr_battle_vfx_minion_cast(
				_ref_minion,
				"HOST"
			);

			//-----------------//
			//CALCULATE HEALING//
			//-----------------//
			var _val_healing =
				_ref_minion._val_magnitude *
				2;

			//----------------//
			//DEBUG ACTION//
			//----------------//
			scr_debug_log_minion_action(
				_ref_minion,
				"HEALED",
				_ref_minion._ref_host,
				"BASE HEAL: " + string(_val_healing),
				"SCR_MINION_CAST_EFFECT"
			);

			//---------//
			//HEAL HOST//
			//---------//
			scr_battle_heal_target(
				"FIXED",
				_val_healing,
				_ref_minion._ref_host
			);

		break;
	}
}