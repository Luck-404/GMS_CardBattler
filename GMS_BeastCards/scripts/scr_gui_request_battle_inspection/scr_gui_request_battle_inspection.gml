//===============================================================================//
//
// SCRIPT: SCR_GUI_REQUEST_BATTLE_INSPECTION
// FUNCTION: Registers the highest-priority Ctrl inspection request for a battle
//           Beast, Minion, Status, or Card and builds its inspection text.
//
// ARGUMENTS: _str_type identifies the inspected source category.
//            _ref_source is the inspected battle instance.
//            _val_priority resolves overlapping inspection hitboxes.
// RETURNS: True when inspection data is registered; otherwise false.
//
//===============================================================================//

function scr_gui_request_battle_inspection(
	_str_type,
	_ref_source,
	_val_priority=0
){

	//================//
	//VALIDATE STATE//
	//================//
	if (
		scr_gui_check_cheats_active() ||
		!keyboard_check(vk_lcontrol)
	){
		return false;
	}

	if (!instance_exists(_ref_source)){
		return false;
	}

	//================//
	//ENSURE GLOBALS//
	//================//
	if (
		!variable_global_exists(
			"flag_battle_inspection"
		)
	){

		global.flag_battle_inspection = false;

		global.str_battle_inspection_title = "";
		global.str_battle_inspection_body = "";

		global.val_battle_inspection_priority = -100000;
	}

	//================//
	//CHECK PRIORITY//
	//================//
	if (
		global.flag_battle_inspection &&
		_val_priority <
			global.val_battle_inspection_priority
	){
		return false;
	}

	//================//
	//CONTENT//
	//================//
	var _str_type_upper =
		string_upper(
			string(_str_type)
		);

	var _str_name = "";
	var _str_body = "";

	switch(_str_type_upper){

		//=======================================================================//
		// BEAST
		//=======================================================================//
		case "BEAST":

			if (
				!variable_instance_exists(
					_ref_source,
					"_ref_unit"
				) ||
				!is_struct(
					_ref_source._ref_unit
				)
			){
				return false;
			}

			var _stct_unit =
				_ref_source._ref_unit;

			//================//
			//NAME//
			//================//
			_str_name =
				string(
					_stct_unit._str_beast_name
				);

			//================//
			//TEAM / LEVEL//
			//================//
			var _str_team = "UNKNOWN";

			if (
				variable_instance_exists(
					_ref_source,
					"_str_team"
				)
			){

				_str_team =
					string_upper(
						string(
							_ref_source._str_team
						)
					);
			}

			_str_body =
				_str_team +
				" | LEVEL " +
				string(
					_stct_unit._val_beast_level
				);

			//================//
			//ELITE DETAILS//
			//================//
			var _flag_inspect_elite =
				variable_instance_exists(
					_ref_source,
					"_flag_elite"
				) &&
				_ref_source._flag_elite;

			if (
				!_flag_inspect_elite &&
				variable_struct_exists(
					_stct_unit,
					"_flag_elite"
				)
			){
				_flag_inspect_elite =
					_stct_unit._flag_elite;
			}

			if (_flag_inspect_elite){
				var _str_elite_modifier = "";

				if (
					variable_instance_exists(
						_ref_source,
						"_str_elite_modifier"
					)
				){
					_str_elite_modifier =
						string_upper(
							string(
								_ref_source._str_elite_modifier
							)
						);
				}
				else if (
					variable_struct_exists(
						_stct_unit,
						"_str_elite_modifier"
					)
				){
					_str_elite_modifier =
						string_upper(
							string(
								_stct_unit._str_elite_modifier
							)
						);
				}

				var _stct_elite_info =
					scr_battle_elite_get_info(
						_str_elite_modifier
					);

				var _str_elite_display_name =
					_str_elite_modifier;

				var _str_elite_display_desc = "";

				if (is_struct(_stct_elite_info)){
					_str_elite_display_name =
						_stct_elite_info
							._str_elite_name;

					_str_elite_display_desc =
						_stct_elite_info
							._str_elite_desc;
				}

				//========================//
				//ACTIVE ELEMENTAL VARIANT//
				//========================//
				if (_str_elite_modifier == "ELEMENTAL"){
					var _str_elemental_variant =
						scr_battle_elite_get_elemental_variant(
							_ref_source
						);

					switch (_str_elemental_variant){
						case "STORM":
							_str_elite_display_name =
								"ELEMENTAL - STORM";
							_str_elite_display_desc =
								"Immune to Stormstruck. Begins Storming Weather.";
						break;

						case "FIRE":
							_str_elite_display_name =
								"ELEMENTAL - FIRE";
							_str_elite_display_desc =
								"Immune to Burn and Char. Begins Firestorm Weather.";
						break;

						case "FROST":
							_str_elite_display_name =
								"ELEMENTAL - FROST";
							_str_elite_display_desc =
								"Immune to Frostbite and Frostburn. Begins Snow Weather.";
						break;

						case "VERDANT":
							_str_elite_display_name =
								"ELEMENTAL - VERDANT";
							_str_elite_display_desc =
								"Immune to Poison. Begins Seedfall Weather.";
						break;
					}
				}

				_str_body +=
					"\n\nELITE: " +
					_str_elite_display_name;

				if (_str_elite_display_desc != ""){
					_str_body +=
						"\n" +
						_str_elite_display_desc;
				}

				//====================//
				//VENGEFUL LIVE BONUS//
				//====================//
				if (_str_elite_modifier == "VENGEFUL"){
					var _ct_vengeful_stacks = 0;

					if (
						variable_struct_exists(
							_stct_unit,
							"_arr_elite_vengeful_counted_death_uids"
						) &&
						is_array(
							_stct_unit
								._arr_elite_vengeful_counted_death_uids
						)
					){
						_ct_vengeful_stacks =
							array_length(
								_stct_unit
									._arr_elite_vengeful_counted_death_uids
							);
					}

					_str_body +=
						"\nVENGEFUL STACKS: " +
						string(_ct_vengeful_stacks) +
						"\nCURRENT BONUS: +" +
						string(_ct_vengeful_stacks * 10) +
						"% PRIMARY STATS";
				}

				//==================//
				//PHASING COUNTDOWN//
				//==================//
				if (_str_elite_modifier == "PHASING"){
					var _ct_phasing_turns_seen = 0;

					if (
						variable_instance_exists(
							_ref_source,
							"_ct_elite_phasing_turns_seen"
						)
					){
						_ct_phasing_turns_seen =
							max(
								0,
								_ref_source
									._ct_elite_phasing_turns_seen
							);
					}

					var _ct_phasing_turns_remaining =
						3 -
						(_ct_phasing_turns_seen mod 3);

					_str_body +=
						"\nPHASING IN: " +
						string(_ct_phasing_turns_remaining) +
						(
							_ct_phasing_turns_remaining == 1
							? " TURN"
							: " TURNS"
						);
				}

				if (
					is_struct(_stct_elite_info) &&
					!_stct_elite_info
						._flag_elite_mechanic_active
				){
					_str_body +=
						"\nMECHANIC: PENDING STEP 6";
				}

				if (
					variable_instance_exists(
						_ref_source,
						"_val_elite_risk_tier"
					)
				){
					_str_body +=
						"\nRISK TIER: " +
						string(
							_ref_source._val_elite_risk_tier
						);
				}

				if (
					variable_struct_exists(
						_stct_unit,
						"_arr_elite_card_ids"
					) &&
					is_array(
						_stct_unit._arr_elite_card_ids
					) &&
					array_length(
						_stct_unit._arr_elite_card_ids
					) > 0
				){
					var _str_elite_cards = "";

					for (
						var _it_elite_card = 0;
						_it_elite_card <
							array_length(
								_stct_unit._arr_elite_card_ids
							);
						_it_elite_card++
					){
						if (_str_elite_cards != ""){
							_str_elite_cards += ", ";
						}

						_str_elite_cards +=
							string_upper(
								string(
									_stct_unit._arr_elite_card_ids[
										_it_elite_card
									]
								)
							);
					}

					_str_body +=
						"\nELITE CARDS: " +
						_str_elite_cards;
				}


				//=========================//
				//SCHOLARLY CURRENT QUEUE//
				//=========================//
				if (
					_str_elite_modifier == "SCHOLARLY" &&
					variable_instance_exists(
						_ref_source,
						"_list_deck"
					) &&
					ds_exists(
						_ref_source._list_deck,
						ds_type_list
					)
				){

					var _ct_queue_deck =
						ds_list_size(
							_ref_source._list_deck
						);

					if (_ct_queue_deck > 0){

						var _it_left =
							clamp(
								_ref_source._val_hand_pos,
								0,
								_ct_queue_deck - 1
							);

						var _it_right =
							(
								_it_left + 1
							)
							mod
							_ct_queue_deck;

						var _str_left_card =
							"NONE";

						var _str_right_card =
							"NONE";

						var _ref_left_card =
							ds_list_find_value(
								_ref_source._list_deck,
								_it_left
							);

						if (
							instance_exists(_ref_left_card) &&
							is_struct(_ref_left_card._ref_card)
						){
							_str_left_card =
								string_upper(
									string(
										_ref_left_card
											._ref_card
											._str_card_name
									)
								);
						}

						if (_ct_queue_deck > 1){

							var _ref_right_card =
								ds_list_find_value(
									_ref_source._list_deck,
									_it_right
								);

							if (
								instance_exists(_ref_right_card) &&
								is_struct(_ref_right_card._ref_card)
							){
								_str_right_card =
									string_upper(
										string(
											_ref_right_card
												._ref_card
												._str_card_name
										)
									);
							}
						}

						_str_body +=
							"\nSCHOLARLY QUEUE: LEFT/1ST - " +
							_str_left_card +
							" | RIGHT/2ND - " +
							_str_right_card;
					}
				}

				if (
					variable_struct_exists(
						_stct_unit,
						"_str_elite_monarch_card_id"
					) &&
					string(
						_stct_unit._str_elite_monarch_card_id
					) !=
					""
				){
					_str_body +=
						"\nMONARCH CARD: " +
						string_upper(
							string(
								_stct_unit
									._str_elite_monarch_card_id
							)
						);
				}
			}

			//==================//
			//CLASS / ARCHETYPE//
			//==================//
			var _str_beast_class =
				"NONE";

			var _str_beast_archetype =
				"NONE";

			if (
				variable_struct_exists(
					_stct_unit,
					"_str_beast_class"
				) &&
				_stct_unit._str_beast_class !=
				undefined
			){

				_str_beast_class =
					string_upper(
						string(
							_stct_unit
								._str_beast_class
						)
					);
			}

			if (
				variable_struct_exists(
					_stct_unit,
					"_str_beast_archetype"
				) &&
				_stct_unit._str_beast_archetype !=
				undefined
			){

				_str_beast_archetype =
					string_upper(
						string(
							_stct_unit
								._str_beast_archetype
						)
					);
			}

			_str_body +=
				"\nARCHETYPE: " +
				_str_beast_archetype + 
				" | CLASS: " +
				_str_beast_class;

			//================//
			//CURRENT STATE//
			//================//
			_str_body +=
				"\nHP: " +
				string(
					_ref_source._val_cur_hp
				) +
				"/" +
				string(
					_ref_source._val_max_hp
				) +
				" | ARMOR: " +
				string(
					_ref_source._val_armor
				);

			if (
				variable_instance_exists(
					_ref_source,
					"_val_overhealth"
				) &&
				_ref_source._val_overhealth > 0
			){

				_str_body +=
					" | OVERHEALTH: " +
					string(
						_ref_source._val_overhealth
					);
			}

			//=====================//
			//DEATH / EXPEND STATE//
			//=====================//
			var _flag_inspect_dead =
				_ref_source._val_cur_hp <= 0 ||
				(
					variable_instance_exists(
						_ref_source,
						"_str_list"
					) &&
					_ref_source._str_list == "DEAD"
				);

			var _flag_inspect_expended =
				variable_instance_exists(
					_ref_source,
					"_flag_corpse_consumed"
				) &&
				_ref_source._flag_corpse_consumed;

			_str_body +=
				"\nDEAD: " +
				(
					_flag_inspect_dead
					? "TRUE"
					: "FALSE"
				) +
				" | EXPENDED: " +
				(
					_flag_inspect_expended
					? "TRUE"
					: "FALSE"
				);

			//================//
			//CORE STATS//
			//================//
			var _val_hp =
				max(
					0,
					_stct_unit._val_beast_hp_stat
				);

			var _val_con =
				max(
					0,
					_stct_unit._val_beast_con_stat
				);

			var _val_ppow =
				max(
					0,
					_stct_unit._val_beast_ppow_stat
				);

			var _val_mpow =
				max(
					0,
					_stct_unit._val_beast_mpow_stat
				);

			var _val_pdef =
				max(
					0,
					_stct_unit._val_beast_pdef_stat
				);

			var _val_mdef =
				max(
					0,
					_stct_unit._val_beast_mdef_stat
				);

			var _val_speed =
				max(
					0,
					scr_battle_get_beast_speed(
						_ref_source
					)
				);

			_str_body +=
				"\nHP STAT: " +
				string(_val_hp) +
				" [" +
				scr_beast_get_stat_grade(_val_hp) +
				"] | CON: " +
				string(_val_con) +
				" [" +
				scr_beast_get_stat_grade(_val_con) +
				"]";

			_str_body +=
				"\nPHYPOW: " +
				string(_val_ppow) +
				" [" +
				scr_beast_get_stat_grade(_val_ppow) +
				"] | MAGPOW: " +
				string(_val_mpow) +
				" [" +
				scr_beast_get_stat_grade(_val_mpow) +
				"]";

			_str_body +=
				"\nPHYDEF: " +
				string(_val_pdef) +
				" [" +
				scr_beast_get_stat_grade(_val_pdef) +
				"] | MAGDEF: " +
				string(_val_mdef) +
				" [" +
				scr_beast_get_stat_grade(_val_mdef) +
				"]";

			_str_body +=
				"\nSPEED: " +
				string(_val_speed) +
				" [" +
				scr_beast_get_stat_grade(_val_speed) +
				"]";

			//==================//
			//SECONDARY STATS//
			//==================//
			_str_body +=
				"\nCRIT: " +
				string(
					_stct_unit._val_beast_crit_stat
				) +
				" | DODGE: " +
				string(
					_stct_unit._val_beast_dod_stat
				) +
				" | MINIONS: " +
				string(
					_stct_unit._val_beast_min_stat
				);

			//================//
			//ABILITY//
			//================//
			_str_body +=
				"\n\nABILITY\n" +
				string(
					_stct_unit._str_beast_ability
				);

			//================//
			//HELD ITEM//
			//================//
			var _str_item =
				"NONE";

			if (
				variable_instance_exists(
					_ref_source,
					"_stct_held_item"
				) &&
				is_struct(
					_ref_source._stct_held_item
				)
			){

				_str_item =
					string(
						_ref_source
							._stct_held_item
							._str_item_name
					);
			}

			_str_body +=
				"\n\nHELD ITEM: " +
				_str_item;

			//================//
			//TALENT TREES//
			//================//
			if (
				variable_struct_exists(
					_stct_unit,
					"_arr_beast_talent_trees"
				) &&
				is_array(
					_stct_unit
						._arr_beast_talent_trees
				)
			){

				var _str_trees = "";

				for (
					var _it_tree = 0;
					_it_tree <
						array_length(
							_stct_unit
								._arr_beast_talent_trees
						);
					_it_tree++
				){

					if (_it_tree > 0){
						_str_trees += ", ";
					}

					_str_trees +=
						string(
							_stct_unit
								._arr_beast_talent_trees[
									_it_tree
								]
						);
				}

				if (_str_trees != ""){

					_str_body +=
						"\nTALENTS: " +
						_str_trees;
				}
			}

		break;

		//=======================================================================//
		// MINION
		//=======================================================================//
		case "MINION":

			if (
				!variable_instance_exists(
					_ref_source,
					"_str_name"
				)
			){
				return false;
			}

			//================//
			//NAME//
			//================//
			_str_name =
				string(
					_ref_source._str_name
				);

			//================//
			//TEAM//
			//================//
			var _str_minion_team =
				"UNKNOWN";

			if (
				variable_instance_exists(
					_ref_source,
					"_str_team"
				)
			){

				_str_minion_team =
					string_upper(
						string(
							_ref_source._str_team
						)
					);
			}

			//================//
			//MINION TAG//
			//================//
			var _str_minion_tag =
				"NONE";

			if (
				variable_instance_exists(
					_ref_source,
					"_str_minion_tag"
				) &&
				_ref_source._str_minion_tag !=
				undefined
			){

				_str_minion_tag =
					string_upper(
						string(
							_ref_source
								._str_minion_tag
						)
					);
			}

			//================//
			//HOST//
			//================//
			var _str_host_name =
				"UNKNOWN";

			if (
				variable_instance_exists(
					_ref_source,
					"_ref_host"
				) &&
				instance_exists(
					_ref_source._ref_host
				) &&
				is_struct(
					_ref_source
						._ref_host
						._ref_unit
				)
			){

				_str_host_name =
					string(
						_ref_source
							._ref_host
							._ref_unit
							._str_beast_name
					);
			}

			_str_body =
				_str_minion_team;

			_str_body +=
				"\nMINION TAG: " +
				_str_minion_tag;

			_str_body +=
				"\nHOST: " +
				string_upper(
					_str_host_name
				);

			_str_body +=
				"\nHP: " +
				string(
					_ref_source._val_cur_hp
				) +
				"/" +
				string(
					_ref_source._val_max_hp
				);

			_str_body +=
				"\nMAGNITUDE: " +
				string(
					_ref_source._val_magnitude
				);

			//================//
			//DORMANT SEED//
			//================//
			if (
				string_upper(
					_ref_source._str_name
				) ==
				"DORMANT SEED" &&
				variable_instance_exists(
					_ref_source,
					"_ct_age"
				)
			){

				_str_body +=
					"\nAGE: " +
					string(
						_ref_source._ct_age
					) +
					" / 2";
			}

		break;

		//=======================================================================//
		// STATUS
		//=======================================================================//
		case "STATUS":

			if (
				!variable_instance_exists(
					_ref_source,
					"_str_status_name"
				)
			){
				return false;
			}

			//================//
			//NAME//
			//================//
			_str_name =
				string(
					_ref_source
						._str_status_name
				);

			//================//
			//HOST//
			//================//
			var _str_status_host =
				"GLOBAL";

			if (
				variable_instance_exists(
					_ref_source,
					"_ref_host"
				) &&
				instance_exists(
					_ref_source._ref_host
				) &&
				is_struct(
					_ref_source
						._ref_host
						._ref_unit
				)
			){

				_str_status_host =
					string(
						_ref_source
							._ref_host
							._ref_unit
							._str_beast_name
					);
			}

			//================//
			//STATUS TYPE//
			//================//
			var _str_status_type =
				"STATUS";

			if (
				variable_instance_exists(
					_ref_source,
					"_str_status_type"
				)
			){

				_str_status_type =
					string(
						_ref_source
							._str_status_type
					);
			}

			_str_body =
				"CATEGORY: " +
				string_upper(
					_str_status_type
				);

			_str_body +=
				"\nHOST: " +
				string_upper(
					_str_status_host
				);

			//================//
			//LIFETIME//
			//================//
			var _str_lifetime =
				"INFINITE";

			if (
				!_ref_source
					._flag_status_infinite
			){

				_str_lifetime =
					string(
						_ref_source
							._val_status_lifetime
					);
			}

			_str_body +=
				"\nLIFETIME: " +
				_str_lifetime +
				" | STACKS: " +
				string(
					_ref_source
						._ct_status_stacks
				);

			//================//
			//TIMING//
			//================//
			var _str_timing =
				"SPECIAL";

			if (
				_ref_source
					._flag_status_infinite
			){

				_str_timing =
					"NEVER";
			}
			else{

				switch(
					_ref_source
						._str_trigger_region
				){

					case "BEGIN":
					case "START":

						_str_timing =
							instance_exists(
								_ref_source._ref_host
							)
							? "HOST START"
							: "PLAYER START";

					break;

					case "END":

						_str_timing =
							instance_exists(
								_ref_source._ref_host
							)
							? "HOST END"
							: "PLAYER END";

					break;
				}
			}

			if (
				_ref_source
					._str_status_name ==
				"BANISH"
			){

				_str_timing =
					"EACH SIDE TURN";
			}

			if (
				_ref_source
					._str_status_name ==
					"REDIRECT" ||
				_ref_source
					._str_status_name ==
					"REDIRECT_GUARD"
			){

				_str_timing =
					"CONSUMED ON REDIRECT";
			}

			_str_body +=
				"\nTIMING: " +
				_str_timing;

			//================//
			//DESCRIPTION//
			//================//
			if (
				variable_instance_exists(
					_ref_source,
					"_str_status_desc"
				)
			){

				_str_body +=
					"\n\n" +
					string(
						_ref_source
							._str_status_desc
					);
			}

			//================//
			//REDIRECT LINK//
			//================//
			if (
				variable_instance_exists(
					_ref_source,
					"_str_redirect_link_label"
				)
			){

				_str_body +=
					"\n\nLINK: [" +
					string(
						_ref_source
							._str_redirect_link_label
					) +
					"]";
			}

		break;

		//=======================================================================//
		// CARD
		//=======================================================================//
		case "CARD":

			//================//
			//VALIDATE CARD//
			//================//
			if (
				!variable_instance_exists(
					_ref_source,
					"_ref_card"
				) ||
				!is_struct(
					_ref_source._ref_card
				)
			){
				return false;
			}

			var _stct_card =
				_ref_source._ref_card;

			//================//
			//NAME//
			//================//
			_str_name =
				string(
					_stct_card._str_card_name
				);

			var _str_enemy_special_source = "";

			if (
				variable_struct_exists(
					_stct_card,
					"_str_enemy_special_card_source"
				)
			){
				_str_enemy_special_source =
					string_upper(
						string(
							_stct_card
								._str_enemy_special_card_source
						)
					);
			}

			//================//
			//COLORS//
			//================//
			var _str_colors = "";

			if (
				variable_struct_exists(
					_stct_card,
					"_arr_card_colors"
				) &&
				is_array(
					_stct_card._arr_card_colors
				)
			){

				for (
					var _it_color = 0;
					_it_color <
						array_length(
							_stct_card
								._arr_card_colors
						);
					_it_color++
				){

					var _str_color =
						_stct_card
							._arr_card_colors[
								_it_color
							];

					if (
						_str_color ==
						undefined
					){
						continue;
					}

					if (
						_str_colors !=
						""
					){
						_str_colors += " / ";
					}

					_str_colors +=
						string_upper(
							string(
								_str_color
							)
						);
				}
			}

			if (_str_colors == ""){
				_str_colors = "UNCOLORED";
			}

			_str_body =
				"COLOR: " +
				_str_colors;

			//================//
			//TYPE / EFFECT//
			//================//
			_str_body +=
				"\nTYPE: " +
				string_upper(
					string(
						_stct_card
							._str_card_type
					)
				) +
				" | EFFECT: " +
				string_upper(
					string(
						_stct_card
							._str_card_effect_type
					)
				);

			//================//
			//STAT / TARGET//
			//================//
			_str_body +=
				"\nSTAT: " +
				string_upper(
					string(
						_stct_card
							._str_card_stat
					)
				) +
				" | TARGET: " +
				string_upper(
					string(
						_stct_card
							._str_card_target_count
					)
				);

			//================//
			//RANGE//
			//================//
			_str_body +=
				"\nRANGE: " +
				string_upper(
					string(
						_stct_card
							._str_card_range
					)
				);

			//================//
			//MANA / RARITY//
			//================//
			_str_body +=
				"\nMANA: " +
				string(
					_stct_card
						._val_card_mana_cost
				) +
				" | RARITY: " +
				string_upper(
					string(
						_stct_card
							._str_card_rarity
					)
				);

			//================//
			//MAGNITUDE//
			//================//
			if (
				variable_struct_exists(
					_stct_card,
					"_val_card_magnitude"
				) &&
				_stct_card
					._val_card_magnitude !=
					undefined
			){

				_str_body +=
					"\nMAGNITUDE: " +
					string(
						_stct_card
							._val_card_magnitude
					);
			}

			//================//
			//SCALAR//
			//================//
			if (
				variable_struct_exists(
					_stct_card,
					"_str_card_scalar"
				) &&
				_stct_card
					._str_card_scalar !=
					undefined
			){

				_str_body +=
					" | SCALAR: " +
					string_upper(
						string(
							_stct_card
								._str_card_scalar
						)
					);
			}

			//================//
			//REQUIREMENTS//
			//================//
			var _str_requirements = "";

			if (
				variable_struct_exists(
					_stct_card,
					"_str_card_archetype_req"
				) &&
				_stct_card
					._str_card_archetype_req !=
					undefined
			){

				_str_requirements +=
					string_upper(
						string(
							_stct_card
								._str_card_archetype_req
						)
					);
			}

			if (
				variable_struct_exists(
					_stct_card,
					"_str_card_class_req"
				) &&
				_stct_card
					._str_card_class_req !=
					undefined
			){

				if (
					_str_requirements !=
					""
				){
					_str_requirements += " / ";
				}

				_str_requirements +=
					string_upper(
						string(
							_stct_card
								._str_card_class_req
						)
					);
			}

			if (
				_str_requirements ==
				""
			){
				_str_requirements = "NONE";
			}

			_str_body +=
				"\nREQUIREMENTS: " +
				_str_requirements;

			if (_str_enemy_special_source != ""){
				_str_body +=
					"\nENEMY SPECIAL: " +
					string_replace_all(
						_str_enemy_special_source,
						"_",
						" "
					);
			}

			//================//
			//EXHAUST//
			//================//
			if (
				variable_struct_exists(
					_stct_card,
					"_flag_card_exhausts"
				)
			){

				_str_body +=
					"\nEXHAUSTS: " +
					(
						_stct_card
							._flag_card_exhausts
						? "YES"
						: "NO"
					);
			}

			//================//
			//DESCRIPTION//
			//================//
			if (
				variable_struct_exists(
					_stct_card,
					"_str_card_description"
				)
			){

				_str_body +=
					"\n\nDESCRIPTION\n" +
					string(
						_stct_card
							._str_card_description
					);
			}

		break;

		//=======================================================================//
		// INVALID
		//=======================================================================//
		default:

			return false;
	}

	//================//
	//REGISTER//
	//================//
	global.flag_battle_inspection =
		true;

	global.str_battle_inspection_title =
		string_upper(
			string(
				_str_name
			)
		) +
		" - " +
		_str_type_upper;

	global.str_battle_inspection_body =
		string(
			_str_body
		);

	global.val_battle_inspection_priority =
		_val_priority;

	return true;

}
