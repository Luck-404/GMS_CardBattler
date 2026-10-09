//===============================================================================//
//
// FUNCTION: SCR_ELITE_DRAW_MODIFIER_VFX
// FUNCTION: Draws persistent code/sprite-based visual treatment for every Elite
//           modifier in battle and overworld.
//
//           Overhead motifs use the Beast sprite hitbox only as a presentation
//           anchor. The hitbox is never used to resize, constrain, or reposition
//           the Beast itself. Overhead motifs keep at least 5 px of clearance
//           above the scaled sprite hitbox.
//
// ARGUMENTS: _ref_beast - battle or overworld Beast instance.
//            _spr_beast - Beast sprite.
//            _val_x/_val_y - final Beast draw position.
//            _val_scale_x/_val_scale_y - final Beast draw scale.
//            _val_angle - final draw angle.
//            _str_context - BATTLE or OVERWORLD.
//            _val_battle_hp_bar_y - optional battle HP-bar top Y used by
//                                   HP-region motifs such as THORNY.
//
//===============================================================================//
function scr_elite_draw_modifier_vfx(
	_ref_beast,
	_spr_beast,
	_val_x,
	_val_y,
	_val_scale_x,
	_val_scale_y,
	_val_angle=0,
	_str_context="BATTLE",
	_val_battle_hp_bar_y=undefined
){

	#region VALIDATION

	if (!instance_exists(_ref_beast)){
		return;
	}

	var _stct_unit = undefined;
	var _flag_elite = false;
	var _str_modifier = "";

	if (
		variable_instance_exists(
			_ref_beast,
			"_ref_unit"
		) &&
		is_struct(
			_ref_beast._ref_unit
		)
	){
		_stct_unit =
			_ref_beast._ref_unit;
	}
	else if (
		variable_instance_exists(
			_ref_beast,
			"_stct_unit"
		) &&
		is_struct(
			_ref_beast._stct_unit
		)
	){
		_stct_unit =
			_ref_beast._stct_unit;
	}

	if (
		variable_instance_exists(
			_ref_beast,
			"_flag_elite"
		) &&
		_ref_beast._flag_elite
	){
		_flag_elite = true;
	}
	else if (
		is_struct(
			_stct_unit
		) &&
		variable_struct_exists(
			_stct_unit,
			"_flag_elite"
		) &&
		_stct_unit._flag_elite
	){
		_flag_elite = true;
	}

	if (!_flag_elite){
		return;
	}

	if (
		variable_instance_exists(
			_ref_beast,
			"_str_elite_modifier"
		) &&
		is_string(
			_ref_beast._str_elite_modifier
		)
	){
		_str_modifier =
			string_upper(
				_ref_beast._str_elite_modifier
			);
	}
	else if (
		is_struct(
			_stct_unit
		) &&
		variable_struct_exists(
			_stct_unit,
			"_str_elite_modifier"
		)
	){
		_str_modifier =
			string_upper(
				string(
					_stct_unit
						._str_elite_modifier
				)
			);
	}

	var _stct_info =
		scr_battle_elite_get_info(
			_str_modifier
		);

	if (!is_struct(_stct_info)){
		return;
	}

	#endregion

	#region DRAW VARIABLES

	_str_context =
		string_upper(
			string(
				_str_context
			)
		);

	var _flag_overworld =
		(_str_context == "OVERWORLD");

	var _val_pulse =
		(
			sin(
				current_time /
					180
			) +
			1
		) *
		0.5;

	var _val_fast_pulse =
		(
			sin(
				current_time /
					85
			) +
			1
		) *
		0.5;

	var _val_radius =
		_flag_overworld
		? 18
		: 48;

	var _val_small =
		_flag_overworld
		? 4
		: 9;

	var _c_accent =
		_stct_info._c_elite_tint;

	//=======================//
	//DYNAMIC OVERHEAD ANCHOR//
	//=======================//
	var _val_head_radius =
		_val_radius *
		0.38;

	var _val_head_y =
		_val_y -
		(
			_val_radius *
			0.82
		);

	var _val_overhead_padding = 5;

	if (
		_spr_beast != undefined &&
		sprite_exists(
			_spr_beast
		)
	){
		var _val_sprite_local_top =
			sprite_get_bbox_top(
				_spr_beast
			) -
			sprite_get_yoffset(
				_spr_beast
			);

		var _val_sprite_top_y =
			_val_y +
			(
				_val_sprite_local_top *
				abs(
					_val_scale_y
				)
			);

		_val_head_y =
			_val_sprite_top_y -
			_val_overhead_padding -
			_val_head_radius;
	}

	draw_set_alpha(1);
	draw_set_colour(c_white);

	#endregion

	#region MODIFIER VFX

	switch (_str_modifier){

		//================//
		//EVASIVE//
		//================//
		case "EVASIVE":

			if (
				_spr_beast != undefined &&
				sprite_exists(
					_spr_beast
				)
			){
				var _val_clone_offset =
					_val_small *
					1.75;

				draw_sprite_ext(
					_spr_beast,
					0,
					_val_x -
						_val_clone_offset,
					_val_y,
					_val_scale_x,
					_val_scale_y,
					_val_angle,
					c_aqua,
					0.16 +
						(
							0.10 *
							_val_pulse
						)
				);

				draw_sprite_ext(
					_spr_beast,
					0,
					_val_x +
						_val_clone_offset,
					_val_y,
					_val_scale_x,
					_val_scale_y,
					_val_angle,
					c_white,
					0.14 +
						(
							0.08 *
							(
								1 -
								_val_pulse
							)
						)
				);
			}

		break;

		//================//
		//GOLDEN//
		//================//
		case "GOLDEN":

			draw_set_colour(
				make_colour_rgb(
					255,
					205,
					65
				)
			);

			draw_set_alpha(
				0.58 +
					(
						0.18 *
						_val_fast_pulse
					)
			);

			for (
				var _it_gold = 0;
				_it_gold < 4;
				_it_gold++
			){
				var _ang_gold =
					(
						current_time /
							9
					) +
					(
						_it_gold *
						90
					);

				var _val_gold_waver =
					0.76 +
						(
							0.12 *
							sin(
								(
									current_time /
										130
								) +
								(
									_it_gold *
									1.7
								)
							)
						);

				var _val_gold_x =
					_val_x +
					lengthdir_x(
						_val_radius *
							_val_gold_waver,
						_ang_gold
					);

				var _val_gold_y =
					_val_y +
					lengthdir_y(
						_val_radius *
							(
								0.62 +
								(
									0.08 *
									cos(
										(
											current_time /
												110
										) +
										_it_gold
									)
								)
							),
						_ang_gold
					);

				draw_circle(
					_val_gold_x,
					_val_gold_y,
					_flag_overworld
					? 2.5
					: 5,
					false
				);
			}

		break;

		//================//
		//ENLIGHTENED//
		//================//
		case "ENLIGHTENED":

			draw_set_colour(
				_c_accent
			);

			draw_set_alpha(
				0.42 +
					(
						0.18 *
						_val_pulse
					)
			);

			draw_circle(
				_val_x,
				_val_head_y,
				_val_head_radius,
				true
			);

			draw_set_alpha(
				0.10 +
					(
						0.08 *
						_val_pulse
					)
			);

			draw_circle(
				_val_x,
				_val_head_y,
				_val_head_radius *
					0.82,
				false
			);

		break;

		//================//
		//SCHOLARLY//
		//================//
		case "SCHOLARLY":

			draw_set_colour(
				_c_accent
			);

			draw_set_alpha(
				0.52 +
					(
						0.12 *
						_val_pulse
					)
			);

			var _val_book_half_width =
				_val_head_radius *
				0.78;

			var _val_book_top =
				_val_head_y -
				(
					_val_head_radius *
					0.42
				);

			var _val_book_bottom =
				_val_head_y +
				(
					_val_head_radius *
					0.36
				);

			draw_rectangle(
				_val_x -
					_val_book_half_width,
				_val_book_top,
				_val_x - 1,
				_val_book_bottom,
				false
			);

			draw_rectangle(
				_val_x + 1,
				_val_book_top,
				_val_x +
					_val_book_half_width,
				_val_book_bottom,
				false
			);

			draw_set_colour(
				c_black
			);

			draw_set_alpha(0.70);

			draw_line(
				_val_x,
				_val_book_top,
				_val_x,
				_val_book_bottom
			);

		break;

		//================//
		//VENGEFUL//
		//================//
		case "VENGEFUL":

			draw_set_colour(
				_c_accent
			);

			draw_set_alpha(
				0.38 +
					(
						0.18 *
						_val_pulse
					)
			);

			draw_circle(
				_val_x,
				_val_head_y,
				_val_head_radius,
				true
			);

			for (
				var _it_v = 0;
				_it_v < 3;
				_it_v++
			){
				var _ang_v =
					(
						current_time /
							8
					) +
					(
						_it_v *
						120
					);

				draw_circle(
					_val_x +
						lengthdir_x(
							_val_head_radius *
								0.82,
							_ang_v
						),
					_val_head_y +
						lengthdir_y(
							_val_head_radius *
								0.82,
							_ang_v
						),
					_flag_overworld
					? 1.5
					: 3,
					false
				);
			}

		break;

		//================//
		//PHASING//
		//================//
		case "PHASING":

			var _c_phasing =
				make_colour_rgb(
					180,
					80,
					255
				);

			var _ang_phase =
				current_time /
					7;

			var _val_phase_x =
				_val_x +
				lengthdir_x(
					_val_head_radius *
						0.92,
					_ang_phase
				);

			var _val_phase_y =
				_val_head_y +
				lengthdir_y(
					_val_head_radius *
						0.28,
					_ang_phase
				);

			draw_set_colour(
				_c_phasing
			);

			draw_set_alpha(
				0.66 +
					(
						0.18 *
						_val_fast_pulse
					)
			);

			draw_circle(
				_val_phase_x,
				_val_phase_y,
				_flag_overworld
				? 2.5
				: 5,
				false
			);

		break;

		//================//
		//SOULBOUND//
		//================//
		case "SOULBOUND":

			draw_set_colour(
				_c_accent
			);

			draw_set_alpha(
				0.44 +
					(
						0.14 *
						_val_pulse
					)
			);

			draw_circle(
				_val_x,
				_val_head_y,
				_val_head_radius,
				true
			);

			draw_line(
				_val_x,
				_val_head_y -
					_val_head_radius,
				_val_x,
				_val_head_y +
					_val_head_radius
			);

			draw_line(
				_val_x -
					_val_head_radius,
				_val_head_y,
				_val_x +
					_val_head_radius,
				_val_head_y
			);

			// Protected-ally mark exists only after battle Soulbound assignment.
			if (
				!_flag_overworld &&
				variable_instance_exists(
					_ref_beast,
					"_ref_elite_soulbound_protected"
				) &&
				instance_exists(
					_ref_beast
						._ref_elite_soulbound_protected
				)
			){
				var _ref_protected =
					_ref_beast
						._ref_elite_soulbound_protected;

				var _val_protected_x =
					_ref_protected.x;

				var _val_protected_y =
					_ref_protected.y;

				if (
					variable_instance_exists(
						_ref_protected,
						"_val_vfx_offset_x"
					)
				){
					_val_protected_x +=
						_ref_protected
							._val_vfx_offset_x;
				}

				if (
					variable_instance_exists(
						_ref_protected,
						"_val_vfx_offset_y"
					)
				){
					_val_protected_y +=
						_ref_protected
							._val_vfx_offset_y;
				}

				var _val_protected_radius =
					_val_head_radius *
					0.62;

				var _val_protected_head_y =
					_val_protected_y -
					(
						_val_radius *
						0.82
					);

				if (
					variable_instance_exists(
						_ref_protected,
						"_spr_beast"
					) &&
					_ref_protected._spr_beast != undefined &&
					sprite_exists(
						_ref_protected._spr_beast
					)
				){
					var _val_protected_scale_y = 0.2;

					if (
						variable_instance_exists(
							_ref_protected,
							"_val_beast_draw_scale_multiplier"
						)
					){
						_val_protected_scale_y *=
							_ref_protected
								._val_beast_draw_scale_multiplier;
					}

					if (
						variable_instance_exists(
							_ref_protected,
							"_val_elite_draw_scale_multiplier"
						)
					){
						_val_protected_scale_y *=
							_ref_protected
								._val_elite_draw_scale_multiplier;
					}

					var _val_protected_local_top =
						sprite_get_bbox_top(
							_ref_protected._spr_beast
						) -
						sprite_get_yoffset(
							_ref_protected._spr_beast
						);

					var _val_protected_top_y =
						_val_protected_y +
						(
							_val_protected_local_top *
							abs(
								_val_protected_scale_y
							)
						);

					_val_protected_head_y =
						_val_protected_top_y -
						_val_overhead_padding -
						_val_protected_radius;
				}

				draw_set_alpha(
					0.34 +
						(
							0.12 *
							_val_pulse
						)
				);

				draw_circle(
					_val_protected_x,
					_val_protected_head_y,
					_val_protected_radius,
					true
				);

				draw_line(
					_val_protected_x,
					_val_protected_head_y -
						_val_protected_radius,
					_val_protected_x,
					_val_protected_head_y +
						_val_protected_radius
				);

				draw_line(
					_val_protected_x -
						_val_protected_radius,
					_val_protected_head_y,
					_val_protected_x +
						_val_protected_radius,
					_val_protected_head_y
				);
			}

		break;

		//================//
		//ELEMENTAL//
		//================//
		case "ELEMENTAL":

			var _str_element =
				scr_battle_elite_get_elemental_variant(
					_ref_beast
				);

			var _c_element =
				make_colour_rgb(
					55,
					90,
					180
				);

			switch (_str_element){

				case "FIRE":
					_c_element =
						make_colour_rgb(
							255,
							115,
							115
						);
				break;

				case "FROST":
					_c_element =
						make_colour_rgb(
							80,
							235,
							255
						);
				break;

				case "VERDANT":
					_c_element =
						c_lime;
				break;
			}

			draw_set_colour(
				_c_element
			);

			draw_set_alpha(
				0.52 +
					(
						0.16 *
						_val_pulse
					)
			);

			for (
				var _it_e = 0;
				_it_e < 4;
				_it_e++
			){
				var _ang_e =
					(
						current_time /
							10
					) +
					(
						_it_e *
						90
					);

				draw_circle(
					_val_x +
						lengthdir_x(
							_val_head_radius *
								0.88,
							_ang_e
						),
					_val_head_y +
						lengthdir_y(
							_val_head_radius *
								0.88,
							_ang_e
						),
					_flag_overworld
					? 1.75
					: 3.5,
					false
				);
			}

		break;

		//================//
		//HARDY//
		//================//
		case "HARDY":

			draw_set_colour(
				_c_accent
			);

			draw_set_alpha(
				0.28 +
					(
						0.14 *
						_val_pulse
					)
			);

			draw_circle(
				_val_x,
				_val_y,
				_val_radius,
				true
			);

			draw_circle(
				_val_x,
				_val_y,
				_val_radius -
					(
						_flag_overworld
						? 4
						: 8
					),
				true
			);

		break;

		//================//
		//LEECHING//
		//================//
		case "LEECHING":

			draw_set_colour(
				_c_accent
			);

			draw_set_alpha(
				0.40 +
					(
						0.14 *
						_val_pulse
					)
			);

			draw_circle(
				_val_x,
				_val_head_y,
				_val_head_radius,
				true
			);

			draw_line(
				_val_x -
					(
						_val_head_radius *
						0.42
					),
				_val_head_y -
					(
						_val_head_radius *
						0.48
					),
				_val_x -
					(
						_val_head_radius *
						0.12
					),
				_val_head_y -
					(
						_val_head_radius *
						0.12
					)
			);

			draw_line(
				_val_x +
					(
						_val_head_radius *
						0.42
					),
				_val_head_y -
					(
						_val_head_radius *
						0.48
					),
				_val_x +
					(
						_val_head_radius *
						0.12
					),
				_val_head_y -
					(
						_val_head_radius *
						0.12
					)
			);

		break;

		//================//
		//THORNY//
		//================//
		case "THORNY":

			var _c_thorny =
				make_colour_rgb(
					105,
					20,
					30
				);

			var _val_thorn_frame =
				max(
					0,
					sprite_get_number(
						spr_battle_vfx_thorns
					) -
					1
				);

			/*
				THORNY is an HP-region motif, not an overhead motif. In battle, anchor
				it to the HP bar itself so Beast scaling/lift cannot pull the thorns
				above the bar. The Beast Draw GUI calls this before drawing the HP bar,
				so the bar remains visually on top of the thorns.
			*/
			var _val_thorn_y =
				_flag_overworld
				? _val_y - 13
				: _val_y - 65;

			if (
				!_flag_overworld &&
				_val_battle_hp_bar_y != undefined
			){
				_val_thorn_y =
					_val_battle_hp_bar_y + 5;
			}

			draw_set_alpha(0.82);

			draw_sprite_ext(
				spr_battle_vfx_thorns,
				_val_thorn_frame,
				_val_x,
				_val_thorn_y,
				_flag_overworld
				? 0.42
				: 1,
				_flag_overworld
				? 0.42
				: 1,
				0,
				_c_thorny,
				0.82
			);

		break;

		//================//
		//MARTYR//
		//================//
		case "MARTYR":

			draw_set_colour(
				_c_accent
			);

			draw_set_alpha(
				0.30 +
					(
						0.20 *
						_val_pulse
					)
			);

			draw_circle(
				_val_x,
				_val_head_y,
				_val_head_radius,
				true
			);

			draw_line(
				_val_x -
					(
						_val_radius *
						0.55
					),
				_val_head_y,
				_val_x +
					(
						_val_radius *
						0.55
					),
				_val_head_y
			);

		break;

		//================//
		//MONARCH//
		//================//
		case "MONARCH":

			draw_set_colour(
				_c_accent
			);

			draw_set_alpha(0.78);

			var _val_crown_half_width =
				_val_head_radius *
					1.05;

			var _val_crown_top =
				_val_head_y -
					(
						_val_head_radius *
							0.70
					);

			var _val_crown_bottom =
				_val_head_y +
					(
						_val_head_radius *
							0.42
					);

			var _val_crown_mid =
				_val_head_y -
					(
						_val_head_radius *
							0.06
					);

			draw_rectangle(
				_val_x -
					_val_crown_half_width,
				_val_crown_mid,
				_val_x +
					_val_crown_half_width,
				_val_crown_bottom,
				false
			);

			draw_triangle(
				_val_x -
					_val_crown_half_width,
				_val_crown_mid,
				_val_x -
					(
						_val_head_radius *
							0.58
					),
				_val_crown_top,
				_val_x -
					(
						_val_head_radius *
							0.16
					),
				_val_crown_mid,
				false
			);

			draw_triangle(
				_val_x -
					(
						_val_head_radius *
							0.32
					),
				_val_crown_mid,
				_val_x,
				_val_crown_top -
					(
						_val_head_radius *
							0.20
					),
				_val_x +
					(
						_val_head_radius *
							0.32
					),
				_val_crown_mid,
				false
			);

			draw_triangle(
				_val_x +
					(
						_val_head_radius *
							0.16
					),
				_val_crown_mid,
				_val_x +
					(
						_val_head_radius *
							0.58
					),
				_val_crown_top,
				_val_x +
					_val_crown_half_width,
				_val_crown_mid,
				false
			);

		break;

		//================//
		//REFORGED//
		//================//
		case "REFORGED":

			draw_set_colour(
				_c_accent
			);

			draw_set_alpha(
				0.25 +
					(
						0.18 *
						_val_fast_pulse
					)
			);

			draw_circle(
				_val_x,
				_val_y,
				_val_radius,
				true
			);

			draw_line(
				_val_x -
					_val_small,
				_val_y -
					_val_small,
				_val_x +
					_val_small,
				_val_y +
					_val_small
			);

			draw_line(
				_val_x +
					_val_small,
				_val_y -
					_val_small,
				_val_x -
					_val_small,
				_val_y +
					_val_small
			);

		break;

		//================//
		//BLOODTHIRSTY//
		//================//
		case "BLOODTHIRSTY":

			draw_set_colour(
				c_red
			);

			draw_set_alpha(
				0.42 +
					(
						0.18 *
						_val_pulse
					)
			);

			draw_circle(
				_val_x,
				_val_head_y,
				_val_head_radius *
					0.82,
				true
			);

			draw_circle(
				_val_x,
				_val_head_y,
				_val_head_radius *
					1.08,
				true
			);

		break;
	}

	#endregion

	draw_set_alpha(1);
	draw_set_colour(c_white);
}
