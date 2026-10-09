//===============================================================================//
//
// STEP: OBJ_GUI_CHEATS_PANE
// FUNCTION: Handles Cheats Menu input.
//           Supports authentication, tab navigation, pagination,
//           mouse-wheel pagination, and active targeting tools.
//
//===============================================================================//

//================//
//RESET CLICK CLAIM//
//================//
// Step runs before Draw GUI End.
//
// Any targeting click claimed here remains consumed for the rest of this frame,
// preventing the Cheats menu from reopening underneath the mouse and processing
// the same physical click a second time.
_flag_left_click_consumed =
	false;

//================//
//INPUT LOCKOUT//
//================//
if (_ct_input_lockout > 0){

	_ct_input_lockout--;

	exit;
}

//===============================================================================//
// PASSWORD
//===============================================================================//
#region PASSWORD

if (_flag_password_entry){

//----------------//
//ENTER//
//----------------//
	if (
		keyboard_check_pressed(
			vk_enter
		)
	){

		hscr_cheats_submit_password();

		exit;
	}

	exit;
}

#endregion

//===============================================================================//
// VALIDATE AUTHENTICATION
//===============================================================================//

if (!_flag_authenticated){
	exit;
}

//===============================================================================//
// MENU CLOSE
//===============================================================================//
/*
	Right-click closes the Cheats pane while browsing the menu.
	Tool mode keeps its existing right-click behavior and cancels only the active
	targeting tool, returning to the Cheats menu instead of closing the pane.
*/
if (
	_str_state != "TOOL" &&
	mouse_check_button_pressed(
		mb_right
	)
){

	audio_play_sound(
		snd_gui_close,
		0,
		false
	);

	if (instance_exists(obj_gui_controller)){

		obj_gui_controller.hscr_gui_destroy_active(
			"CHEATS RMB"
		);

		obj_gui_controller.hscr_gui_set_pause(
			false,
			"CHEATS RMB"
		);
	}
	else{

		if (
			variable_global_exists(
				"ref_active_gui"
			) &&
			global.ref_active_gui == id
		){
			global.ref_active_gui = undefined;
		}

		global.flag_pause = false;

		instance_destroy();
	}

	exit;
}

//===============================================================================//
// TOOL MODE
//===============================================================================//
#region TOOL MODE

if (_str_state == "TOOL"){

//================//
//CANCEL TOOL//
//================//
	if (
		mouse_check_button_pressed(
			mb_right
		)
	){

		hscr_cheats_cancel_tool();

		exit;
	}

//========================//
//SIMULATED CARD CASTING//
//========================//
	if (
		_str_tool == "SIMULATED_CAST" &&
		(
			_str_tool_target_type == "SIMULATED_CARD_CASTER" ||
			_str_tool_target_type == "SIMULATED_CARD_BEAST_TARGET" ||
			_str_tool_target_type == "SIMULATED_CARD_CORPSE_TARGET" ||
			_str_tool_target_type == "SIMULATED_CARD_CARD_TARGET"
		)
	){

		if (!hscr_cheats_take_left_click()){
			exit;
		}

		var _val_sim_mouse_x = device_mouse_x_to_gui(0);
		var _val_sim_mouse_y = device_mouse_y_to_gui(0);

		//================//
		//GET CARD DATA//
		//================//
		var _stct_sim_card =
			scr_card_get_info(
				_str_selected_id
			);

		if (
			!is_struct(_stct_sim_card) ||
			_stct_sim_card._str_card_name == "DEFAULT"
		){
			hscr_cheats_error(
				"SIMULATED CAST FAILED",
				"INVALID CARD: " + string_upper(_str_selected_id)
			);
			exit;
		}

		//================//
		//SELECT CASTER//
		//================//
		if (_str_tool_target_type == "SIMULATED_CARD_CASTER"){

			var _ref_sim_caster =
				instance_position(
					_val_sim_mouse_x,
					_val_sim_mouse_y,
					obj_battle_beast
				);

			var _str_caster_failure =
				hscr_cheats_validate_simulated_caster(
					_stct_sim_card,
					_ref_sim_caster
				);

			if (_str_caster_failure != ""){
				hscr_cheats_error(
					"SIMULATED CASTER REJECTED",
					_str_caster_failure
				);
				exit;
			}

			_ref_simulated_caster = _ref_sim_caster;

			var _str_sim_range =
				string_upper(
					string(_stct_sim_card._str_card_range)
				);

			//----------------//
			//IMMEDIATE TARGETS//
			//----------------//
			if (
				_str_sim_range == "SELF" ||
				_str_sim_range == "GLOBAL"
			){
				var _ref_immediate_target =
					(_str_sim_range == "SELF")
					? _ref_simulated_caster
					: "GLOBAL";

				var _flag_cast =
					scr_battle_cast_simulated_card(
						_str_selected_id,
						_ref_simulated_caster,
						_ref_immediate_target
					);

				if (!_flag_cast){
					hscr_cheats_error(
						"SIMULATED CAST FAILED",
						"CARD: " + string_upper(_str_selected_id)
					);
				}

				_ref_simulated_caster = undefined;
				_str_tool_target_type = "SIMULATED_CARD_CASTER";
				_str_tool_label =
					"CAST " + string_upper(_str_selected_id) + ": SELECT CASTER";
				exit;
			}

			//----------------//
			//OPTIONAL CORPSE//
			//----------------//
			if (
				_str_sim_range == "CORPSE_OPTIONAL" &&
				!scr_battle_has_corpse()
			){
				var _flag_cast =
					scr_battle_cast_simulated_card(
						_str_selected_id,
						_ref_simulated_caster,
						undefined
					);

				if (!_flag_cast){
					hscr_cheats_error(
						"SIMULATED CAST FAILED",
						"CARD: " + string_upper(_str_selected_id)
					);
				}

				_ref_simulated_caster = undefined;
				_str_tool_target_type = "SIMULATED_CARD_CASTER";
				_str_tool_label =
					"CAST " + string_upper(_str_selected_id) + ": SELECT CASTER";
				exit;
			}

			//----------------//
			//TARGET MODE//
			//----------------//
			if (
				_str_sim_range == "CORPSE" ||
				_str_sim_range == "CORPSE_OPTIONAL"
			){
				_str_tool_target_type = "SIMULATED_CARD_CORPSE_TARGET";
				_str_tool_label =
					"CAST " + string_upper(_str_selected_id) + ": SELECT CORPSE";
			}
			else if (_str_sim_range == "ENEMY_CARD"){
				_str_tool_target_type = "SIMULATED_CARD_CARD_TARGET";
				_str_tool_label =
					"CAST " + string_upper(_str_selected_id) + ": SELECT CARD";
			}
			else{
				_str_tool_target_type = "SIMULATED_CARD_BEAST_TARGET";
				_str_tool_label =
					"CAST " + string_upper(_str_selected_id) + ": SELECT TARGET";
			}

			audio_play_sound(snd_gui_press,0,false);
			exit;
		}

		//================//
		//VALIDATE STORED CASTER//
		//================//
		if (!instance_exists(_ref_simulated_caster)){
			hscr_cheats_error(
				"SIMULATED CAST FAILED",
				"CASTER NO LONGER EXISTS"
			);

			_ref_simulated_caster = undefined;
			_str_tool_target_type = "SIMULATED_CARD_CASTER";
			_str_tool_label =
				"CAST " + string_upper(_str_selected_id) + ": SELECT CASTER";
			exit;
		}

		//================//
		//SELECT BEAST TARGET//
		//================//
		if (_str_tool_target_type == "SIMULATED_CARD_BEAST_TARGET"){

			var _ref_sim_target =
				instance_position(
					_val_sim_mouse_x,
					_val_sim_mouse_y,
					obj_battle_beast
				);

			if (
				!instance_exists(_ref_sim_target) ||
				_ref_sim_target._str_list != "ALIVE" ||
				_ref_sim_target._val_cur_hp <= 0
			){
				hscr_cheats_error(
					"SIMULATED TARGET REJECTED",
					"SELECT A LIVING BATTLE BEAST"
				);
				exit;
			}

			var _flag_cast =
				scr_battle_cast_simulated_card(
					_str_selected_id,
					_ref_simulated_caster,
					_ref_sim_target
				);

			if (!_flag_cast){
				hscr_cheats_error(
					"SIMULATED CAST REJECTED",
					"TARGET DOES NOT SATISFY CARD RULES"
				);
				exit;
			}
		}

		//================//
		//SELECT CORPSE TARGET//
		//================//
		else if (_str_tool_target_type == "SIMULATED_CARD_CORPSE_TARGET"){

			var _ref_sim_target =
				instance_position(
					_val_sim_mouse_x,
					_val_sim_mouse_y,
					obj_battle_beast
				);

			if (
				!instance_exists(_ref_sim_target) ||
				_ref_sim_target._str_list != "DEAD" ||
				_ref_sim_target._val_cur_hp > 0
			){
				hscr_cheats_error(
					"SIMULATED TARGET REJECTED",
					"SELECT A VALID CORPSE"
				);
				exit;
			}

			var _flag_cast =
				scr_battle_cast_simulated_card(
					_str_selected_id,
					_ref_simulated_caster,
					_ref_sim_target
				);

			if (!_flag_cast){
				hscr_cheats_error(
					"SIMULATED CAST REJECTED",
					"CORPSE DOES NOT SATISFY CARD RULES"
				);
				exit;
			}
		}

		//================//
		//SELECT CARD TARGET//
		//================//
		else if (_str_tool_target_type == "SIMULATED_CARD_CARD_TARGET"){

			var _ref_sim_target =
				instance_position(
					_val_sim_mouse_x,
					_val_sim_mouse_y,
					obj_battle_card
				);

			if (
				!instance_exists(_ref_sim_target) ||
				!_ref_sim_target.visible ||
				_ref_sim_target._str_location != "HAND" ||
				!is_struct(_ref_sim_target._ref_card)
			){
				hscr_cheats_error(
					"SIMULATED TARGET REJECTED",
					"SELECT A VISIBLE HAND CARD"
				);
				exit;
			}

			var _flag_cast =
				scr_battle_cast_simulated_card(
					_str_selected_id,
					_ref_simulated_caster,
					_ref_sim_target
				);

			if (!_flag_cast){
				hscr_cheats_error(
					"SIMULATED CAST REJECTED",
					"CARD TARGET DOES NOT SATISFY CARD RULES"
				);
				exit;
			}
		}

		//========================//
		//KEEP TOOL OPEN FOR REUSE//
		//========================//
		_ref_simulated_caster = undefined;
		_str_tool_target_type = "SIMULATED_CARD_CASTER";
		_str_tool_label =
			"CAST " + string_upper(_str_selected_id) + ": SELECT CASTER";

		exit;
	}

//================//
//WORLD POSITION//
//================//
// World-position tools intentionally do NOT consume
// navigation/scroll input here.
//
// This allows the player to move/scroll the camera while
// positioning a world-space cheat such as SPAWN WILD BEAST.
	if (
		_str_tool_target_type ==
		"WORLD_POSITION"
	){

		if (
			hscr_cheats_take_left_click()
		){

			switch (_str_tool){

//----------------//
//SPAWN WILD//
//----------------//
				case "SPAWN_WILD":

					hscr_cheats_spawn_wild(
						_str_selected_id,
						false
					);

				break;

//----------------//
//SPAWN ELITE//
//----------------//
				case "SPAWN_ELITE":

					hscr_cheats_spawn_wild(
						_str_selected_id,
						true
					);

				break;

//----------------//
//CLICK TELEPORT//
//----------------//
				case "CLICK_TELEPORT":

					hscr_cheats_teleport_player_to_mouse();

				break;
			}
		}

		exit;
	}

//====================//
//BATTLE BEAST PAIR//
//====================//
	if (
		_str_tool_target_type ==
		"BATTLE_BEAST_PAIR"
	){

		if (
			hscr_cheats_take_left_click()
		){

			var _val_swap_mouse_x =
				device_mouse_x_to_gui(0);

			var _val_swap_mouse_y =
				device_mouse_y_to_gui(0);

			var _ref_swap_target =
				instance_position(
					_val_swap_mouse_x,
					_val_swap_mouse_y,
					obj_battle_beast
				);

//================//
//INVALID TARGET//
//================//
			if (
				!instance_exists(
					_ref_swap_target
				) ||
				_ref_swap_target.object_index !=
					obj_battle_beast ||
				_ref_swap_target._str_list !=
					"ALIVE" ||
				_ref_swap_target._val_cur_hp <=
					0
			){

				hscr_cheats_error(
					"BATTLE REPOSITION FAILED",
					"SELECT A LIVING BATTLE BEAST"
				);

				exit;
			}

//================//
//FIRST SELECTION//
//================//
			if (
				!instance_exists(
					_ref_swap_first
				)
			){

				_ref_swap_first =
					_ref_swap_target;

				var _str_swap_first_name =
					"BEAST";

				if (
					is_struct(
						_ref_swap_first._ref_unit
					)
				){
					_str_swap_first_name =
						string_upper(
							_ref_swap_first
								._ref_unit
								._str_beast_name
						);
				}

				_str_tool_label =
					"REPOSITION: SELECT SECOND [" +
					string_upper(
						_ref_swap_first._str_team
					) +
					"]";

				audio_play_sound(
					snd_gui_press,
					0,
					false
				);

				hscr_cheats_log(
					"BATTLE REPOSITION FIRST SELECTED",
					"TEAM: " +
					string_upper(
						_ref_swap_first._str_team
					) +
					" | BEAST: " +
					_str_swap_first_name
				);

				exit;
			}

//================//
//SAME BEAST//
//================//
			if (
				_ref_swap_target ==
				_ref_swap_first
			){

				hscr_cheats_error(
					"BATTLE REPOSITION FAILED",
					"SAME BEAST SELECTED TWICE"
				);

				scr_gui_spawn_popup_banner(
					"SELECT A DIFFERENT BEAST"
				);

				exit;
			}

//================//
//OPPOSITE TEAMS//
//================//
			if (
				_ref_swap_target._str_team !=
				_ref_swap_first._str_team
			){

				hscr_cheats_error(
					"BATTLE REPOSITION FAILED",
					"OPPOSITE TEAMS" +
					" | FIRST: " +
					string_upper(
						_ref_swap_first._str_team
					) +
					" | SECOND: " +
					string_upper(
						_ref_swap_target._str_team
					)
				);

				scr_gui_spawn_popup_banner(
					"REPOSITION REQUIRES SAME TEAM"
				);

				exit;
			}

//================//
//SWAP BEASTS//
//================//
			if (
				scr_battle_swap_beast_positions(
					_ref_swap_first,
					_ref_swap_target,
					"OBJ_GUI_CHEATS_PANE:STEP"
				)
			){

				audio_play_sound(
					snd_gui_press,
					0,
					false
				);

				_ref_swap_first =
					undefined;

				_str_tool_label =
					"REPOSITION: SELECT FIRST BEAST";
			}
			else{

				hscr_cheats_error(
					"BATTLE REPOSITION FAILED",
					"FORMATION REPOSITION REJECTED"
				);
			}
		}

		exit;
	}

//================//
//BATTLE STATUS//
//================//
	if (
		_str_tool_target_type ==
		"BATTLE_STATUS"
	){

		if (hscr_cheats_take_left_click()){

			var _val_status_mouse_x = device_mouse_x_to_gui(0);
			var _val_status_mouse_y = device_mouse_y_to_gui(0);

			var _ref_status_target = instance_position(
				_val_status_mouse_x,
				_val_status_mouse_y,
				obj_battle_status
			);

			if (
				!instance_exists(_ref_status_target) ||
				_ref_status_target.object_index != obj_battle_status
			){
				hscr_cheats_error("STATUS TARGET FAILED","CLICK A STATUS ICON");
				exit;
			}

			switch (_str_tool){
				case "STATUS_CLEANSE_CLICK":
					hscr_cheats_cleanse_status_instance(_ref_status_target);
				break;

				case "STATUS_STACK_ADD":
					hscr_cheats_add_status_stack(_ref_status_target);
				break;

				case "STATUS_STACK_REMOVE":
					hscr_cheats_remove_status_stack(_ref_status_target);
				break;

				case "STATUS_REFRESH":
					hscr_cheats_refresh_status_duration(_ref_status_target);
				break;

				case "STATUS_DURATION_ADD":
					hscr_cheats_adjust_status_duration(_ref_status_target,1);
				break;

				case "STATUS_DURATION_REMOVE":
					hscr_cheats_adjust_status_duration(_ref_status_target,-1);
				break;
			}
		}

		exit;
	}

//================//
//BATTLE MINION//
//================//
	if (
		_str_tool_target_type ==
		"BATTLE_MINION"
	){

		if (hscr_cheats_take_left_click()){

			var _ref_minion_target = instance_position(
				device_mouse_x(0),
				device_mouse_y(0),
				obj_battle_minion
			);

			if (
				!instance_exists(_ref_minion_target) ||
				_ref_minion_target.object_index != obj_battle_minion
			){
				hscr_cheats_error("MINION TARGET FAILED","CLICK A MINION");
				exit;
			}

			switch (_str_tool){

				case "REPLACE_MINION":
					hscr_cheats_replace_minion(
						_ref_minion_target,
						_str_selected_id
					);
				break;

				case "MINION_HP_REMOVE":
					hscr_cheats_adjust_minion_health(
						_ref_minion_target,
						-1
					);
				break;

				case "MINION_HP_ADD":
					hscr_cheats_adjust_minion_health(
						_ref_minion_target,
						1
					);
				break;

				case "MINION_MAG_REMOVE":
					hscr_cheats_adjust_minion_magnitude(
						_ref_minion_target,
						-1
					);
				break;

				case "MINION_MAG_ADD":
					hscr_cheats_adjust_minion_magnitude(
						_ref_minion_target,
						1
					);
				break;
			}
		}

		exit;
	}

//===================//
//BATTLE STAT TARGET//
//===================//
	if (
		_str_tool_target_type ==
		"BATTLE_BEAST_STAT"
	){

		if (hscr_cheats_take_left_click()){
			var _ref_stat_target = instance_position(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				obj_battle_beast
			);

			if (
				!instance_exists(_ref_stat_target) ||
				_ref_stat_target.object_index != obj_battle_beast
			){
				hscr_cheats_error("STAT EDIT FAILED","CLICK A BATTLE BEAST");
				exit;
			}

			var _it_stat_sep = string_pos("|",_str_selected_id);
			if (_it_stat_sep <= 0){
				hscr_cheats_error("STAT EDIT FAILED","INVALID STAT COMMAND");
				exit;
			}

			var _str_stat_id = string_copy(
				_str_selected_id,
				1,
				_it_stat_sep - 1
			);

			var _str_delta = string_copy(
				_str_selected_id,
				_it_stat_sep + 1,
				string_length(_str_selected_id)
			);

			var _val_stat_delta = real(_str_delta);

			hscr_cheats_adjust_battle_stat(
				_ref_stat_target,
				_str_stat_id,
				_val_stat_delta
			);
		}

		exit;
	}

//================//
//BATTLE UNIT//
//================//
	if (
		_str_tool_target_type ==
		"BATTLE_UNIT"
	){

		if (
			hscr_cheats_take_left_click()
		){

			var _ref_target =
				hscr_cheats_get_battle_target(
					true
				);

			if (
				!instance_exists(
					_ref_target
				)
			){

				audio_play_sound(
					snd_gui_error,
					0,
					false
				);

				exit;
			}

			switch (_str_tool){

//----------------//
//HEAL +1//
//----------------//
				case "HEAL_1":

					hscr_cheats_battle_heal(
						_ref_target,
						1
					);

				break;

//----------------//
//HEAL +10//
//----------------//
				case "HEAL_10":

					hscr_cheats_battle_heal(
						_ref_target,
						10
					);

				break;

//----------------//
//HEAL FULL//
//----------------//
				case "HEAL_FULL":

					hscr_cheats_battle_heal(
						_ref_target,
						-1
					);

				break;

//----------------//
//DAMAGE -1//
//----------------//
				case "DAMAGE_1":

					hscr_cheats_battle_damage(
						_ref_target,
						1
					);

				break;

//----------------//
//DAMAGE -10//
//----------------//
				case "DAMAGE_10":

					hscr_cheats_battle_damage(
						_ref_target,
						10
					);

				break;

//----------------//
//KILL//
//----------------//
				case "KILL":

					hscr_cheats_battle_damage(
						_ref_target,
						-1
					);

				break;

//----------------//
//RESURRECT//
//----------------//
				case "RESURRECT":

					hscr_cheats_resurrect(
						_ref_target
					);

				break;

//----------------//
//LEVEL +1//
//----------------//
				case "LEVEL_1":

					hscr_cheats_battle_level(
						_ref_target,
						1
					);

				break;

//----------------//
//LEVEL +5//
//----------------//
				case "LEVEL_5":

					hscr_cheats_battle_level(
						_ref_target,
						5
					);

				break;

//----------------//
//LEVEL -1//
//----------------//
				case "LEVEL_MINUS_1":

					hscr_cheats_battle_level(
						_ref_target,
						-1
					);

				break;

//----------------//
//LEVEL -5//
//----------------//
				case "LEVEL_MINUS_5":

					hscr_cheats_battle_level(
						_ref_target,
						-5
					);

				break;

//----------------//
//ELITE SET//
//----------------//
				case "ELITE_SET":

					//==================//
					//VALID ENEMY BEAST//
					//==================//
					if (
						_ref_target.object_index !=
							obj_battle_beast ||
						_ref_target._str_team !=
							"ENEMY" ||
						_ref_target._str_list !=
							"ALIVE" ||
						_ref_target._val_cur_hp <=
							0
					){

						hscr_cheats_error(
							"ELITE PROMOTION FAILED",
							"SELECT A LIVING ENEMY BEAST"
						);

						scr_gui_spawn_popup_banner(
							"SELECT A LIVING ENEMY BEAST"
						);

						exit;
					}

					//===================//
					//PARSE MODIFIER ID//
					//===================//
					var _str_elite_selection =
						string_upper(
							string(
								_str_selected_id
							)
						);

					var _str_elite_modifier =
						_str_elite_selection;

					var _str_elemental_variant =
						"";

					var _it_element_separator =
						string_pos(
							"|",
							_str_elite_selection
						);

					if (
						_it_element_separator >
						0
					){

						_str_elite_modifier =
							string_copy(
								_str_elite_selection,
								1,
								_it_element_separator -
								1
							);

						_str_elemental_variant =
							string_copy(
								_str_elite_selection,
								_it_element_separator +
								1,
								string_length(
									_str_elite_selection
								)
							);
					}

					//===================//
					//VALIDATE MODIFIER//
					//===================//
					if (
						!array_contains(
							_arr_cheat_elite_modifiers,
							_str_elite_modifier
						)
					){

						hscr_cheats_error(
							"ELITE PROMOTION FAILED",
							"INVALID MODIFIER: " +
							_str_elite_modifier
						);

						scr_gui_spawn_popup_banner(
							"INVALID ELITE MODIFIER"
						);

						exit;
					}

					//====================//
					//VALIDATE ELEMENTAL//
					//====================//
					if (
						_str_elite_modifier ==
							"ELEMENTAL" &&
						_str_elemental_variant !=
							"STORM" &&
						_str_elemental_variant !=
							"FIRE" &&
						_str_elemental_variant !=
							"FROST" &&
						_str_elemental_variant !=
							"VERDANT"
					){

						hscr_cheats_error(
							"ELITE PROMOTION FAILED",
							"ELEMENTAL REQUIRES A TEST VARIANT"
						);

						scr_gui_spawn_popup_banner(
							"SELECT AN ELEMENTAL VARIANT"
						);

						exit;
					}

					//==================//
					//PROMOTE / CHANGE//
					//==================//
					if (
						hscr_cheats_set_elite_modifier(
							_ref_target,
							_str_elite_modifier,
							_str_elemental_variant
						)
					){

						audio_play_sound(
							snd_gui_press,
							0,
							false
						);

						var _str_elite_banner =
							"ELITE: " +
							_str_elite_modifier;

						if (
							_str_elemental_variant !=
								""
						){

							_str_elite_banner +=
								" - " +
								_str_elemental_variant;
						}

						scr_gui_spawn_popup_trigger_banner(
							_str_elite_banner
						);

						/*
							ELITE_SET intentionally remains in TOOL state.

							The selected modifier / Elemental variant can therefore
							be applied repeatedly to living enemy Beasts.

							RMB returns to the Cheats menu.

							Do NOT call HSCR_CHEATS_FINISH_TOOL here.
						*/
						exit;
					}

					//================//
					//FAILED MUTATION//
					//================//
					hscr_cheats_error(
						"ELITE PROMOTION FAILED",
						"BEAST: " +
						string_upper(
							_ref_target
								._ref_unit
								._str_beast_name
						) +
						" | MODIFIER: " +
						_str_elite_modifier +
						(
							_str_elemental_variant !=
								""
							? " | ELEMENT: " +
								_str_elemental_variant
							: ""
						)
					);

					scr_gui_spawn_popup_banner(
						"ELITE CHANGE FAILED"
					);

					exit;

				break;

//----------------//
//ELITE RISK TIER//
//----------------//
				case "ELITE_RISK_SET":

					//==================//
					//VALID ENEMY ELITE//
					//==================//
					if (
						_ref_target.object_index !=
							obj_battle_beast ||
						_ref_target._str_team !=
							"ENEMY" ||
						_ref_target._str_list !=
							"ALIVE" ||
						_ref_target._val_cur_hp <=
							0 ||
						!is_struct(
							_ref_target._ref_unit
						) ||
						!variable_struct_exists(
							_ref_target._ref_unit,
							"_flag_elite"
						) ||
						!_ref_target
							._ref_unit
							._flag_elite
					){

						hscr_cheats_error(
							"ELITE RISK CHANGE FAILED",
							"SELECT A LIVING ENEMY ELITE"
						);

						scr_gui_spawn_popup_banner(
							"SELECT A LIVING ENEMY ELITE"
						);

						exit;
					}

					var _val_target_risk_tier =
						-1;

					switch (
						string(
							_str_selected_id
						)
					){

						case "0":

							_val_target_risk_tier =
								0;

						break;

						case "1":

							_val_target_risk_tier =
								1;

						break;
					}

					if (
						_val_target_risk_tier <
						0
					){

						hscr_cheats_error(
							"ELITE RISK CHANGE FAILED",
							"INVALID RISK TIER: " +
							string(
								_str_selected_id
							)
						);

						exit;
					}

					if (
						hscr_cheats_set_elite_risk_tier(
							_ref_target,
							_val_target_risk_tier
						)
					){

						audio_play_sound(
							snd_gui_press,
							0,
							false
						);

						scr_gui_spawn_popup_trigger_banner(
							"ELITE RISK TIER: " +
							string(
								_val_target_risk_tier
							)
						);

						hscr_cheats_finish_tool();

						exit;
					}

					hscr_cheats_error(
						"ELITE RISK CHANGE FAILED",
						"BEAST: " +
						string_upper(
							_ref_target
								._ref_unit
								._str_beast_name
						) +
						" | TARGET TIER: " +
						string(
							_val_target_risk_tier
						)
					);

					scr_gui_spawn_popup_banner(
						"ELITE RISK CHANGE FAILED"
					);

					exit;

				break;

//----------------//
//ELITE DEMOTE//
//----------------//
				case "ELITE_DEMOTE":

					//==================//
					//VALID ENEMY ELITE//
					//==================//
					if (
						_ref_target.object_index !=
							obj_battle_beast ||
						_ref_target._str_team !=
							"ENEMY" ||
						!is_struct(
							_ref_target._ref_unit
						) ||
						!variable_struct_exists(
							_ref_target._ref_unit,
							"_flag_elite"
						) ||
						!_ref_target
							._ref_unit
							._flag_elite
					){

						hscr_cheats_error(
							"ELITE DEMOTION FAILED",
							"SELECT AN ENEMY ELITE"
						);

						scr_gui_spawn_popup_banner(
							"SELECT AN ENEMY ELITE"
						);

						exit;
					}

					//==========//
					//DEMOTE//
					//==========//
					if (
						hscr_cheats_demote_elite(
							_ref_target
						)
					){

						audio_play_sound(
							snd_gui_press,
							0,
							false
						);

						scr_gui_spawn_popup_trigger_banner(
							"ELITE DEMOTED"
						);

						hscr_cheats_finish_tool();

						exit;
					}

					//================//
					//FAILED DEMOTION//
					//================//
					hscr_cheats_error(
						"ELITE DEMOTION FAILED",
						"BEAST: " +
						string_upper(
							_ref_target
								._ref_unit
								._str_beast_name
						)
					);

					scr_gui_spawn_popup_banner(
						"ELITE DEMOTION FAILED"
					);

					exit;

				break;

//----------------//
//CHANGE BEAST//
//----------------//
				case "CHANGE_BEAST":

					//=====================//
					//RESOLVE ENEMY BEAST//
					//=====================//
					/*
						The generic battle-target helper prioritizes Minions.

						CHANGE BEAST specifically targets Beasts, so resolve the
						Beast hitbox directly when a Minion overlaps the cursor.
					*/
					var _ref_change_target =
						_ref_target;

					if (
						!instance_exists(
							_ref_change_target
						) ||
						_ref_change_target.object_index !=
							obj_battle_beast
					){

						_ref_change_target =
							instance_position(
								device_mouse_x_to_gui(
									0
								),
								device_mouse_y_to_gui(
									0
								),
								obj_battle_beast
							);
					}

					//==================//
					//VALID ENEMY BEAST//
					//==================//
					if (
						!instance_exists(
							_ref_change_target
						) ||
						_ref_change_target.object_index !=
							obj_battle_beast ||
						_ref_change_target._str_team !=
							"ENEMY" ||
						_ref_change_target._str_list !=
							"ALIVE" ||
						_ref_change_target._val_cur_hp <=
							0
					){

						hscr_cheats_error(
							"BEAST CHANGE FAILED",
							"SELECT A LIVING ENEMY BEAST"
						);

						scr_gui_spawn_popup_banner(
							"SELECT A LIVING ENEMY BEAST"
						);

						exit;
					}

					//================//
					//CHANGE BEAST//
					//================//
					if (
						hscr_cheats_change_enemy_beast(
							_ref_change_target,
							_str_selected_id
						)
					){

						audio_play_sound(
							snd_gui_press,
							0,
							false
						);

						scr_gui_spawn_popup_trigger_banner(
							"CHANGED TO: " +
							string_upper(
								_ref_change_target
									._ref_unit
									._str_beast_name
							)
						);

						/*
							Intentionally remain in TOOL state so the selected
							Beast can be applied repeatedly.

							RMB returns to Cheats.
						*/
						exit;
					}

					hscr_cheats_error(
						"BEAST CHANGE FAILED",
						"TARGET: " +
						string_upper(
							_ref_change_target
								._ref_unit
								._str_beast_name
						) +
						" | SELECTED ID: " +
						string_upper(
							string(
								_str_selected_id
							)
						)
					);

					scr_gui_spawn_popup_banner(
						"BEAST CHANGE FAILED"
					);

					exit;

				break;

//----------------//
//STATUS//
//----------------//
				case "STATUS":

					var _it_separator =
						string_pos(
							"|",
							_str_selected_id
						);

					if (
						_it_separator >
						0
					){

						var _str_category =
							string_copy(
								_str_selected_id,
								1,
								_it_separator -
								1
							);

						var _str_status =
							string_copy(
								_str_selected_id,
								_it_separator +
								1,
								string_length(
									_str_selected_id
								)
							);

						hscr_cheats_apply_status(
							_ref_target,
							_str_category,
							_str_status
						);
					}

				break;

//----------------//
//CLEANSE//
//----------------//
				case "CLEANSE":

					var _it_separator_1 =
						string_pos(
							"|",
							_str_selected_id
						);

					if (
						_it_separator_1 >
						0
					){

						var _str_remainder =
							string_copy(
								_str_selected_id,
								_it_separator_1 +
								1,
								string_length(
									_str_selected_id
								)
							);

						var _it_separator_2 =
							string_pos(
								"|",
								_str_remainder
							);

						if (
							_it_separator_2 >
							0
						){

							var _str_cleanse_filter =
								string_copy(
									_str_selected_id,
									1,
									_it_separator_1 -
									1
								);

							var _str_cleanse_mode =
								string_copy(
									_str_remainder,
									1,
									_it_separator_2 -
									1
								);

							var _str_cleanse_amount =
								string_copy(
									_str_remainder,
									_it_separator_2 +
									1,
									string_length(
										_str_remainder
									)
								);

							var _var_cleanse_amount =
								(
									_str_cleanse_amount ==
									"ALL"
								)
								? "ALL"
								: real(
									_str_cleanse_amount
								);

							hscr_cheats_cleanse(
								_ref_target,
								_str_cleanse_filter,
								_str_cleanse_mode,
								_var_cleanse_amount
							);
						}
					}

				break;

//----------------//
//SPAWN MINION//
//----------------//
				case "SPAWN_MINION":

					hscr_cheats_spawn_minion(
						_ref_target,
						_str_selected_id
					);

				break;
			}
		}

		exit;
	}

//================//
//BATTLE CARD//
//================//
	if (
		_str_tool_target_type ==
		"BATTLE_CARD"
	){

//================//
//LEFT CLICK//
//================//
		if (
			hscr_cheats_take_left_click()
		){

//----------------//
//GET HOVERED CARD//
//----------------//
			var _ref_card =
				scr_battle_get_hovered_hand_card();

//----------------//
//INVALID TARGET//
//----------------//
			if (
				!instance_exists(
					_ref_card
				)
			){

				hscr_cheats_error(
					"CARD TARGET FAILED",
					"NO PLAYER HAND CARD UNDER MOUSE"
				);

				exit;
			}

//================//
//RESOLVE TOOL//
//================//
			switch (_str_tool){

//----------------//
//DISCARD CARD//
//----------------//
				case "DISCARD_CARD":

					hscr_cheats_move_hand_card(
						_ref_card,
						"DISCARD"
					);

				break;

//----------------//
//EXHAUST CARD//
//----------------//
				case "EXHAUST_CARD":

					hscr_cheats_move_hand_card(
						_ref_card,
						"EXHAUST"
					);

				break;

//----------------//
//INVALID TOOL//
//----------------//
				default:

					hscr_cheats_error(
						"CARD TOOL FAILED",
						"UNKNOWN TOOL: " +
						string_upper(
							_str_tool
						)
					);

				break;
			}
		}

		exit;
	}

	exit;
}

#endregion

//===============================================================================//
// MENU NAVIGATION
//===============================================================================//
#region MENU NAVIGATION

//================//
//TAB NAVIGATION//
//================//

//----------------//
//LEFT TAB//
// LEFT ARROW / A
//----------------//
if (
	keyboard_check_pressed(
		vk_left
	) ||
	keyboard_check_pressed(
		ord("A")
	)
){

	hscr_cheats_change_tab(
		-1
	);

	exit;
}

//----------------//
//RIGHT TAB//
// RIGHT ARROW / D
//----------------//
if (
	keyboard_check_pressed(
		vk_right
	) ||
	keyboard_check_pressed(
		ord("D")
	)
){

	hscr_cheats_change_tab(
		1
	);

	exit;
}

//===============================================================================//
// DETERMINE PAGE COUNT
//===============================================================================//

var _ct_page_entries =
	0;

var _ct_page_rows =
	_ct_rows_per_page;

//================//
//OVERWORLD//
//================//
if (
	_str_mode ==
	"OVERWORLD"
){

	switch (_it_tab){

//----------------//
//BEASTS//
//----------------//
		case 0:

			if (
				ds_exists(
					global.list_logbook_beasts,
					ds_type_list
				)
			){

				_ct_page_entries =
					ds_list_size(
						global.list_logbook_beasts
					);
			}

		break;

//----------------//
//CARDS//
//----------------//
		case 1:

			if (
				ds_exists(
					global.list_logbook_cards,
					ds_type_list
				)
			){

				_ct_page_entries =
					ds_list_size(
						global.list_logbook_cards
					);
			}

		break;

//----------------//
//ITEMS//
//----------------//
		case 2:

			if (
				variable_global_exists(
					"arr_pool_items"
				) &&
				is_array(
					global.arr_pool_items
				)
			){

				_ct_page_entries =
					array_length(
						global.arr_pool_items
					);
			}

		break;

//----------------//
//MISC//
//----------------//
		case 3:

			// The wild-Beast catalog is the paginated portion
			// of the Misc tab. Its visible row count is reduced
			// because Battle / Teleport / Gold controls occupy
			// the top of the pane.
			if (
				ds_exists(
					global.list_logbook_beasts,
					ds_type_list
				)
			){

				_ct_page_entries =
					ds_list_size(
						global.list_logbook_beasts
					);
			}

			_ct_page_rows =
				max(
					1,
					floor(
						(
							_val_content_y2 -
							(
								_val_content_y1 +
								195 +
								24
							) +
							_val_row_gap
						) /
						_val_row_step
					)
				);

		break;
	}
}

//================//
//BATTLE//
//================//
else{

	switch (_it_tab){

//----------------//
//INTERACT//
//----------------//
		case 0:

// STATUS SUBMENU
			if (
				_it_submenu ==
				1
			){

				_ct_page_entries =
					array_length(
						_arr_cheat_dots
					) +
					array_length(
						_arr_cheat_cc
					) +
					array_length(
						_arr_cheat_debuffs
					) +
					array_length(
						_arr_cheat_buffs
					) +
					array_length(
						_arr_cheat_auras
					) +
					array_length(
						_arr_cheat_team_statuses
					);

				_ct_page_rows =
					24;
			}

// MINION SUBMENU
			else if (
				_it_submenu ==
				2
			){

				_ct_page_entries =
					array_length(
						_arr_cheat_minions
					);

				_ct_page_rows =
					24;
			}

// ELITE MODIFIER SUBMENU
			else if (
				_it_submenu ==
				3
			){

				_ct_page_entries =
					array_length(
						_arr_cheat_elite_menu_entries
					);

				_ct_page_rows =
					24;
			}

// CHANGE BEAST SUBMENU
			else if (
				_it_submenu ==
				4
			){

				if (
					ds_exists(
						global.list_logbook_beasts,
						ds_type_list
					)
				){

					_ct_page_entries =
						ds_list_size(
							global.list_logbook_beasts
						);
				}

				_ct_page_rows =
					24;
			}

// MAIN INTERACT PAGE
			else{

				_ct_page_entries =
					1;

				_ct_page_rows =
					1;
			}

		break;

//----------------//
//EVENTS / WEATHER//
//----------------//
		case 1:

			_ct_page_entries =
				array_length(
					_arr_cheat_weather
				) +
				array_length(
					_arr_cheat_events
				);

			_ct_page_rows =
				_ct_rows_per_page;

		break;

//----------------//
//HAND//
//----------------//
		case 2:

			_ct_page_entries =
				1;

			_ct_page_rows =
				1;

		break;

//---------------------//
//CAST SIMULATED CARD//
//---------------------//
		case 3:

			_ct_page_entries =
				array_length(
					_arr_cheat_cards_sorted
				);

			var _val_cast_header_y =
				_val_content_y1 + 110;

			var _val_cast_list_y =
				_val_cast_header_y + 24;

			_ct_page_rows =
				max(
					1,
					floor(
						(
							_val_content_y2 -
							_val_cast_list_y -
							8
						) /
						_val_row_step
					)
				);

		break;

//----------------//
//END BATTLE//
//----------------//
		case 4:

			_ct_page_entries =
				1;

			_ct_page_rows =
				1;

		break;
	}
}

//================//
//MAX PAGE//
//================//
var _it_max_page =
	hscr_cheats_get_max_page(
		_ct_page_entries,
		_ct_page_rows
	);

_it_page =
	clamp(
		_it_page,
		0,
		_it_max_page
	);

//===============================================================================//
// PAGE INPUT
//===============================================================================//

var _flag_page_previous =
	false;

var _flag_page_next =
	false;

//================//
//KEYBOARD//
//================//

//----------------//
//PREVIOUS PAGE//
// UP ARROW / W
//----------------//
if (
	keyboard_check_pressed(
		vk_up
	) ||
	keyboard_check_pressed(
		ord("W")
	)
){

	_flag_page_previous =
		true;
}

//----------------//
//NEXT PAGE//
// DOWN ARROW / S
//----------------//
if (
	keyboard_check_pressed(
		vk_down
	) ||
	keyboard_check_pressed(
		ord("S")
	)
){

	_flag_page_next =
		true;
}

//================//
//MOUSE WHEEL//
//================//
if (
	mouse_wheel_up()
){

	_flag_page_previous =
		true;
}

if (
	mouse_wheel_down()
){

	_flag_page_next =
		true;
}

//================//
//PREVIOUS PAGE//
//================//
if (_flag_page_previous){

	if (
		hscr_cheats_set_page(
			_it_page - 1,
			_it_max_page
		)
	){

		audio_play_sound(
			snd_gui_press,
			0,
			false
		);
	}

	exit;
}

//================//
//NEXT PAGE//
//================//
if (_flag_page_next){

	if (
		hscr_cheats_set_page(
			_it_page + 1,
			_it_max_page
		)
	){

		audio_play_sound(
			snd_gui_press,
			0,
			false
		);
	}

	exit;
}

#endregion