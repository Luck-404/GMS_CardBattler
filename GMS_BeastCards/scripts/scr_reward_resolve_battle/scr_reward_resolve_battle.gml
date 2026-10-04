//===============================================================================//
//
// SCRIPT: SCR_REWARD_RESOLVE_BATTLE
// FUNCTION: Resolves all rewards for a completed victorious battle.
//
//           GUARANTEED:
//           - Gold.
//           - EXP for surviving Party Beasts.
//           - At least 1 Material when a valid Material source exists.
//           - Each Salvager's Magnet adds +1 guaranteed Material.
//
//           OPTIONAL:
//           - Second Material from Zone pool: 50% base.
//           - Beast Card: 30% base.
//           - Zone Card: 30% base.
//           - Egg: 10% base.
//           - Beast/Zone normal Item: 10% base.
//           - Applicable RESOURCE Held Items can increase these normal optional
//             reward chances. Lucky Coin adds +5 percentage points to all five.
//           - Secret Zone Item: 1%.
//
//           GLOBAL BONUS:
//           - 5% Card roll from the complete global Card pool.
//           - Independent from Beast and Zone pools.
//
//           Battle Score improves normal optional reward chances and Gold,
//           but does not modify Secret Item or Global Bonus Card chances.
//
// ARGUMENTS: _ref_player_controller - Player battle controller.
//            _ref_enemy_controller - Enemy battle controller.
//            _val_elapsed_seconds - Gameplay duration.
//            _ct_rounds - Round reached when battle ended.
// RETURNS: Complete battle reward result struct.
//
//===============================================================================//

function scr_reward_resolve_battle(
	_ref_player_controller,
	_ref_enemy_controller,
	_val_elapsed_seconds,
	_ct_rounds
){

	#region VARIABLES

	var _arr_rewards = [];

	var _arr_enemy_units = [];

	var _arr_egg_candidates = [];
	var _arr_beast_material_candidates = [];
	var _arr_bonus_item_candidates = [];

	var _str_loot_zone_id =
		"UNASSIGNED";

	var _stct_config =
		scr_reward_get_battle_roll_config();

	var _stct_grade =
		scr_reward_calculate_battle_grade(
			_ref_player_controller,
			_ref_enemy_controller,
			_val_elapsed_seconds
		);

	//======================//
	//BATTLE SCORE DROP BONUS//
	//======================//
	var _val_grade_chance_bonus =
		_stct_grade._val_optional_chance_bonus;

	var _val_egg_chance =
		min(
			100,
			_stct_config._val_egg_chance +
			_val_grade_chance_bonus
		);

	var _val_zone_material_chance =
		min(
			100,
			_stct_config._val_zone_material_chance +
			_val_grade_chance_bonus
		);

	var _val_beast_card_chance =
		min(
			100,
			_stct_config._val_beast_card_chance +
			_val_grade_chance_bonus
		);

	var _val_zone_card_chance =
		min(
			100,
			_stct_config._val_zone_card_chance +
			_val_grade_chance_bonus
		);

	var _val_bonus_item_chance =
		min(
			100,
			_stct_config._val_bonus_item_chance +
			_val_grade_chance_bonus
		);

	#endregion

	#region VALIDATION

	if (
		!instance_exists(
			_ref_player_controller
		) ||
		!instance_exists(
			_ref_enemy_controller
		)
	){

		return {
			_flag_success : false,
			_stct_grade : _stct_grade,
			_arr_rewards : _arr_rewards,
			_val_gold_base : 0,
			_val_gold_reward : 0,
			_val_gold_item_bonus : 0,
			_val_gold_level_bonus_per_level :
				_stct_config
					._val_gold_level_bonus_per_level,
			_ct_exp_each : 0,
			_ct_exp_recipients : 0,
			_ct_rounds : _ct_rounds,
			_str_loot_zone_id : _str_loot_zone_id
		};
	}

	if (
		!ds_exists(
			_ref_enemy_controller._list_beasts,
			ds_type_list
		) ||
		!ds_exists(
			_ref_player_controller._list_beasts,
			ds_type_list
		)
	){

		return {
			_flag_success : false,
			_stct_grade : _stct_grade,
			_arr_rewards : _arr_rewards,
			_val_gold_base : 0,
			_val_gold_reward : 0,
			_val_gold_item_bonus : 0,
			_val_gold_level_bonus_per_level :
				_stct_config
					._val_gold_level_bonus_per_level,
			_ct_exp_each : 0,
			_ct_exp_recipients : 0,
			_ct_rounds : _ct_rounds,
			_str_loot_zone_id : _str_loot_zone_id
		};
	}

	#endregion

	#region RESOURCE HELD ITEM MODIFIERS

	var _val_beast_card_item_bonus = 0;
	var _val_zone_card_item_bonus = 0;
	var _val_bonus_item_item_bonus = 0;
	var _val_all_optional_item_bonus = 0;
	var _ct_guaranteed_material_item_bonus = 0;

	//========================//
	//COLLECT RESOURCE BONUSES//
	//========================//
	for (
		var _it_resource_beast = 0;
		_it_resource_beast <
			ds_list_size(
				_ref_player_controller
					._list_beasts
			);
		_it_resource_beast++
	){

		var _ref_resource_beast =
			ds_list_find_value(
				_ref_player_controller
					._list_beasts,
				_it_resource_beast
			);

		if (!instance_exists(_ref_resource_beast)){
			continue;
		}

		var _stct_resource_item =
			_ref_resource_beast
				._stct_held_item;

		if (
			_stct_resource_item == undefined ||
			_stct_resource_item == "EMPTY" ||
			!is_struct(_stct_resource_item)
		){
			continue;
		}

		if (
			!variable_struct_exists(
				_stct_resource_item,
				"_str_item_trigger_type"
			) ||
			string_upper(
				string(
					_stct_resource_item
						._str_item_trigger_type
				)
			) !=
			"RESOURCE"
		){
			continue;
		}

		if (
			!variable_struct_exists(
				_stct_resource_item,
				"_scr_item"
			) ||
			_stct_resource_item._scr_item ==
				undefined
		){
			continue;
		}

		var _stct_resource_bonus =
			script_execute(
				_stct_resource_item._scr_item,
				"TRIGGER",
				_stct_resource_item
			);

		if (!is_struct(_stct_resource_bonus)){
			continue;
		}

		var _val_item_beast_card_bonus = 0;
		var _val_item_zone_card_bonus = 0;
		var _val_item_bonus_item_bonus = 0;
		var _val_item_all_optional_bonus = 0;
		var _ct_item_guaranteed_material_bonus = 0;

		if (
			variable_struct_exists(
				_stct_resource_bonus,
				"_val_beast_card_chance_bonus"
			) &&
			is_real(
				_stct_resource_bonus
					._val_beast_card_chance_bonus
			)
		){

			_val_item_beast_card_bonus =
				max(
					0,
					_stct_resource_bonus
						._val_beast_card_chance_bonus
				);
		}

		if (
			variable_struct_exists(
				_stct_resource_bonus,
				"_val_zone_card_chance_bonus"
			) &&
			is_real(
				_stct_resource_bonus
					._val_zone_card_chance_bonus
			)
		){

			_val_item_zone_card_bonus =
				max(
					0,
					_stct_resource_bonus
						._val_zone_card_chance_bonus
				);
		}

		if (
			variable_struct_exists(
				_stct_resource_bonus,
				"_val_bonus_item_chance_bonus"
			) &&
			is_real(
				_stct_resource_bonus
					._val_bonus_item_chance_bonus
			)
		){

			_val_item_bonus_item_bonus =
				max(
					0,
					_stct_resource_bonus
						._val_bonus_item_chance_bonus
				);
		}

		if (
			variable_struct_exists(
				_stct_resource_bonus,
				"_val_all_optional_chance_bonus"
			) &&
			is_real(
				_stct_resource_bonus
					._val_all_optional_chance_bonus
			)
		){

			_val_item_all_optional_bonus =
				max(
					0,
					_stct_resource_bonus
						._val_all_optional_chance_bonus
				);
		}

		if (
			variable_struct_exists(
				_stct_resource_bonus,
				"_ct_guaranteed_material_bonus"
			) &&
			is_real(
				_stct_resource_bonus
					._ct_guaranteed_material_bonus
			)
		){

			_ct_item_guaranteed_material_bonus =
				max(
					0,
					floor(
						_stct_resource_bonus
							._ct_guaranteed_material_bonus
					)
				);
		}

		_val_beast_card_item_bonus +=
			_val_item_beast_card_bonus;

		_val_zone_card_item_bonus +=
			_val_item_zone_card_bonus;

		_val_bonus_item_item_bonus +=
			_val_item_bonus_item_bonus;

		_val_all_optional_item_bonus +=
			_val_item_all_optional_bonus;

		_ct_guaranteed_material_item_bonus +=
			_ct_item_guaranteed_material_bonus;

		//---------------------//
		//OPTIONAL REWARD BANNER//
		//---------------------//
		if (
			_val_item_all_optional_bonus > 0
		){

			scr_gui_spawn_popup_trigger_banner(
				_stct_resource_item._str_item_name +
				" +" +
				string(
					round(
						_val_item_all_optional_bonus
					)
				) +
				"% OPTIONAL REWARDS",
				_stct_resource_item._spr_item
			);
		}

		//----------------//
		//CARD BONUS BANNER//
		//----------------//
		if (
			_val_item_beast_card_bonus > 0 ||
			_val_item_zone_card_bonus > 0
		){

			var _val_display_card_bonus =
				max(
					_val_item_beast_card_bonus,
					_val_item_zone_card_bonus
				);

			scr_gui_spawn_popup_trigger_banner(
				_stct_resource_item._str_item_name +
				" +" +
				string(
					round(
						_val_display_card_bonus
					)
				) +
				"% CARD CHANCE",
				_stct_resource_item._spr_item
			);
		}

		//----------------//
		//ITEM BONUS BANNER//
		//----------------//
		if (
			_val_item_bonus_item_bonus > 0
		){

			scr_gui_spawn_popup_trigger_banner(
				_stct_resource_item._str_item_name +
				" +" +
				string(
					round(
						_val_item_bonus_item_bonus
					)
				) +
				"% ITEM CHANCE",
				_stct_resource_item._spr_item
			);
		}

		//--------------------//
		//MATERIAL BONUS BANNER//
		//--------------------//
		if (
			_ct_item_guaranteed_material_bonus > 0
		){

			scr_gui_spawn_popup_trigger_banner(
				_stct_resource_item._str_item_name +
				" +" +
				string(
					_ct_item_guaranteed_material_bonus
				) +
				" MATERIAL",
				_stct_resource_item._spr_item
			);
		}
	}

	//======================//
	//APPLY RESOURCE BONUSES//
	//======================//
	_val_egg_chance =
		min(
			100,
			_val_egg_chance +
			_val_all_optional_item_bonus
		);

	_val_zone_material_chance =
		min(
			100,
			_val_zone_material_chance +
			_val_all_optional_item_bonus
		);

	_val_beast_card_chance =
		min(
			100,
			_val_beast_card_chance +
			_val_beast_card_item_bonus +
			_val_all_optional_item_bonus
		);

	_val_zone_card_chance =
		min(
			100,
			_val_zone_card_chance +
			_val_zone_card_item_bonus +
			_val_all_optional_item_bonus
		);

	_val_bonus_item_chance =
		min(
			100,
			_val_bonus_item_chance +
			_val_bonus_item_item_bonus +
			_val_all_optional_item_bonus
		);

	#endregion

	#region COLLECT ENEMY SOURCES

	var _val_gold_base = 0;

	for (
		var _it_enemy = 0;
		_it_enemy <
			ds_list_size(
				_ref_enemy_controller._list_beasts
			);
		_it_enemy++
	){

		var _ref_enemy =
			ds_list_find_value(
				_ref_enemy_controller._list_beasts,
				_it_enemy
			);

		if (!instance_exists(_ref_enemy)){
			continue;
		}

		if (!is_struct(_ref_enemy._ref_unit)){
			continue;
		}

		var _stct_enemy_unit =
			_ref_enemy._ref_unit;

		array_push(
			_arr_enemy_units,
			_stct_enemy_unit
		);

		var _str_beast_name =
			string_upper(
				string(
					_stct_enemy_unit
						._str_beast_name
				)
			);

		//================//
		//GET BEAST LEVEL//
		//================//
		var _val_beast_level = 1;

		if (
			variable_struct_exists(
				_stct_enemy_unit,
				"_val_beast_level"
			)
		){

			_val_beast_level =
				max(
					1,
					round(
						_stct_enemy_unit
							._val_beast_level
					)
				);
		}

		//=======================//
		//LEVEL GOLD MULTIPLIER//
		//=======================//
		var _val_gold_level_multiplier =
			1 +
			(
				(_val_beast_level - 1) *
				_stct_config
					._val_gold_level_bonus_per_level
			);

		var _stct_loot =
			scr_reward_get_beast_loot_info(
				_str_beast_name
			);

		//================//
		//FALLBACK GOLD//
		//================//
		if (!is_struct(_stct_loot)){

			var _val_gold_roll_base =
				irandom_range(
					5,
					8
				);

			var _val_gold_roll_scaled =
				ceil(
					_val_gold_roll_base *
					_val_gold_level_multiplier
				);

			_val_gold_base +=
				_val_gold_roll_scaled;

			scr_debug_log(
				"REWARD",
				"BEAST_LOOT",
				_ref_enemy,
				"MISSING BEAST LOOT INFO" +
				" | BEAST: " +
				_str_beast_name +
				" | LEVEL: " +
				string(
					_val_beast_level
				) +
				" | FALLBACK BASE GOLD: " +
				string(
					_val_gold_roll_base
				) +
				" | LEVEL MULTIPLIER: x" +
				string_format(
					_val_gold_level_multiplier,
					0,
					2
				) +
				" | SCALED GOLD: " +
				string(
					_val_gold_roll_scaled
				),
				"WARNING",
				"SCR_REWARD_RESOLVE_BATTLE"
			);

			continue;
		}

		//------//
		//GOLD//
		//------//
		var _val_gold_roll_base =
			irandom_range(
				min(
					_stct_loot._val_gold_min,
					_stct_loot._val_gold_max
				),
				max(
					_stct_loot._val_gold_min,
					_stct_loot._val_gold_max
				)
			);

		var _val_gold_roll_scaled =
			ceil(
				_val_gold_roll_base *
					_val_gold_level_multiplier
			);

		_val_gold_base +=
			_val_gold_roll_scaled;

		scr_debug_log(
			"REWARD",
			"GOLD",
			_ref_enemy,
			"BEAST GOLD" +
			" | BEAST: " +
			_str_beast_name +
			" | LEVEL: " +
			string(
				_val_beast_level
			) +
			" | BASE ROLL: " +
			string(
				_val_gold_roll_base
			) +
			" | LEVEL BONUS: +" +
			string(
				round(
					(_val_gold_level_multiplier - 1) *
					100
				)
			) +
			"%" +
			" | SCALED: " +
			string(
				_val_gold_roll_scaled
			),
			"REWARD",
			"SCR_REWARD_RESOLVE_BATTLE"
		);

		//----//
		//EGG//
		//----//
		if (
			_stct_loot._str_egg_item_id !=
				undefined &&
			string(
				_stct_loot._str_egg_item_id
			) !=
				""
		){

			array_push(
				_arr_egg_candidates,
				{
					_str_item_id :
						_stct_loot
							._str_egg_item_id,

					_str_source_detail :
						_str_beast_name
				}
			);
		}

		//---------//
		//MATERIAL//
		//---------//
		if (
			is_array(
				_stct_loot._arr_material_pool
			)
		){

			for (
				var _it_material = 0;
				_it_material <
					array_length(
						_stct_loot
							._arr_material_pool
					);
				_it_material++
			){

				array_push(
					_arr_beast_material_candidates,
					{
						_str_item_id :
							_stct_loot
								._arr_material_pool[
									_it_material
								],

						_str_source_detail :
							_str_beast_name
					}
				);
			}
		}

		//----------//
		//BONUS ITEM//
		//----------//
		if (
			is_array(
				_stct_loot._arr_bonus_item_pool
			)
		){

			for (
				var _it_item = 0;
				_it_item <
					array_length(
						_stct_loot
							._arr_bonus_item_pool
					);
				_it_item++
			){

				array_push(
					_arr_bonus_item_candidates,
					{
						_str_item_id :
							_stct_loot
								._arr_bonus_item_pool[
									_it_item
								],

						_str_source :
							"BEAST_ITEM",

						_str_source_detail :
							_str_beast_name
					}
				);
			}
		}
	}

	#endregion

	#region ZONE SOURCE

	if (
		variable_global_exists(
			"str_last_loot_zone_id"
		) &&
		is_string(
			global.str_last_loot_zone_id
		) &&
		global.str_last_loot_zone_id !=
			""
	){

		_str_loot_zone_id =
			string_upper(
				global.str_last_loot_zone_id
			);
	}

	var _stct_zone_loot =
		scr_reward_get_zone_loot_info(
			_str_loot_zone_id
		);

	var _arr_zone_material_pool = [];
	var _arr_secret_item_pool = [];

	if (is_struct(_stct_zone_loot)){

		if (
			is_array(
				_stct_zone_loot
					._arr_material_pool
			)
		){

			_arr_zone_material_pool =
				_stct_zone_loot
					._arr_material_pool;
		}

		if (
			is_array(
				_stct_zone_loot
					._arr_secret_item_pool
			)
		){

			_arr_secret_item_pool =
				_stct_zone_loot
					._arr_secret_item_pool;
		}

		if (
			is_array(
				_stct_zone_loot
					._arr_bonus_item_pool
			)
		){

			for (
				var _it_zone_item = 0;
				_it_zone_item <
					array_length(
						_stct_zone_loot
							._arr_bonus_item_pool
					);
				_it_zone_item++
			){

				array_push(
					_arr_bonus_item_candidates,
					{
						_str_item_id :
							_stct_zone_loot
								._arr_bonus_item_pool[
									_it_zone_item
								],

						_str_source :
							"ZONE_ITEM",

						_str_source_detail :
							_str_loot_zone_id
					}
				);
			}
		}
	}

	#endregion

	#region GOLD

	var _val_gold_after_grade =
		ceil(
			_val_gold_base *
			_stct_grade
				._val_gold_multiplier
		);

	var _val_gold_item_bonus = 0;

	//----------------------//
	//BATTLE EXIT ITEM BONUS//
	//----------------------//
	for (
		var _it_player = 0;
		_it_player <
			ds_list_size(
				_ref_player_controller
					._list_beasts
			);
		_it_player++
	){

		var _ref_player_beast =
			ds_list_find_value(
				_ref_player_controller
					._list_beasts,
				_it_player
			);

		if (!instance_exists(_ref_player_beast)){
			continue;
		}

		var _stct_item =
			_ref_player_beast
				._stct_held_item;

		if (
			_stct_item == undefined ||
			_stct_item == "EMPTY" ||
			!is_struct(_stct_item)
		){
			continue;
		}

		if (
			_stct_item._str_item_trigger_type !=
			"BATTLE_EXIT"
		){
			continue;
		}

		if (_stct_item._scr_item == undefined){
			continue;
		}

		var _val_item_bonus =
			script_execute(
				_stct_item._scr_item,
				"TRIGGER",
				_stct_item
			);

		if (
			is_real(
				_val_item_bonus
			) &&
			_val_item_bonus > 0
		){

			_val_gold_item_bonus +=
				_val_item_bonus;

			scr_gui_spawn_popup_trigger_banner(
				_stct_item._str_item_name +
				" +" +
				string(
					round(
						_val_item_bonus *
						100
					)
				) +
				"% GOLD",
				_stct_item._spr_item
			);
		}
	}

	var _val_gold_reward =
		_val_gold_after_grade;

	if (_val_gold_item_bonus > 0){

		_val_gold_reward =
			ceil(
				_val_gold_reward *
				(1 + _val_gold_item_bonus)
			);
	}

	global.val_player_gold +=
		_val_gold_reward;

	array_push(
		_arr_rewards,
		{
			_str_reward_type : "GOLD",
			_str_reward_subtype : "GOLD",
			_str_reward_id : "GOLD",
			_str_display_name : "GOLD",
			_ct_amount : _val_gold_reward,
			_str_rarity : "",
			_str_source : "BATTLE",
			_str_source_detail : "",
			_spr_reward : undefined
		}
	);

	#endregion

	#region GUARANTEED MATERIAL

	var _ct_guaranteed_material_rolls =
		1 +
		_ct_guaranteed_material_item_bonus;

	var _ct_guaranteed_material_awarded = 0;

	for (
		var _it_guaranteed_material = 0;
		_it_guaranteed_material <
			_ct_guaranteed_material_rolls;
		_it_guaranteed_material++
	){

		var _flag_material_awarded =
			false;

		//----------------------//
		//PREFER BEAST MATERIAL//
		//----------------------//
		if (
			array_length(
				_arr_beast_material_candidates
			) > 0
		){

			var _stct_material_candidate =
				_arr_beast_material_candidates[
					irandom(
						array_length(
							_arr_beast_material_candidates
						) -
						1
					)
				];

			var _stct_material_award =
				scr_reward_award_inventory_item(
					_stct_material_candidate
						._str_item_id,
					"BEAST_MATERIAL",
					_stct_material_candidate
						._str_source_detail
				);

			if (is_struct(_stct_material_award)){

				array_push(
					_arr_rewards,
					_stct_material_award
						._stct_entry
				);

				_flag_material_awarded =
					true;
			}
		}

		//---------------------//
		//FALLBACK ZONE MATERIAL//
		//---------------------//
		if (
			!_flag_material_awarded &&
			array_length(
				_arr_zone_material_pool
			) > 0
		){

			var _str_material_id =
				_arr_zone_material_pool[
					irandom(
						array_length(
							_arr_zone_material_pool
						) -
						1
					)
				];

			var _stct_material_award =
				scr_reward_award_inventory_item(
					_str_material_id,
					"ZONE_MATERIAL",
					_str_loot_zone_id
				);

			if (is_struct(_stct_material_award)){

				array_push(
					_arr_rewards,
					_stct_material_award
						._stct_entry
				);

				_flag_material_awarded =
					true;
			}
		}

		if (!_flag_material_awarded){
			break;
		}

		_ct_guaranteed_material_awarded++;
	}

	#endregion

	#region SECOND MATERIAL ROLL

	if (
		random(100) <
			_val_zone_material_chance
	){

		//--------------------//
		//PREFER ZONE MATERIAL//
		//--------------------//
		if (
			array_length(
				_arr_zone_material_pool
			) > 0
		){

			var _str_second_material_id =
				_arr_zone_material_pool[
					irandom(
						array_length(
							_arr_zone_material_pool
						) -
						1
					)
				];

			var _stct_second_material_award =
				scr_reward_award_inventory_item(
					_str_second_material_id,
					"ZONE_MATERIAL",
					_str_loot_zone_id
				);

			if (
				is_struct(
					_stct_second_material_award
				)
			){

				array_push(
					_arr_rewards,
					_stct_second_material_award
						._stct_entry
				);
			}
		}

		//--------------------//
		//FALLBACK BEAST POOL//
		//--------------------//
		else if (
			array_length(
				_arr_beast_material_candidates
			) > 0
		){

			var _stct_second_candidate =
				_arr_beast_material_candidates[
					irandom(
						array_length(
							_arr_beast_material_candidates
						) -
						1
					)
				];

			var _stct_second_material_award =
				scr_reward_award_inventory_item(
					_stct_second_candidate
						._str_item_id,
					"BEAST_MATERIAL",
					_stct_second_candidate
						._str_source_detail
				);

			if (
				is_struct(
					_stct_second_material_award
				)
			){

				array_push(
					_arr_rewards,
					_stct_second_material_award
						._stct_entry
				);
			}
		}
	}

	#endregion

	#region EGG ROLL

	if (
		array_length(
			_arr_egg_candidates
		) > 0 &&
		random(100) <
			_val_egg_chance
	){

		var _stct_egg_candidate =
			_arr_egg_candidates[
				irandom(
					array_length(
						_arr_egg_candidates
					) -
					1
				)
			];

		var _stct_egg_award =
			scr_reward_award_inventory_item(
				_stct_egg_candidate
					._str_item_id,
				"EGG",
				_stct_egg_candidate
					._str_source_detail
			);

		if (is_struct(_stct_egg_award)){

			array_push(
				_arr_rewards,
				_stct_egg_award
					._stct_entry
			);
		}
	}

	#endregion

	#region BEAST CARD ROLL

	if (
		array_length(
			_arr_enemy_units
		) > 0 &&
		random(100) <
			_val_beast_card_chance
	){

		var _str_requested_rarity =
			scr_reward_roll_card_rarity(
				scr_reward_get_card_rarity_weights()
			);

		var _arr_rarity_fallback =
			scr_reward_get_card_rarity_fallback(
				_str_requested_rarity
			);

		var _arr_card_candidates = [];
		var _str_resolved_rarity = "";

		for (
			var _it_rarity = 0;
			_it_rarity <
				array_length(
					_arr_rarity_fallback
				);
			_it_rarity++
		){

			var _str_try_rarity =
				_arr_rarity_fallback[
					_it_rarity
				];

			_arr_card_candidates = [];

			for (
				var _it_unit = 0;
				_it_unit <
					array_length(
						_arr_enemy_units
					);
				_it_unit++
			){

				var _stct_card_source_unit =
					_arr_enemy_units[
						_it_unit
					];

				var _arr_cards =
					scr_reward_get_beast_card_pool(
						_stct_card_source_unit,
						_str_try_rarity
					);

				for (
					var _it_card = 0;
					_it_card <
						array_length(
							_arr_cards
						);
					_it_card++
				){

					array_push(
						_arr_card_candidates,
						{
							_str_card_id :
								_arr_cards[
									_it_card
								],

							_str_source_detail :
								_stct_card_source_unit
									._str_beast_name
						}
					);
				}
			}

			if (
				array_length(
					_arr_card_candidates
				) > 0
			){

				_str_resolved_rarity =
					_str_try_rarity;

				break;
			}
		}

		if (
			array_length(
				_arr_card_candidates
			) > 0
		){

			var _stct_card_candidate =
				_arr_card_candidates[
					irandom(
						array_length(
							_arr_card_candidates
						) -
						1
					)
				];

			var _stct_card_award =
				scr_reward_award_card(
					_stct_card_candidate
						._str_card_id,
					"BEAST_CARD",
					_stct_card_candidate
						._str_source_detail
				);

			if (is_struct(_stct_card_award)){

				array_push(
					_arr_rewards,
					_stct_card_award
						._stct_entry
				);
			}

			scr_debug_log(
				"REWARD",
				"CARD",
				undefined,
				"BEAST CARD RARITY RESOLVED" +
				" | REQUESTED: " +
				_str_requested_rarity +
				" | RESOLVED: " +
				_str_resolved_rarity,
				"REWARD",
				"SCR_REWARD_RESOLVE_BATTLE"
			);
		}
	}

	#endregion

	#region ZONE CARD ROLL

	if (
		is_struct(
			_stct_zone_loot
		) &&
		random(100) <
			_val_zone_card_chance
	){

		var _str_requested_rarity =
			scr_reward_roll_card_rarity(
				scr_reward_get_card_rarity_weights()
			);

		var _arr_rarity_fallback =
			scr_reward_get_card_rarity_fallback(
				_str_requested_rarity
			);

		var _arr_zone_card_candidates = [];
		var _str_resolved_rarity = "";

		for (
			var _it_rarity = 0;
			_it_rarity <
				array_length(
					_arr_rarity_fallback
				);
			_it_rarity++
		){

			var _str_try_rarity =
				_arr_rarity_fallback[
					_it_rarity
				];

			_arr_zone_card_candidates =
				scr_reward_get_zone_card_pool(
					_stct_zone_loot,
					_str_try_rarity
				);

			if (
				array_length(
					_arr_zone_card_candidates
				) > 0
			){

				_str_resolved_rarity =
					_str_try_rarity;

				break;
			}
		}

		if (
			array_length(
				_arr_zone_card_candidates
			) > 0
		){

			var _str_zone_card_id =
				_arr_zone_card_candidates[
					irandom(
						array_length(
							_arr_zone_card_candidates
						) -
						1
					)
				];

			var _stct_zone_card_award =
				scr_reward_award_card(
					_str_zone_card_id,
					"ZONE_CARD",
					_str_loot_zone_id
				);

			if (
				is_struct(
					_stct_zone_card_award
				)
			){

				array_push(
					_arr_rewards,
					_stct_zone_card_award
						._stct_entry
				);
			}

			scr_debug_log(
				"REWARD",
				"CARD",
				undefined,
				"ZONE CARD RARITY RESOLVED" +
				" | ZONE: " +
				_str_loot_zone_id +
				" | REQUESTED: " +
				_str_requested_rarity +
				" | RESOLVED: " +
				_str_resolved_rarity,
				"REWARD",
				"SCR_REWARD_RESOLVE_BATTLE"
			);
		}
	}

	#endregion

	#region BONUS ITEM ROLL

	if (
		array_length(
			_arr_bonus_item_candidates
		) > 0 &&
		random(100) <
			_val_bonus_item_chance
	){

		var _stct_bonus_item_candidate =
			_arr_bonus_item_candidates[
				irandom(
					array_length(
						_arr_bonus_item_candidates
					) -
					1
				)
			];

		var _stct_bonus_item_award =
			scr_reward_award_inventory_item(
				_stct_bonus_item_candidate
					._str_item_id,
				_stct_bonus_item_candidate
					._str_source,
				_stct_bonus_item_candidate
					._str_source_detail
			);

		if (is_struct(_stct_bonus_item_award)){

			array_push(
				_arr_rewards,
				_stct_bonus_item_award
					._stct_entry
			);
		}
	}

	#endregion

	#region SECRET ZONE ITEM ROLL

	if (
		array_length(
			_arr_secret_item_pool
		) > 0 &&
		random(100) <
			_stct_config
				._val_secret_item_chance
	){

		var _str_secret_item_id =
			_arr_secret_item_pool[
				irandom(
					array_length(
						_arr_secret_item_pool
					) -
					1
				)
			];

		var _stct_secret_item_award =
			scr_reward_award_inventory_item(
				_str_secret_item_id,
				"SECRET_ZONE_ITEM",
				_str_loot_zone_id
			);

		if (is_struct(_stct_secret_item_award)){

			array_push(
				_arr_rewards,
				_stct_secret_item_award
					._stct_entry
			);
		}
	}

	#endregion

	#region GLOBAL BONUS CARD ROLL

	var _stct_global_bonus =
		scr_reward_get_global_bonus_info();

	if (
		is_struct(
			_stct_global_bonus
		) &&
		random(100) <
			_stct_global_bonus
				._val_card_bonus_chance
	){

		var _str_requested_rarity =
			scr_reward_roll_card_rarity(
				_stct_global_bonus
					._stct_card_rarity_weights
			);

		var _arr_rarity_fallback =
			scr_reward_get_card_rarity_fallback(
				_str_requested_rarity
			);

		var _arr_global_pool = [];

		for (
			var _it_rarity = 0;
			_it_rarity <
				array_length(
					_arr_rarity_fallback
				);
			_it_rarity++
		){

			_arr_global_pool =
				scr_reward_get_global_card_pool(
					_arr_rarity_fallback[
						_it_rarity
					]
				);

			if (
				array_length(
					_arr_global_pool
				) > 0
			){
				break;
			}
		}

		if (
			array_length(
				_arr_global_pool
			) > 0
		){

			var _str_card_id =
				_arr_global_pool[
					irandom(
						array_length(
							_arr_global_pool
						) -
						1
					)
				];

			var _stct_global_card_award =
				scr_reward_award_card(
					_str_card_id,
					"GLOBAL_BONUS",
					""
				);

			if (
				is_struct(
					_stct_global_card_award
				)
			){

				array_push(
					_arr_rewards,
					_stct_global_card_award
						._stct_entry
				);

				scr_debug_log(
					"REWARD",
					"BONUS",
					undefined,
					"BONUS LOOT FOUND" +
					" | CARD: " +
					string_upper(
						_str_card_id
					),
					"REWARD",
					"SCR_REWARD_RESOLVE_BATTLE"
				);
			}
		}
	}

	#endregion

	#region SAVE PARTY HP AND EXP

	var _ct_exp_recipients = 0;

	//===================//
	//ENEMY LEVEL EXP BAND//
	//===================//
	var _val_enemy_avg_level =
		max(
			1,
			_stct_grade
				._val_enemy_avg_level
		);

	var _ct_exp_level_band =
		floor(
			(
				max(
					1,
					floor(
						_val_enemy_avg_level
					)
				) -
				1
			) /
			5
		);

	var _ct_exp_each =
		_stct_config._ct_exp_base +
		(
			_ct_exp_level_band *
			_stct_config
				._ct_exp_per_level_band
		);

	if (
		variable_global_exists(
			"list_player_party"
		) &&
		ds_exists(
			global.list_player_party,
			ds_type_list
		)
	){

		for (
			var _it_party = 0;
			_it_party <
				ds_list_size(
					global.list_player_party
				);
			_it_party++
		){

			var _stct_party_beast =
				ds_list_find_value(
					global.list_player_party,
					_it_party
				);

			if (!is_struct(_stct_party_beast)){
				continue;
			}

			var _ref_battle_beast =
				noone;

			for (
				var _it_battle_beast = 0;
				_it_battle_beast <
					ds_list_size(
						_ref_player_controller
							._list_beasts
					);
				_it_battle_beast++
			){

				var _ref_check =
					ds_list_find_value(
						_ref_player_controller
							._list_beasts,
						_it_battle_beast
					);

				if (!instance_exists(_ref_check)){
					continue;
				}

				if (
					_ref_check._uid_beast ==
					_stct_party_beast
						._uid_beast
				){

					_ref_battle_beast =
						_ref_check;

					break;
				}
			}

			//----------------------//
			//STORE POST-BATTLE HP//
			//----------------------//
			if (
				instance_exists(
					_ref_battle_beast
				)
			){

				_stct_party_beast
					._val_beast_hp_cur =
					clamp(
						_ref_battle_beast
							._val_cur_hp,
						0,
						_stct_party_beast
							._val_beast_hp_max
					);
			}

			//-----------------//
			//SURVIVORS GET EXP//
			//-----------------//
			if (
				_stct_party_beast
					._val_beast_hp_cur <=
				0
			){
				continue;
			}

var _ct_exp_holder_bonus = 0;

if (instance_exists(_ref_battle_beast)){

	var _stct_item =
		_ref_battle_beast._stct_held_item;

	if (
		is_struct(_stct_item) &&
		_stct_item._str_item_trigger_type == "RESOURCE" &&
		_stct_item._scr_item != undefined
	){

		var _stct_resource_bonus =
			script_execute(
				_stct_item._scr_item,
				"TRIGGER",
				_stct_item
			);

		if (
			is_struct(_stct_resource_bonus) &&
			variable_struct_exists(
				_stct_resource_bonus,
				"_ct_exp_holder_bonus"
			)
		){
			_ct_exp_holder_bonus =
				max(
					0,
					_stct_resource_bonus
						._ct_exp_holder_bonus
				);
		}
	}
}

var _ct_exp_award =
	_ct_exp_each +
	_ct_exp_holder_bonus;

_ct_exp_recipients++;

scr_beast_add_exp(
	_stct_party_beast,
	_ct_exp_award
);
		}
	}

	array_push(
		_arr_rewards,
		{
			_str_reward_type : "EXP",
			_str_reward_subtype : "EXP",
			_str_reward_id : "EXP",
			_str_display_name : "EXP",

			_ct_amount :
				_ct_exp_each,

			_ct_recipients :
				_ct_exp_recipients,

			_str_rarity : "",
			_str_source : "BATTLE",
			_str_source_detail : "",
			_spr_reward : undefined
		}
	);

	#endregion

	#region DEBUG

	scr_debug_log(
		"BATTLE",
		"REWARD",
		undefined,
		"BATTLE REWARDS COMPLETE" +
		" | SCORE: " +
		string(
			_stct_grade._val_score
		) +
		" | TIME: " +
		string_format(
			_stct_grade
				._val_elapsed_seconds,
			0,
			1
		) +
		"s" +
		" | FINAL HP: " +
		string(
			round(
				_stct_grade
					._val_hp_ratio *
				100
			)
		) +
		"%" +
		" | DIFFICULTY: " +
		_stct_grade._str_difficulty +
		" | LEVEL DISPARITY: " +
		string(
			_stct_grade
				._val_level_disparity
		) +
		" | ENEMY AVG LEVEL: " +
		string_format(
			_val_enemy_avg_level,
			0,
			1
		) +
		" | GOLD BASE: " +
		string(
			_val_gold_base
		) +
		" | GOLD FINAL: " +
		string(
			_val_gold_reward
		) +
		" | EXP: +" +
		string(
			_ct_exp_each
		) +
		" | EXP RECIPIENTS: " +
		string(
			_ct_exp_recipients
		) +
		" | REWARD ENTRIES: " +
		string(
			array_length(
				_arr_rewards
			)
		) +
		" | ROUND: " +
		string(
			_ct_rounds
		),
		"REWARD",
		"SCR_REWARD_RESOLVE_BATTLE"
	);

	#endregion

	#region RESULT

	return {
		_flag_success : true,

		_stct_grade :
			_stct_grade,

		_arr_rewards :
			_arr_rewards,

		_val_gold_base :
			_val_gold_base,

		_val_gold_reward :
			_val_gold_reward,

		_val_gold_item_bonus :
			_val_gold_item_bonus,

		_val_gold_level_bonus_per_level :
			_stct_config
				._val_gold_level_bonus_per_level,

		_val_enemy_avg_level :
			_val_enemy_avg_level,

		_ct_exp_each :
			_ct_exp_each,

		_ct_exp_recipients :
			_ct_exp_recipients,

		_ct_rounds :
			_ct_rounds,

		_str_loot_zone_id :
			_str_loot_zone_id
	};

	#endregion
}
