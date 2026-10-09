//===============================================================================//
//
// SCRIPT: SCR_BATTLE_REFRESH_FORMATION
// FUNCTION: Reindexes and repositions one battle team's living and dead Beasts.
//
//           FORMATION RULES:
//           - Normal front anchors preserve the pre-Elite layout, then move
//             both teams 25 px farther outward:
//                 PLAYER front = room center - 105.
//                 ENEMY  front = room center + 105.
//           - Normal adjacent slots remain exactly 100 px apart.
//           - Any visible gap touching an Elite is exactly 125 px apart.
//           - Living Beasts always occupy the front slots.
//           - Graveyard Beasts continue outward immediately after the living
//             formation, using the SAME gap rules. Dead and living placement
//             therefore cannot drift into separate coordinate systems.
//           - A full five-slot enemy presentation containing a living Elite is
//             shifted right as one unit until its outermost visible Beast / HP
//             presentation reaches the room edge safety limit.
//           - PLAYER only receives the extra 20 px left clearance while FIVE
//             living enemies remain and at least one of them is Elite.
//           - Room-edge correction uses the 96 px HP bar and the widest
//             presentation footprint in each visual class (normal / Elite).
//             This keeps same-class slot coordinates invariant under swaps while
//             still protecting large sprites, form scale, Elite scale, and hover.
//           - The five-slot Elite enemy extreme prefers placing the rear HP bar
//             5 px from the right edge, then clamps inward only if sprite safety
//             requires more room.
//
//           ENEMY refreshes also refresh PLAYER because enemy Elite state can
//           change the player's extra-clearance rule. PLAYER refreshes do not
//           need to move ENEMY because enemy geometry does not depend on PLAYER.
//
//           Runtime refreshes animate by default. Battle-entry setup passes
//           FALSE explicitly so opening positions are installed immediately.
//
// ARGUMENTS: _str_team     - PLAYER or ENEMY.
//            _flag_animate - Optional reposition animation. Default TRUE.
//
//===============================================================================//
function scr_battle_refresh_formation(_str_team,_flag_animate=true){

	#region VALIDATION

	_str_team =
		string_upper(
			string(
				_str_team
			)
		);

	if (
		_str_team != "PLAYER" &&
		_str_team != "ENEMY"
	){
		return false;
	}

	#endregion

	#region SHARED ELITE STATE

	//===================//
	//LIVING ENEMY ELITE//
	//===================//
	var _flag_enemy_elite_alive =
		false;

	var _ct_enemy_alive =
		0;

	if (
		instance_exists(
			obj_battle_enemy_controller
		) &&
		ds_exists(
			obj_battle_enemy_controller
				._list_beasts_alive,
			ds_type_list
		)
	){
		var _list_enemy_alive_check =
			obj_battle_enemy_controller
				._list_beasts_alive;

		for (
			var _it_enemy_check = 0;
			_it_enemy_check <
				ds_list_size(
					_list_enemy_alive_check
				);
			_it_enemy_check++
		){
			var _ref_enemy_check =
				ds_list_find_value(
					_list_enemy_alive_check,
					_it_enemy_check
				);

			if (
				!instance_exists(
					_ref_enemy_check
				) ||
				_ref_enemy_check._str_list !=
					"ALIVE" ||
				_ref_enemy_check._val_cur_hp <=
					0
			){
				continue;
			}

			_ct_enemy_alive++;

			var _flag_enemy_instance_elite =
				variable_instance_exists(
					_ref_enemy_check,
					"_flag_elite"
				) &&
				_ref_enemy_check._flag_elite;

			var _flag_enemy_struct_elite =
				is_struct(
					_ref_enemy_check._ref_unit
				) &&
				variable_struct_exists(
					_ref_enemy_check._ref_unit,
					"_flag_elite"
				) &&
				_ref_enemy_check
					._ref_unit
					._flag_elite;

			if (
				_flag_enemy_instance_elite ||
				_flag_enemy_struct_elite
			){
				_flag_enemy_elite_alive =
					true;
			}
		}
	}

	#endregion

	#region REFRESH REQUEST

	//======================//
	//TEAMS TO RECALCULATE//
	//======================//
	var _arr_refresh_teams = [
		_str_team
	];

	/*
		Enemy structural changes can create/remove an Elite or change enemy count.
		Both conditions can alter PLAYER's extra-clearance rule, so ENEMY refreshes
		also resolve PLAYER in the same call without recursion.
	*/
	if (_str_team == "ENEMY"){
		array_push(
			_arr_refresh_teams,
			"PLAYER"
		);
	}

	#endregion

	#region LAYOUT CONSTANTS

	var _val_normal_gap =
		100;

	var _val_elite_gap =
		125;

	var _val_hp_bar_half_width =
		48;

	var _val_room_edge_gap =
		5;

	var _val_player_full_elite_clearance =
		20;

	var _val_base_draw_scale =
		0.2;

	var _val_hover_scale =
		1.15;

	#endregion

	#region TEAM PASSES

	for (
		var _it_refresh_team = 0;
		_it_refresh_team <
			array_length(
				_arr_refresh_teams
			);
		_it_refresh_team++
	){
		var _str_refresh_team =
			_arr_refresh_teams[
				_it_refresh_team
			];

		var _ref_controller =
			undefined;

		if (_str_refresh_team == "PLAYER"){
			if (
				instance_exists(
					obj_battle_player_controller
				)
			){
				_ref_controller =
					instance_find(
						obj_battle_player_controller,
						0
					);
			}
		}
		else{
			if (
				instance_exists(
					obj_battle_enemy_controller
				)
			){
				_ref_controller =
					instance_find(
						obj_battle_enemy_controller,
						0
					);
			}
		}

		if (!instance_exists(_ref_controller)){
			continue;
		}

		var _list_alive =
			_ref_controller
				._list_beasts_alive;

		var _list_dead =
			_ref_controller
				._list_beasts_graveyard;

		if (
			!ds_exists(
				_list_alive,
				ds_type_list
			) ||
			!ds_exists(
				_list_dead,
				ds_type_list
			)
		){
			continue;
		}

		//=======================//
		//BUILD PRESENTATION LANE//
		//=======================//
		/*
			Living Beasts always come first. Graveyard Beasts continue outward after
			the final living slot. This is the single authoritative visual lane.
		*/
		var _arr_presentation = [];
		var _ct_alive_valid = 0;

		for (
			var _it_alive = 0;
			_it_alive <
				ds_list_size(
					_list_alive
				);
			_it_alive++
		){
			var _ref_alive =
				ds_list_find_value(
					_list_alive,
					_it_alive
				);

			if (!instance_exists(_ref_alive)){
				continue;
			}

			if (
				_ref_alive._str_list !=
					"ALIVE" ||
				_ref_alive._val_cur_hp <=
					0
			){
				continue;
			}

			array_push(
				_arr_presentation,
				_ref_alive
			);

			_ct_alive_valid++;
		}

		for (
			var _it_dead = 0;
			_it_dead <
				ds_list_size(
					_list_dead
				);
			_it_dead++
		){
			var _ref_dead =
				ds_list_find_value(
					_list_dead,
					_it_dead
				);

			if (!instance_exists(_ref_dead)){
				continue;
			}

			array_push(
				_arr_presentation,
				_ref_dead
			);
		}

		var _ct_presentation =
			array_length(
				_arr_presentation
			);

		if (_ct_presentation <= 0){
			continue;
		}

		var _val_direction =
			(_str_refresh_team == "PLAYER")
			? -1
			: 1;

		//================//
		//STANDARD ANCHOR//
		//================//
		var _ref_front_basis =
			_arr_presentation[0];

		var _val_front_x =
			_ref_front_basis
				.hscr_battle_get_active_x(
					_str_refresh_team,
					0
				);

		// Only the true 5-living-enemy Elite extreme needs PLAYER clearance.
		if (
			_str_refresh_team == "PLAYER" &&
			_flag_enemy_elite_alive &&
			_ct_enemy_alive >= 5
		){
			_val_front_x -=
				_val_player_full_elite_clearance;
		}

		//========================//
		//ELITE / EXTENT SNAPSHOT//
		//========================//
		var _arr_is_elite = [];

		/*
			Bounds must not depend on WHICH normal Beast occupies WHICH slot.
			Otherwise swapping two normal Beasts can change the legal whole-team
			offset simply because one sprite is wider than the other.

			Measure the widest normal and Elite presentation once, then use that
			class-wide footprint for every matching slot. This preserves stable
			formation coordinates across normal swaps while retaining sprite safety.
		*/
		var _val_normal_half_extent_max =
			_val_hp_bar_half_width;

		var _val_elite_half_extent_max =
			_val_hp_bar_half_width;

		for (
			var _it_present = 0;
			_it_present <
				_ct_presentation;
			_it_present++
		){
			var _ref_present =
				_arr_presentation[
					_it_present
				];

			var _flag_present_elite =
				false;

			if (
				variable_instance_exists(
					_ref_present,
					"_flag_elite"
				) &&
				_ref_present._flag_elite
			){
				_flag_present_elite =
					true;
			}
			else if (
				is_struct(
					_ref_present._ref_unit
				) &&
				variable_struct_exists(
					_ref_present._ref_unit,
					"_flag_elite"
				) &&
				_ref_present
					._ref_unit
					._flag_elite
			){
				_flag_present_elite =
					true;
			}

			array_push(
				_arr_is_elite,
				_flag_present_elite
			);

			//==================//
			//CURRENT FORM SCALE//
			//==================//
			/*
				ABYSSAL FORM and future form presentation can alter Beast draw scale.
				Refresh the same draw-state helper used by OBJ_BATTLE_BEAST before
				measuring horizontal sprite safety.
			*/
			scr_battle_refresh_beast_form_draw(
				_ref_present
			);

			//--------------------//
			//BASE GUI HALF-WIDTH//
			//--------------------//
			/*
				HP bar = 96 px. Armor is centered 16 px inside its right end and its
				32 px icon therefore reaches the same outer 48 px boundary.
			*/
			var _val_half_extent =
				_val_hp_bar_half_width;

			//----------------//
			//SPRITE HALF-WIDTH//
			//----------------//
			if (
				variable_instance_exists(
					_ref_present,
					"_spr_beast"
				) &&
				_ref_present._spr_beast !=
					undefined &&
				sprite_exists(
					_ref_present._spr_beast
				)
			){
				var _val_form_scale =
					1;

				if (
					variable_instance_exists(
						_ref_present,
						"_val_beast_draw_scale_multiplier"
					) &&
					is_real(
						_ref_present
							._val_beast_draw_scale_multiplier
					)
				){
					_val_form_scale =
						max(
							0,
							_ref_present
								._val_beast_draw_scale_multiplier
						);
				}

				var _val_elite_scale =
					1;

				if (_flag_present_elite){
					var _str_present_modifier =
						"";

					if (
						variable_instance_exists(
							_ref_present,
							"_str_elite_modifier"
						)
					){
						_str_present_modifier =
							string_upper(
								string(
									_ref_present
										._str_elite_modifier
								)
							);
					}

					_val_elite_scale =
						scr_elite_get_draw_scale_multiplier(
							_str_present_modifier,
							"BATTLE"
						);
				}

				var _spr_present =
					_ref_present._spr_beast;

				var _val_origin_x =
					sprite_get_xoffset(
						_spr_present
					);

				var _val_bbox_left =
					sprite_get_bbox_left(
						_spr_present
					);

				var _val_bbox_right =
					sprite_get_bbox_right(
						_spr_present
					);

				var _val_source_half_extent =
					max(
						abs(
							_val_bbox_left -
								_val_origin_x
						),
						abs(
							_val_bbox_right -
								_val_origin_x
						)
					);

				var _val_sprite_half_extent =
					_val_source_half_extent *
					_val_base_draw_scale *
					_val_form_scale *
					_val_elite_scale *
					_val_hover_scale;

				_val_half_extent =
					max(
						_val_half_extent,
						_val_sprite_half_extent
					);
			}

			if (_flag_present_elite){
				_val_elite_half_extent_max =
					max(
						_val_elite_half_extent_max,
						_val_half_extent
					);
			}
			else{
				_val_normal_half_extent_max =
					max(
						_val_normal_half_extent_max,
						_val_half_extent
					);
			}
		}

		//====================//
		//RAW STANDARD SLOTS//
		//====================//
		var _arr_target_x = [];

		var _val_running_x =
			_val_front_x;

		for (
			var _it_present = 0;
			_it_present <
				_ct_presentation;
			_it_present++
		){
			if (_it_present > 0){
				var _val_gap =
					_val_normal_gap;

				if (
					_arr_is_elite[
						_it_present - 1
					] ||
					_arr_is_elite[
						_it_present
					]
				){
					_val_gap =
						_val_elite_gap;
				}

				_val_running_x +=
					_val_direction *
					_val_gap;
			}

			array_push(
				_arr_target_x,
				_val_running_x
			);
		}

		//======================//
		//LEGAL WHOLE-TEAM SHIFT//
		//======================//
		/*
			Find the range of horizontal offsets that keeps EVERY Beast's HP bar
			and scaled sprite inside the room. The team then receives one shared
			offset, preserving all 100/125 px slot gaps exactly.
		*/
		var _val_shift_min =
			-1000000000;

		var _val_shift_max =
			1000000000;

		for (
			var _it_present = 0;
			_it_present <
				_ct_presentation;
			_it_present++
		){
			var _val_target_x =
				_arr_target_x[
					_it_present
				];

			/*
				Use a permutation-stable footprint for room bounds. A normal Beast
				swap therefore cannot move the entire formation a few pixels merely
				because the wider sprite changed slots.
			*/
			var _val_half_extent =
				_arr_is_elite[
					_it_present
				]
				? _val_elite_half_extent_max
				: _val_normal_half_extent_max;

			var _val_min_center =
				_val_room_edge_gap +
				_val_half_extent;

			var _val_max_center =
				room_width -
				_val_room_edge_gap -
				_val_half_extent;

			_val_shift_min =
				max(
					_val_shift_min,
					_val_min_center -
						_val_target_x
				);

			_val_shift_max =
				min(
					_val_shift_max,
					_val_max_center -
						_val_target_x
				);
		}

		var _val_preferred_shift =
			0;

		//============================//
		//FULL ELITE ENEMY RIGHT ALIGN//
		//============================//
		/*
			Only a five-slot visible enemy lane needs the deliberate far-right
			alignment. Smaller enemy groups retain their standard front anchor.
		*/
		if (
			_str_refresh_team == "ENEMY" &&
			_flag_enemy_elite_alive &&
			_ct_presentation >= 5
		){
			var _it_rear =
				_ct_presentation - 1;

			/*
				Prefer the rear HP bar at exactly the approved 5 px room margin.
				The legal-shift clamp below still moves the team farther inward when
				an oversized normal / Elite sprite requires additional safety.
			*/
			_val_preferred_shift =
				(
					room_width -
					_val_room_edge_gap -
					_val_hp_bar_half_width
				) -
				_arr_target_x[
					_it_rear
				];
		}

		var _val_team_shift =
			0;

		if (_val_shift_min <= _val_shift_max){
			_val_team_shift =
				clamp(
					_val_preferred_shift,
					_val_shift_min,
					_val_shift_max
				);
		}
		else{
			/*
				The current five-Beast rules fit the standard battle room. This branch
				only protects against future sprite/room changes that make the complete
				presentation physically wider than the room. Preserve slot spacing and
				center the overflow rather than collapsing Beasts into each other.
			*/
			_val_team_shift =
				(
					_val_shift_min +
					_val_shift_max
				) *
				0.5;

			scr_debug_log(
				"BATTLE",
				"FORMATION",
				_ref_controller,
				"FORMATION WIDER THAN SAFE ROOM BOUNDS" +
				" | TEAM: " +
				_str_refresh_team +
				" | PRESENTATION: " +
				string(
					_ct_presentation
				) +
				" | SHIFT MIN: " +
				string(
					_val_shift_min
				) +
				" | SHIFT MAX: " +
				string(
					_val_shift_max
				),
				"WARNING",
				"SCR_BATTLE_REFRESH_FORMATION"
			);
		}

		//==================//
		//INSTALL POSITIONS//
		//==================//
		for (
			var _it_present = 0;
			_it_present <
				_ct_presentation;
			_it_present++
		){
			var _ref_present =
				_arr_presentation[
					_it_present
				];

			if (!instance_exists(_ref_present)){
				continue;
			}

			var _val_old_x =
				_ref_present.x;

			_ref_present._val_pos =
				_it_present;

			_ref_present.x =
				_arr_target_x[
					_it_present
				] +
				_val_team_shift;

			if (
				_flag_animate &&
				abs(
					_ref_present.x -
						_val_old_x
				) >
				0.01
			){
				scr_battle_vfx_reposition(
					_ref_present,
					_val_old_x,
					8
				);
			}

			// Living attachments follow the newly authoritative host position.
			if (
				_it_present <
					_ct_alive_valid &&
				_ref_present._str_list ==
					"ALIVE" &&
				_ref_present._val_cur_hp >
					0
			){
				scr_minion_reposition(
					_ref_present
				);

				scr_status_reposition(
					_ref_present
				);
			}
		}
	}

	#endregion

	return true;
}