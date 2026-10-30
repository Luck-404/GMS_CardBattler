//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_TRIGGER_WILD_BEAST_BATTLE
// FUNCTION: Starts an overworld Beast encounter and transfers its encounter state
//           into the battle room.
//
//           Normal visible-wild encounters preserve the existing encounter flow:
//           the touched overworld Beast is carried into enemy slot 0, supplemental
//           enemies are selected from its encounter pool, encounter scaling is
//           rolled normally, and the source room / loot-zone state is stored.
//
//           Exact scripted and World Event encounters may instead provide a
//           pre-initialized enemy roster. When an exact roster is present, that
//           roster is validated and handed to the battle system unchanged; no
//           supplemental random enemies are generated and the supplied Beast
//           structs retain their existing identities, levels, breeds, abilities,
//           Held Items, Elite data, and other persistent runtime fields.
//
//           World Event exact encounters also establish persistent battle context
//           identifying the owning World Event, event entity / pod, source room,
//           and post-battle World Event-roll suppression state.
//
// ARGUMENTS:
//     _ref_world_beast
//         Overworld Beast instance that owns / initiates the encounter.
//
// RETURNS:
//     True when the battle transition was successfully claimed and encounter state
//     was installed. False when validation fails or battle entry is already owned.
//
//===============================================================================//
function scr_overworld_trigger_wild_beast_battle(_ref_world_beast){

	//================//
	//VALIDATE BEAST//
	//================//
	if (!instance_exists(_ref_world_beast)){
		return false;
	}

	if (!is_struct(_ref_world_beast._stct_unit)){
		return false;
	}

	// Runaway Treasure Beasts are caught directly in the overworld and never
	// enter the battle system.
	if (
		variable_instance_exists(
			_ref_world_beast,
			"_flag_world_event_instance"
		) &&
		_ref_world_beast._flag_world_event_instance &&
		variable_instance_exists(
			_ref_world_beast,
			"_str_world_event_id"
		) &&
		_ref_world_beast._str_world_event_id ==
			"RUNAWAY_TREASURE_BEAST"
	){
		return false;
	}

	if (!instance_exists(obj_player)){
		return false;
	}

	//====================//
	//EXACT ROSTER SOURCE//
	//====================//
	var _flag_exact_enemy_roster =
		false;

	var _arr_exact_enemy_roster =
		[];

	var _stct_world_event_battle_context =
		undefined;

	if (
		variable_instance_exists(
			_ref_world_beast,
			"_arr_exact_enemy_roster"
		) &&
		is_array(
			_ref_world_beast
				._arr_exact_enemy_roster
		) &&
		array_length(
			_ref_world_beast
				._arr_exact_enemy_roster
		) > 0
	){

		if (
			!scr_battle_validate_exact_enemy_roster(
				_ref_world_beast
					._arr_exact_enemy_roster
			)
		){

			scr_debug_log(
				"BATTLE",
				"ENTRY",
				_ref_world_beast,
				"EXACT ENEMY ROSTER REJECTED" +
				" | REASON: INVALID ROSTER",
				"ERROR",
				"SCR_OVERWORLD_TRIGGER_WILD_BEAST_BATTLE"
			);

			return false;
		}

		_flag_exact_enemy_roster =
			true;

		for (
			var _it_exact_unit = 0;
			_it_exact_unit <
				array_length(
					_ref_world_beast
						._arr_exact_enemy_roster
				);
			_it_exact_unit++
		){

			array_push(
				_arr_exact_enemy_roster,
				_ref_world_beast
					._arr_exact_enemy_roster[
						_it_exact_unit
					]
			);
		}

		if (
			variable_instance_exists(
				_ref_world_beast,
				"_stct_world_event_battle_context"
			) &&
			is_struct(
				_ref_world_beast
					._stct_world_event_battle_context
			)
		){
			_stct_world_event_battle_context =
				_ref_world_beast
					._stct_world_event_battle_context;
		}
	}

	//======================//
	//ROOM ENTRY BATTLE LOCK//
	//======================//
	// Only one encounter / transition may own battle entry.
	if (
		instance_exists(obj_transition) ||
		instance_exists(obj_transition_fader) ||
		instance_exists(obj_battle_wait)
	){
		return false;
	}

	//================//
	//GET ENCOUNTER POOL//
	//================//
	var _arr_pool = [];
	var _str_pool_source = "SELF";

	//----------------//
	//EXACT ROSTER//
	//----------------//
	if (_flag_exact_enemy_roster){

		for (
			var _it_exact_pool = 0;
			_it_exact_pool <
				array_length(
					_arr_exact_enemy_roster
				);
			_it_exact_pool++
		){

			var _stct_exact_pool_unit =
				_arr_exact_enemy_roster[
					_it_exact_pool
				];

			array_push(
				_arr_pool,
				_stct_exact_pool_unit
					._str_beast_name
			);
		}

		_str_pool_source =
			"EXACT ROSTER";
	}

	//----------------//
	//BEAST POOL OVERRIDE//
	//----------------//
	// Cheat-spawned visible wild Beasts can carry their own
	// encounter pool without changing their home/leash object.
	else if (
		variable_instance_exists(
			_ref_world_beast,
			"_arr_encounter_pool"
		) &&
		is_array(
			_ref_world_beast._arr_encounter_pool
		) &&
		array_length(
			_ref_world_beast._arr_encounter_pool
		) > 0
	){

		_arr_pool =
			_ref_world_beast._arr_encounter_pool;

		_str_pool_source =
			"BEAST OVERRIDE";
	}

	//----------------//
	//HOME ZONE POOL//
	//----------------//
	else if (
		instance_exists(
			_ref_world_beast._ref_home
		) &&
		variable_instance_exists(
			_ref_world_beast._ref_home,
			"_arr_encounter_beasts"
		) &&
		is_array(
			_ref_world_beast
				._ref_home
				._arr_encounter_beasts
		) &&
		array_length(
			_ref_world_beast
				._ref_home
				._arr_encounter_beasts
		) > 0
	){

		_arr_pool =
			_ref_world_beast
				._ref_home
				._arr_encounter_beasts;

		_str_pool_source =
			"HOME ZONE";
	}

	//----------------//
	//SELF FALLBACK//
	//----------------//
	else{

		_arr_pool = [
			_ref_world_beast
				._stct_unit
				._str_beast_name
		];

		_str_pool_source =
			"SELF";
	}

	//========================//
	//APPLY ENCOUNTER ITEMS//
	//========================//
	var _arr_weighted_pool = [];

	// Exact rosters are already fully initialized. Do not reroll encounter-held
	// item weighting for a roster that is meant to preserve exact identities.
	if (_flag_exact_enemy_roster){

		_arr_weighted_pool =
			_arr_pool;
	}
	else{

		_arr_weighted_pool =
			scr_overworld_apply_encounter_held_items(
				_arr_pool
			);

		if (
			!is_array(
				_arr_weighted_pool
			) ||
			array_length(
				_arr_weighted_pool
			) <= 0
		){

			_arr_weighted_pool =
				_arr_pool;
		}
	}

	//================//
	//GET LOOT ZONE//
	//================//
	var _str_loot_zone_id =
		"UNASSIGNED";

	//----------------//
	//BEAST LOOT ZONE OVERRIDE//
	//----------------//
	// Developer-spawned wild Beasts may carry the nearest zone's loot ID.
	if (
		variable_instance_exists(
			_ref_world_beast,
			"_str_loot_zone_id"
		) &&
		is_string(
			_ref_world_beast
				._str_loot_zone_id
		) &&
		_ref_world_beast
			._str_loot_zone_id !=
			""
	){

		_str_loot_zone_id =
			string_upper(
				_ref_world_beast
					._str_loot_zone_id
			);
	}

	//----------------//
	//HOME ZONE LOOT//
	//----------------//
	else if (
		instance_exists(
			_ref_world_beast
				._ref_home
		) &&
		variable_instance_exists(
			_ref_world_beast
				._ref_home,
			"_str_loot_zone_id"
		) &&
		is_string(
			_ref_world_beast
				._ref_home
				._str_loot_zone_id
		) &&
		_ref_world_beast
			._ref_home
			._str_loot_zone_id !=
			""
	){

		_str_loot_zone_id =
			string_upper(
				_ref_world_beast
					._ref_home
					._str_loot_zone_id
			);
	}

	//================//
	//CLAIM TRANSITION//
	//================//
	// Claim transition ownership BEFORE writing any global encounter state.
	// If another Beast or encounter source claimed it earlier this frame,
	// this Beast aborts without changing the pending battle.
	var _ref_transition =
		scr_transition_trigger(
			rm_battle
		);

	if (!instance_exists(_ref_transition)){
		return false;
	}

	//========================//
	//ROLL ENCOUNTER SCALING//
	//========================//
	// Roll only after this visible Beast successfully owns the battle
	// transition. The forced visible Beast still occupies enemy slot 0.
	var _stct_encounter_scaling =
		scr_overworld_roll_encounter_scaling(
			room
		);

	if (!is_struct(_stct_encounter_scaling)){
		with (_ref_transition){
			instance_destroy();
		}

		return false;
	}

	//====================//
	//EXACT ROSTER SCALING//
	//====================//
	// Keep the room's normal scaling metadata for rewards/difficulty display, but
	// exact battle composition owns team size and the units' preinitialized levels.
	if (_flag_exact_enemy_roster){

		_stct_encounter_scaling._ct_enemy_beasts =
			array_length(
				_arr_exact_enemy_roster
			);
	}

	//======================//
	//COPY ELITE METADATA//
	//======================//
	var _stct_forced_unit =
		_ref_world_beast._stct_unit;

	var _flag_visible_elite =
		variable_struct_exists(
			_stct_forced_unit,
			"_flag_elite"
		) &&
		_stct_forced_unit._flag_elite;

	_stct_encounter_scaling._flag_elite_encounter =
		_flag_visible_elite;

	_stct_encounter_scaling._str_elite_modifier =
		_flag_visible_elite &&
		variable_struct_exists(
			_stct_forced_unit,
			"_str_elite_modifier"
		)
		? string_upper(
			string(
				_stct_forced_unit
					._str_elite_modifier
			)
		)
		: "";

	_stct_encounter_scaling._val_elite_risk_tier =
		_flag_visible_elite &&
		variable_struct_exists(
			_stct_forced_unit,
			"_val_elite_risk_tier"
		)
		? max(
			0,
			round(
				_stct_forced_unit
					._val_elite_risk_tier
			)
		)
		: 0;

	_stct_encounter_scaling._val_elite_chance_percent =
		variable_struct_exists(
			_stct_forced_unit,
			"_val_elite_chance_percent"
		)
		? _stct_forced_unit
			._val_elite_chance_percent
		: 4;

	_stct_encounter_scaling._val_elite_roll =
		variable_struct_exists(
			_stct_forced_unit,
			"_val_elite_roll"
		)
		? _stct_forced_unit
			._val_elite_roll
		: -1;

	_stct_encounter_scaling._str_elite_source_item_id =
		variable_struct_exists(
			_stct_forced_unit,
			"_str_elite_source_item_id"
		)
		? string_upper(
			string(
				_stct_forced_unit
					._str_elite_source_item_id
			)
		)
		: "BASE";

	//================//
	//STORE SOURCE DATA//
	//================//
	var _str_source_room =
		string_upper(
			room_get_name(room)
		);

	var _val_source_x =
		round(obj_player.x);

	var _val_source_y =
		round(obj_player.y);

	var _str_beast_name =
		string_upper(
			_ref_world_beast
				._stct_unit
				._str_beast_name
		);

	var _val_beast_level =
		_ref_world_beast
			._stct_unit
			._val_beast_level;

	//================//
	//STORE BATTLE STATE//
	//================//
	global.val_last_player_x =
		obj_player.x;

	global.val_last_player_y =
		obj_player.y;

	global.rm_last_player =
		room;

	global.arr_last_enemy_pool =
		_arr_weighted_pool;

	global.str_last_loot_zone_id =
		_str_loot_zone_id;

	global.stct_encounter_scaling =
		_stct_encounter_scaling;

	//======================//
	//ENEMY ROSTER HANDOFF//
	//======================//
	if (_flag_exact_enemy_roster){

		if (
			!scr_battle_set_exact_enemy_roster(
				_arr_exact_enemy_roster
			)
		){

			with (_ref_transition){
				instance_destroy();
			}

			return false;
		}

		global.stct_forced_enemy_unit =
			undefined;

		//==========================//
		//WORLD EVENT BATTLE CONTEXT//
		//==========================//
		if (
			is_struct(
				_stct_world_event_battle_context
			)
		){

			if (
				!scr_world_event_set_battle_context(
					_stct_world_event_battle_context,
					_arr_exact_enemy_roster
				)
			){

				scr_battle_clear_exact_enemy_roster();

				with (_ref_transition){
					instance_destroy();
				}

				return false;
			}
		}
		else{

			// A generic scripted exact battle is legal without World Event context.
			// Explicitly clear any stale context from a previously aborted battle.
			scr_world_event_clear_battle_context(
				false
			);

			scr_world_event_set_battle_roll_suppression(
				false
			);
		}
	}
	else{

		//======================//
		//NORMAL WILD ENCOUNTER//
		//======================//
		scr_battle_clear_exact_enemy_roster();

		scr_world_event_clear_battle_context(
			false
		);

		scr_world_event_set_battle_roll_suppression(
			false
		);

		global.stct_forced_enemy_unit =
			_ref_world_beast._stct_unit;
	}

	//================//
	//DEBUG BATTLE ENTRY//
	//================//
	scr_debug_log(
		"BATTLE",
		"ENTRY",
		_ref_world_beast,
		"PLAYER ENTERED BATTLE FROM " +
		_str_source_room +
		" (" +
		string(_val_source_x) +
		"," +
		string(_val_source_y) +
		")" +
		" | TRIGGER: " +
		(_flag_exact_enemy_roster ? "EXACT ROSTER" : "VISIBLE WILD") +
		" | VISIBLE ENEMY: " +
		_str_beast_name +
		" (LVL " +
		string(_val_beast_level) +
		")" +
		" | POOL SOURCE: " +
		_str_pool_source +
		" | EXACT ROSTER SIZE: " +
		string(
			_flag_exact_enemy_roster
			? array_length(
				_arr_exact_enemy_roster
			)
			: 0
		) +
		" | BASE POOL SIZE: " +
		string(
			array_length(
				_arr_pool
			)
		) +
		" | WEIGHTED POOL SIZE: " +
		string(
			array_length(
				_arr_weighted_pool
			)
		) +
		" | LOOT ZONE: " +
		_str_loot_zone_id +
		" | DIFFICULTY: " +
		_stct_encounter_scaling._str_difficulty +
		" | ELITE: " +
		(
			_stct_encounter_scaling
				._flag_elite_encounter
			? "YES (" +
				_stct_encounter_scaling
					._str_elite_modifier +
				")"
			: "NO"
		) +
		" | ELITE ROLL: " +
		string(
			_stct_encounter_scaling
				._val_elite_roll
		) +
		"/100" +
		" | ELITE CHANCE: " +
		string(
			_stct_encounter_scaling
				._val_elite_chance_percent
		) +
		"%" +
		" | ELITE SOURCE: " +
		_stct_encounter_scaling
			._str_elite_source_item_id +
		" | RISK TIER: " +
		string(
			_stct_encounter_scaling
				._val_elite_risk_tier
		) +
		" | ENEMIES: " +
		string(_stct_encounter_scaling._ct_enemy_beasts) +
		" | ZONE LEVELS: " +
		string(_stct_encounter_scaling._val_zone_level_min) +
		"-" +
		string(_stct_encounter_scaling._val_zone_level_max) +
		" | LEVEL TARGET: " +
		string(_stct_encounter_scaling._val_enemy_level_target) +
		" | TRANSITION CLAIMED: YES",
		"TRANSITION",
		"SCR_OVERWORLD_TRIGGER_WILD_BEAST_BATTLE"
	);

	//================//
	//LOCK PLAYER//
	//================//
	scr_player_set_movement_state(
		"STOP"
	);

	obj_player.visible =
		false;

	//================//
	//WILD BEAST CRY//
	//================//
	scr_beast_sound_play(
		_ref_world_beast,
		"CRY"
	);

	//================//
	//START BATTLE//
	//================//
	audio_play_sound(
		snd_overworld_encounter_trigger,
		0,
		false
	);

	return true;
}