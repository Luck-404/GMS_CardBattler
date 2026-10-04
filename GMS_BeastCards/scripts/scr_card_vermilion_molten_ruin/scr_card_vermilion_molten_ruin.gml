//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_MOLTEN_RUIN
// FUNCTION: Resolves Molten Ruin's Armor-only MAG Attack over a snapshot of
//           opposing Beasts.
//
//           Preserves Molten Ruin's bespoke:
//           - Team snapshot.
//           - Dodge.
//           - Divine Protection.
//           - Armor-only damage.
//           - No spill into Overhealth / HP.
//           - 2 Char application.
//           - Vermilion Minion summon on Armor break.
//
//           Damage calculation follows the standard Card-damage order:
//
//           Base
//           -> Heatwave
//           -> Critical Hit
//           -> outgoing/incoming scalar modifiers
//           -> MAGPOW
//           -> Molten Brand
//           -> outgoing/incoming Linear modifiers
//           -> MAGDEF mitigation
//           -> final rounding
//
//           Linear modifiers therefore do not receive percentage or Power
//           scaling.
//
// ARGUMENTS: _stct_card - Molten Ruin Card struct.
//            _ref_caster - attacking Beast.
//            _ref_target - opposing-team selector.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_molten_ruin(_stct_card,_ref_caster,_ref_target){

	#region VALIDATION

	//================//
	//VALIDATE CASTER//
	//================//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!is_struct(_ref_caster._ref_unit)){
		return;
	}

	//================//
	//GET TARGET TEAM//
	//================//
	var _list_targets =
		scr_battle_get_target_team_list(
			_ref_target
		);

	if (
		_list_targets == undefined ||
		!ds_exists(_list_targets,ds_type_list)
	){
		return;
	}

	#endregion

	#region TARGET SNAPSHOT

	//================//
	//SNAPSHOT TEAM//
	//================//
	var _arr_targets = [];

	for (
		var _it_target = 0;
		_it_target < ds_list_size(_list_targets);
		_it_target++
	){

		var _ref_beast =
			ds_list_find_value(
				_list_targets,
				_it_target
			);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (
			_ref_beast._str_list != "ALIVE" ||
			_ref_beast._val_cur_hp <= 0
		){
			continue;
		}

		array_push(
			_arr_targets,
			_ref_beast
		);
	}

	#endregion

	#region MOLTEN RUIN

	//================//
	//PROCESS TEAM//
	//================//
	for (
		var _it_target = 0;
		_it_target < array_length(_arr_targets);
		_it_target++
	){

		var _ref_beast =
			_arr_targets[_it_target];

		//================//
		//VALIDATE BEAST//
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

		if (!is_struct(_ref_beast._ref_unit)){
			continue;
		}

		//================//
		//ARMOR BREAK FLAG//
		//================//
		var _flag_armor_broken = false;

		//================//
		//GET ARMOR//
		//================//
		var _val_armor_before =
			max(
				0,
				_ref_beast._val_armor
			);

		#region ARMOR DAMAGE

		//=======================//
		//ARMOR-ONLY DAMAGE//
		//=======================//
		if (_val_armor_before > 0){

			var _flag_hit_allowed = true;

			//================//
			//CHECK DODGE//
			//================//
			var _val_dodge =
				scr_battle_get_effective_dodge(
					_ref_caster,
					_ref_beast
				);

			if (
				irandom_range(1,100) <=
				_val_dodge
			){

				_flag_hit_allowed = false;

				scr_battle_vfx_dodge(
					_ref_beast
				);

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"DODGED",
					undefined,
					c_white,
					_ref_beast.x,
					_ref_beast.y - 48
				);
			}

			//======================//
			//DIVINE PROTECTION//
			//======================//
			if (_flag_hit_allowed){

				if (
					scr_status_trigger_divine_protection(
						_ref_beast
					)
				){
					_flag_hit_allowed = false;
				}
			}

			//================//
			//RESOLVE DAMAGE//
			//================//
			if (_flag_hit_allowed){

				//================//
				//BASE DAMAGE//
				//================//
				var _val_damage =
					max(
						0,
						_stct_card._val_card_magnitude
					);

				//========================//
				//HEATWAVE DAMAGE BONUS//
				//========================//
				_val_damage *=
					scr_status_get_heatwave_damage_multiplier(
						_stct_card
					);

				//================//
				//CRITICAL HIT//
				//================//
				var _flag_critical =
					(
						irandom_range(1,100) <=
						clamp(
							_ref_caster._val_crit_chance,
							0,
							100
						)
					);

				if (_flag_critical){

					_val_damage *=
						1 +
						(
							max(
								0,
								_ref_caster._val_crit_damage
							) /
							100
						);

					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"CRIT",
						undefined,
						c_maroon,
						_ref_beast.x,
						_ref_beast.y - 48
					);
				}

				//================//
				//SCALAR MODIFIERS//
				//================//
				var _val_outgoing_scalar =
					_ref_caster._val_dmg_scalar_bonus -
					_ref_caster._val_dmg_scalar_reduction;

				var _val_incoming_scalar =
					_ref_beast._val_dmg_taken_scalar_bonus -
					_ref_beast._val_dmg_taken_scalar_reduction;

				_val_damage *=
					max(
						0,
						1 +
						(_val_outgoing_scalar / 100)
					);

				_val_damage *=
					max(
						0,
						1 +
						(_val_incoming_scalar / 100)
					);

				//================//
				//MAGPOW SCALING//
				//================//
				var _val_magpow_multiplier =
					scr_beast_get_power_multiplier(
						_ref_caster
							._ref_unit
							._val_beast_mpow_stat
					);

				_val_damage *=
					_val_magpow_multiplier;

				//============================//
				//MOLTEN BRAND DAMAGE BONUS//
				//============================//
				var _val_molten_brand_bonus =
					scr_status_get_molten_brand_damage_bonus(
						_ref_beast,
						_stct_card
					);

				if (_val_molten_brand_bonus > 0){

					_val_damage *=
						1 +
						(
							_val_molten_brand_bonus /
							100
						);
				}

				//================//
				//LINEAR MODIFIERS//
				//================//
				var _val_outgoing_linear =
					_ref_caster._val_dmg_linear_bonus -
					_ref_caster._val_dmg_linear_reduction;

				var _val_incoming_linear =
					_ref_beast._val_dmg_taken_linear_bonus -
					_ref_beast._val_dmg_taken_linear_reduction;

				_val_damage +=
					_val_outgoing_linear +
					_val_incoming_linear;

				//================//
				//DAMAGE FLOOR//
				//================//
				if (_val_damage <= 0){
					continue;
				}

				//================//
				//MAGDEF MITIGATION//
				//================//
				var _val_magdef_mitigation =
					scr_beast_get_defense_mitigation(
						_ref_beast
							._ref_unit
							._val_beast_mdef_stat
					);

				_val_damage *=
					1 -
					_val_magdef_mitigation;

				//================//
				//FINALIZE DAMAGE//
				//================//
				_val_damage =
					max(
						0,
						ceil(_val_damage)
					);

				//======================//
				//CAP DAMAGE TO ARMOR//
				//======================//
				var _val_armor_destroyed =
					min(
						_val_armor_before,
						_val_damage
					);

				//================//
				//DAMAGE ARMOR//
				//================//
				if (_val_armor_destroyed > 0){

					var _stct_armor_result =
						scr_battle_destroy_armor(
							_ref_beast,
							_val_armor_destroyed
						);

					_val_armor_destroyed =
						_stct_armor_result
							._val_armor_removed;

					//================//
					//DAMAGE FEEDBACK//
					//================//
					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"-" +
						string(_val_armor_destroyed) +
						" ARMOR",
						undefined,
						c_blue,
						_ref_beast.x,
						_ref_beast.y - 24
					);

					//================//
					//MAG HIT VFX//
					//================//
					scr_battle_vfx_damage_hit(
						_ref_beast,
						"MAG",
						_val_armor_destroyed
					);

					//================//
					//CHECK ARMOR BREAK//
					//================//
					if (
						_stct_armor_result
							._flag_armor_broken
					){

						_flag_armor_broken = true;

						//================//
						//ARMOR BREAK VFX//
						//================//
						scr_battle_vfx(
							_ref_beast,
							spr_battle_vfx_armor_break,
							undefined,
							undefined,
							4,
							4,
							1,
							0,
							snd_battle_armor_break
						);
					}
				}
			}
		}

		#endregion

		#region CHAR

		//================//
		//CHECK SURVIVAL//
		//================//
		if (
			instance_exists(_ref_beast) &&
			_ref_beast._str_list == "ALIVE" &&
			_ref_beast._val_cur_hp > 0
		){

			//================//
			//APPLY 2 CHAR//
			//================//
			repeat (2){

				scr_status_apply_debuff(
					"CHAR",
					_ref_beast
				);
			}
		}

		#endregion

	//================//
	//VALIDATE POOL//
	//================//
	if (
		!variable_global_exists("arr_pool_vermilion_minions") ||
		!is_array(global.arr_pool_vermilion_minions)
	){
		continue;
	}

	var _ct_pool_size =
		array_length(
			global.arr_pool_vermilion_minions
		);

	if (_ct_pool_size <= 0){
		continue;
	}

	//================//
	//SELECT MINION//
	//================//
	var _it_minion =
		irandom(
			_ct_pool_size - 1
		);

	var _str_minion_id =
		global.arr_pool_vermilion_minions[
			_it_minion
		];

	//================//
	//SUMMON ON CASTER//
	//================//
	scr_minion_init(
		_str_minion_id,
		_stct_card,
		_ref_caster,
		_ref_caster
	);
	}

	#endregion
}