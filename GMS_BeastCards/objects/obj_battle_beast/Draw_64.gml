//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_BEAST
// FUNCTION: Draws a battle Beast and its combat GUI.
//           Handles targeting/caster feedback, HP, Overhealth, Armor,
//           staged Beast sprite frames, selection markers, battle presentation,
//           and shared hover tooltips.
//
//           Elite presentation uses fixed context scales plus a proportional
//           vertical lift. Beast positioning never depends on sprite bounds.
//           Elite modifier VFX may inspect the sprite hitbox only to position
//           overhead motifs above the visible Beast. Elite pseudo-status badge
//           presentation occupies Status slot 0 and takes hover priority.
//
//===============================================================================//

if (!instance_exists(obj_gui_end_battle_pane)){

	draw_set_font(fnt_gui_small);

	#region STATE

	//----------------//
	//STATE SHORTCUTS//
	//----------------//
	var _flag_state_select_caster =
		(obj_battle_player_controller._state_player == ENUM_PLAYER_STATE.SELECT_CASTER);

	var _flag_state_select_card_target =
		(obj_battle_player_controller._state_player == ENUM_PLAYER_STATE.SELECT_TARGET);

	var _flag_state_select_prism_target =
		(obj_battle_player_controller._state_player == ENUM_PLAYER_STATE.SELECT_PRISM_TARGET);

	var _flag_state_select_any_target =
		(
			_flag_state_select_card_target ||
			_flag_state_select_prism_target
		);

	//========================//
	//ELITE BADGE POSITION//
	//========================//
	/*
		The Elite badge is presentation-only Status slot 0. Ensure its coordinates
		exist before resolving native Beast hover so the badge can win overlap.
	*/
	if (
		_flag_elite &&
		(
			!variable_instance_exists(
				self,
				"_val_elite_status_icon_x"
			) ||
			!variable_instance_exists(
				self,
				"_val_elite_status_icon_y"
			)
		)
	){
		scr_status_reposition(
			self
		);
	}

	//----------------//
	//MOUSE//
	//----------------//
	var _val_mouse_x =
		device_mouse_x_to_gui(0);

	var _val_mouse_y =
		device_mouse_y_to_gui(0);

	//=================//
	//ELITE BADGE HOVER//
	//=================//
	var _flag_elite_badge_hover =
		false;

	if (
		_flag_elite &&
		variable_instance_exists(
			self,
			"_val_elite_status_icon_x"
		) &&
		variable_instance_exists(
			self,
			"_val_elite_status_icon_y"
		)
	){
		_flag_elite_badge_hover =
			point_distance(
				_val_mouse_x,
				_val_mouse_y,
				_val_elite_status_icon_x,
				_val_elite_status_icon_y
			) <=
			14;
	}

	//----------------//
	//HOVER SHORTCUT//
	//----------------//
	var _flag_mouse_hover =
		position_meeting(
			_val_mouse_x,
			_val_mouse_y,
			self
		) &&
		!_flag_elite_badge_hover;

	#endregion

	#region BEAST DRAW

	//----------------//
	//DRAW VARIABLES//
	//----------------//
	var _val_scale_x =
		(_str_team == "PLAYER")
		? 0.2
		: -0.2;

	var _val_scale_y = 0.2;

	var _val_beast_draw_x =
		x +
		_val_vfx_offset_x;

	var _val_beast_draw_y =
		y +
		_val_vfx_offset_y;

	var _val_beast_subimage =
		scr_beast_animation_get_frame(self);

	var _flag_beast_uses_staged_animation =
		scr_beast_animation_is_valid(
			scr_beast_animation_get_name(self)
		);

	//------------------//
	//REFRESH FORM DRAW//
	//------------------//
	scr_battle_refresh_beast_form_draw(
		self
	);

	_val_scale_x *=
		_val_beast_draw_scale_multiplier;

	_val_scale_y *=
		_val_beast_draw_scale_multiplier;

	//=====================//
	//ELITE SCALE / LIFT//
	//=====================//
	var _val_elite_vertical_lift = 0;

	if (_flag_elite){
		/*
			Battle Elite baseline:
			1.40x = 25 px upward. Larger modifier-specific scales receive
			proportionally more lift, quantized to 5 px tuning increments.
			No sprite bbox/origin data participates in Beast positioning.
		*/
		var _val_elite_lift_raw =
			25 *
			(
				max(
					0,
					_val_elite_draw_scale_multiplier - 1
				) /
				0.40
			);

		_val_elite_vertical_lift =
			floor(
				(
					_val_elite_lift_raw +
					2.5
				) /
				5
			) *
			5;

		_val_beast_draw_y -=
			_val_elite_vertical_lift;
	}

	_val_scale_x *=
		_val_elite_draw_scale_multiplier;

	_val_scale_y *=
		_val_elite_draw_scale_multiplier;

	//===================//
	//ELITE HP LAYOUT//
	//===================//
	/*
		Keep the HP bar 10 px higher than the previous follow-up while moving the
		Elite Status grid by the same amount in SCR_STATUS_REPOSITION. This preserves
		the full 15-Status presentation capacity and exposes more modifier motif.
	*/
	var _val_elite_hp_bar_lift =
		_flag_elite
		? _val_elite_vertical_lift + 10
		: 0;

	var _val_elite_hp_bar_y =
		y -
		70 -
		_val_elite_hp_bar_lift;

	//===================//
	//FINAL BEAST TINT//
	//===================//
	/*
		Priority:
		1. Elite modifier tint (currently GOLDEN / HARDY)
		2. Abyssal Form
		3. Frostform
		4. Normal white

		scr_battle_refresh_beast_form_draw already resolves Abyssal Form over
		Frostform. The Elite tint helper receives that result as its fallback.
	*/
	var _c_final_beast_draw_tint =
		_c_beast_draw_tint;

	if (_flag_elite){
		_c_final_beast_draw_tint =
			scr_elite_get_beast_tint(
				_str_elite_modifier,
				"BATTLE",
				_c_beast_draw_tint
			);
	}

	//-----------------//
	//CAPTURED DISPLAY//
	//-----------------//
	if (_flag_captured){

		draw_sprite(
			spr_battle_beast_captured,
			0,
			x,
			y
		);

		exit;
	}

	//-------------//
	//NORMAL HOVER//
	//-------------//
	if (_flag_mouse_hover){

		_val_scale_x *= 1.15;
		_val_scale_y *= 1.15;

		//================//
		//HOVER FEEDBACK//
		//================//
		if (!scr_gui_check_cheats_active()){

			//----------------//
			//CTRL INSPECTION//
			//----------------//
			if (
				keyboard_check(
					vk_lcontrol
				)
			){

				/*
					The old large centered Beast pane is retired.
					The shared fixed battle inspector now owns presentation.
				*/
				_flag_preview_beast =
					false;

				scr_gui_request_battle_inspection(
					"BEAST",
					self,
					20
				);
			}

			//----------------//
			//SIMPLE TOOLTIP//
			//----------------//
			else{

				_flag_preview_beast =
					false;

				if (is_struct(_ref_unit)){

					scr_gui_set_hover_tooltip(
						_ref_unit._str_beast_name,
						"",
						20
					);
				}
			}
		}
		else{

			_flag_preview_beast =
				false;
		}

		//---------------------//
		//PRISM TARGETING ICON//
		//---------------------//
		if (
			_flag_state_select_prism_target &&
			_str_team == "ENEMY" &&
			_str_list == "ALIVE" &&
			_val_cur_hp > 0 &&
			_flag_beast_range_check
		){

			draw_sprite(
				spr_battle_icon_target_hover,
				0,
				x,
				y - 50
			);
		}

		//-------------------//
		//PRISM TAME PREVIEW//
		//-------------------//
		if (
			_flag_state_select_prism_target &&
			_str_team == "ENEMY" &&
			_str_list == "ALIVE" &&
			_val_cur_hp > 0 &&
			_flag_beast_range_check &&
			obj_battle_player_controller
				._stct_selected_prism != undefined
		){

			var _val_tame_chance =
				scr_battle_get_prism_tame_chance(
					obj_battle_player_controller
						._stct_selected_prism
						._str_item_id,
					self
				);

			draw_set_font(
				fnt_gui_small
			);

			draw_set_halign(
				fa_center
			);

			draw_set_valign(
				fa_top
			);

			draw_set_colour(
				c_black
			);

			draw_text(
				x,
				y - 115,
				"TAME: " +
				string(_val_tame_chance) +
				"%"
			);

			draw_set_halign(
				fa_left
			);

			draw_set_valign(
				fa_top
			);
		}
	}
	else{

		_flag_preview_beast =
			false;
	}

	//----------------//
	//CASTER PREVIEW//
	//----------------//
	if (
		_flag_state_select_caster &&
		_str_team == "PLAYER" &&
		_str_list == "ALIVE" &&
		_val_cur_hp > 0
	){

		//------------------//
		//VALID CASTER ICON//
		//------------------//
		var _flag_valid_caster =
			(
				_flag_beast_color_check &&
				_flag_beast_able_check &&
				_flag_beast_archetype_check &&
				_flag_beast_class_check
			);

		if (_flag_valid_caster){

			draw_sprite(
				spr_battle_icon_caster_hover,
				0,
				x,
				y - 50
			);
		}

		//-------------------//
		//CASTER STAT RATING//
		//-------------------//
		if (
			instance_exists(global.ref_cast_card) &&
			is_struct(
				global.ref_cast_card._ref_card
			)
		){

			var _str_caster_preview =
				scr_battle_get_card_caster_preview(
					global.ref_cast_card._ref_card,
					self
				);

			if (_str_caster_preview != ""){

				draw_set_font(
					fnt_gui_party_small
				);

				draw_set_colour(
					c_black
				);

				draw_set_halign(
					fa_center
				);

				draw_set_valign(
					fa_top
				);

				draw_text(
					x,
					y - 115,
					_str_caster_preview
				);

				draw_set_halign(
					fa_left
				);

				draw_set_valign(
					fa_top
				);
			}
		}
	}

	//----------------//
	//TARGET PREVIEW//
	//----------------//
	if (
		_flag_state_select_card_target &&
		_str_list == "ALIVE" &&
		_val_cur_hp > 0 &&
		_flag_beast_range_check &&
		instance_exists(global.ref_cast_card) &&
		is_struct(
			global.ref_cast_card._ref_card
		)
	){

		var _str_target_preview =
			scr_battle_get_card_target_preview(
				global.ref_cast_card._ref_card,
				self
			);

		if (_str_target_preview != ""){

			draw_set_font(
				fnt_gui_party_small
			);

			draw_set_colour(
				c_black
			);

			draw_set_halign(
				fa_center
			);

			draw_set_valign(
				fa_top
			);

			draw_text(
				x,
				y - 115,
				_str_target_preview
			);

			draw_set_halign(
				fa_left
			);

			draw_set_valign(
				fa_top
			);
		}
	}

	//--------//
	//SHADOW//
	//--------//
	var _spr_shadow =
		scr_beast_get_type_shadow(
			_ref_unit._str_beast_color_type
		);

	var _val_shadow_scale =
		1.5 *
		(
			_flag_elite
			? _val_elite_draw_scale_multiplier
			: 1
		);

	draw_sprite_ext(
		_spr_shadow,
		0,
		x,
		y + 40,
		_val_shadow_scale,
		_val_shadow_scale,
		0,
		c_white,
		1
	);

	//====================//
	//ELITE MODIFIER VFX//
	//====================//
	if (_val_cur_hp > 0){
		scr_elite_draw_modifier_vfx(
			self,
			_spr_beast,
			_val_beast_draw_x,
			_val_beast_draw_y,
			_val_scale_x,
			_val_scale_y,
			_val_vfx_angle,
			"BATTLE",
			_val_elite_hp_bar_y
		);
	}

	//-------------//
	//BEAST SPRITE//
	//-------------//
	if (_val_cur_hp <= 0){

		var _c_dead_beast =
			_flag_corpse_consumed
			? global.c_dk_gray
			: c_ltgray;

		draw_sprite_ext(
			_spr_beast,
			_val_beast_subimage,
			_val_beast_draw_x,
			_val_beast_draw_y,
			_val_scale_x,
			_val_scale_y,
			_val_vfx_angle,
			_c_dead_beast,
			1
		);

		// Animated Beasts already present their corpse through the final DEATH
		// subimage (frame 9 for the current staged layout). Species validity is
		// checked directly so initialization/order cannot re-enable the legacy overlay.
		if (!_flag_beast_uses_staged_animation){
			draw_sprite_ext(
				spr_battle_beast_dead,
				0,
				x,
				y,
				1,
				1,
				0,
				_c_dead_beast,
				1
			);
		}
	}

	//--------------------//
	//INVALID CASTER GREY//
	//--------------------//
	else if (
		_flag_state_select_caster &&
		(
			!_flag_beast_able_check ||
			!_flag_beast_color_check ||
			!_flag_beast_archetype_check ||
			!_flag_beast_class_check
		)
	){

		draw_sprite_ext(
			_spr_beast,
			_val_beast_subimage,
			_val_beast_draw_x,
			_val_beast_draw_y,
			_val_scale_x,
			_val_scale_y,
			_val_vfx_angle,
			c_ltgray,
			1
		);
	}

	//--------------------//
	//INVALID TARGET GREY//
	//--------------------//
	else if (
		_flag_state_select_any_target &&
		!_flag_beast_range_check
	){

		draw_sprite_ext(
			_spr_beast,
			_val_beast_subimage,
			_val_beast_draw_x,
			_val_beast_draw_y,
			_val_scale_x,
			_val_scale_y,
			_val_vfx_angle,
			c_ltgray,
			1
		);
	}

	//-------------//
	//NORMAL BEAST//
	//-------------//
	else{

		draw_sprite_ext(
			_spr_beast,
			_val_beast_subimage,
			_val_beast_draw_x,
			_val_beast_draw_y,
			_val_scale_x,
			_val_scale_y,
			_val_vfx_angle,
			_c_final_beast_draw_tint,
			1
		);
	}

	//-------------------//
	//RESET CASTER CHECKS//
	//-------------------//
	if (!_flag_state_select_caster){

		_flag_beast_color_check = true;
		_flag_beast_archetype_check = true;
		_flag_beast_class_check = true;
		_flag_beast_able_check = true;
	}

	//------------------//
	//RESET RANGE CHECK//
	//------------------//
	if (!_flag_state_select_any_target){

		_flag_beast_range_check =
			true;
	}

	#endregion

	#region HP BAR

	//---------------//
	//BAR DIMENSIONS//
	//---------------//
	var _val_bar_w = 96;
	var _val_bar_h = 10;

	var _val_bar_x1 =
		x -
		(_val_bar_w * 0.5);

	//-------------------//
	//ELITE BAR CLEARANCE//
	//-------------------//
	/*
		The shared Elite HP Y was resolved before modifier VFX so THORNY can remain
		anchored underneath the HP bar. Normal Beast HP placement remains unchanged.
	*/
	var _val_bar_y1 =
		_val_elite_hp_bar_y;

	var _val_bar_x2 =
		_val_bar_x1 +
		_val_bar_w;

	var _val_bar_y2 =
		_val_bar_y1 +
		_val_bar_h;

	//------------//
	//BACKGROUND//
	//------------//
	draw_set_colour(
		c_red
	);

	draw_rectangle(
		_val_bar_x1,
		_val_bar_y1,
		_val_bar_x2,
		_val_bar_y2,
		false
	);

	//-------------//
	//SECOND LIFE//
	//-------------//
	var _ref_second_life =
		scr_status_check(
			"SECOND_LIFE",
			self
		);

	if (_ref_second_life != -1){

		draw_set_font(
			fnt_gui_small
		);

		draw_set_colour(
			c_black
		);

		draw_set_halign(
			fa_center
		);

		draw_set_valign(
			fa_middle
		);

		draw_text(
			_val_bar_x1 - 16,
			_val_bar_y1 +
				(_val_bar_h * 0.5),
			"X2"
		);

		draw_set_halign(
			fa_left
		);

		draw_set_valign(
			fa_top
		);
	}

	//-------//
	//HP FILL//
	//-------//
	var _val_hp_fill =
		clamp(
			_val_cur_hp /
			max(1,_val_max_hp),
			0,
			1
		);

	draw_set_colour(
		c_green
	);

	draw_rectangle(
		_val_bar_x1,
		_val_bar_y1,
		_val_bar_x1 +
			(_val_bar_w * _val_hp_fill),
		_val_bar_y2,
		false
	);

	//------------//
	//OVERHEALTH//
	//------------//
	if (_val_overhealth > 0){

		var _ct_pip =
			min(
				ceil(
					_val_overhealth /
					5
				),
				10
			);

		var _val_pip_size = 8;
		var _val_pip_gap = 1;

		var _val_pip_x =
			_val_bar_x1 + 2;

		var _val_pip_y =
			_val_bar_y1 + 1;

		for (
			var _it_pip = 0;
			_it_pip < _ct_pip;
			_it_pip++
		){

			var _val_pip_draw_x =
				_val_pip_x +
				(
					_it_pip *
					(
						_val_pip_size +
						_val_pip_gap
					)
				);

			draw_set_colour(
				c_lime
			);

			draw_rectangle(
				_val_pip_draw_x,
				_val_pip_y,
				_val_pip_draw_x +
					_val_pip_size,
				_val_pip_y +
					_val_pip_size,
				false
			);

			draw_set_colour(
				c_black
			);

			draw_rectangle(
				_val_pip_draw_x,
				_val_pip_y,
				_val_pip_draw_x +
					_val_pip_size,
				_val_pip_y +
					_val_pip_size,
				true
			);
		}
	}

	//-----------//
	//BAR BORDER//
	//-----------//
	draw_set_colour(
		c_black
	);

	draw_rectangle(
		_val_bar_x1,
		_val_bar_y1,
		_val_bar_x2,
		_val_bar_y2,
		true
	);

	//===================//
	//ELITE STATUS BADGE//
	//===================//
	if (_flag_elite){
		/*
			Elite identity is presentation-only. SCR_STATUS_REPOSITION reserves visual
			Status slot 0 for this badge and offsets real Statuses by one slot.
		*/
		if (
			!variable_instance_exists(
				self,
				"_val_elite_status_icon_x"
			) ||
			!variable_instance_exists(
				self,
				"_val_elite_status_icon_y"
			)
		){
			scr_status_reposition(
				self
			);
		}

		var _val_elite_icon_x =
			variable_instance_exists(
				self,
				"_val_elite_status_icon_x"
			)
			? _val_elite_status_icon_x
			: x;

		var _val_elite_icon_y =
			variable_instance_exists(
				self,
				"_val_elite_status_icon_y"
			)
			? _val_elite_status_icon_y
			: _val_bar_y1 - 30;

		var _stct_elite_info =
			scr_battle_elite_get_info(
				_str_elite_modifier
			);

		var _c_elite_marker = c_white;
		var _str_elite_tooltip_title = "ELITE";
		var _str_elite_tooltip_body = "MODIFIER: " + _str_elite_modifier;

		if (is_struct(_stct_elite_info)){
			_c_elite_marker = _stct_elite_info._c_elite_tint;
			_str_elite_tooltip_title =
				"ELITE: " + _stct_elite_info._str_elite_name;
			_str_elite_tooltip_body =
				_stct_elite_info._str_elite_desc;

			if (
				!_stct_elite_info
					._flag_elite_mechanic_active
			){
				_str_elite_tooltip_body +=
					"\nMECHANIC PENDING STEP 6";
			}
		}

		if (
			is_struct(_ref_unit) &&
			variable_struct_exists(
				_ref_unit,
				"_arr_elite_card_ids"
			) &&
			is_array(
				_ref_unit._arr_elite_card_ids
			) &&
			array_length(
				_ref_unit._arr_elite_card_ids
			) > 0
		){
			_str_elite_tooltip_body +=
				"\nELITE CARDS: " +
				string(
					array_length(
						_ref_unit._arr_elite_card_ids
					)
				);
		}

		if (
			is_struct(_ref_unit) &&
			variable_struct_exists(
				_ref_unit,
				"_str_elite_monarch_card_id"
			) &&
			string(
				_ref_unit._str_elite_monarch_card_id
			) !=
			""
		){
			_str_elite_tooltip_body +=
				"\nMONARCH: " +
				string_upper(
					string(
						_ref_unit
							._str_elite_monarch_card_id
					)
				);
		}

		//==============================//
		//ELITE DYNAMIC COUNTER / INFO//
		//==============================//
		var _str_elite_counter = "";

		//----------//
		//VENGEFUL//
		//----------//
		if (_str_elite_modifier == "VENGEFUL"){
			var _ct_vengeful_stacks = 0;

			if (
				is_struct(_ref_unit) &&
				variable_struct_exists(
					_ref_unit,
					"_arr_elite_vengeful_counted_death_uids"
				) &&
				is_array(
					_ref_unit
						._arr_elite_vengeful_counted_death_uids
				)
			){
				_ct_vengeful_stacks =
					array_length(
						_ref_unit
							._arr_elite_vengeful_counted_death_uids
					);
			}

			_str_elite_counter =
				string(_ct_vengeful_stacks);

			_str_elite_tooltip_body +=
				"\nVENGEFUL STACKS: " +
				string(_ct_vengeful_stacks) +
				"\nCURRENT BONUS: +" +
				string(_ct_vengeful_stacks * 10) +
				"% PRIMARY STATS";
		}

		//---------//
		//PHASING//
		//---------//
		else if (_str_elite_modifier == "PHASING"){
			var _ct_phasing_turns_seen = 0;

			if (
				variable_instance_exists(
					self,
					"_ct_elite_phasing_turns_seen"
				)
			){
				_ct_phasing_turns_seen =
					max(
						0,
						_ct_elite_phasing_turns_seen
					);
			}

			var _ct_phasing_turns_remaining =
				3 -
				(_ct_phasing_turns_seen mod 3);

			_str_elite_counter =
				string(_ct_phasing_turns_remaining);

			_str_elite_tooltip_body +=
				"\nPHASING IN: " +
				string(_ct_phasing_turns_remaining) +
				(
					_ct_phasing_turns_remaining == 1
					? " TURN"
					: " TURNS"
				);
		}

		//=================//
		//BADGE ABBREVIATION//
		//=================//
		var _str_elite_badge_text =
			string_copy(
				string_upper(
					string(
						_str_elite_modifier
					)
				),
				1,
				2
			);

		if (_str_elite_badge_text == ""){
			_str_elite_badge_text = "EL";
		}

		draw_set_colour(
			_c_elite_marker
		);

		draw_circle(
			_val_elite_icon_x,
			_val_elite_icon_y,
			10,
			false
		);

		draw_set_colour(
			c_black
		);

		draw_circle(
			_val_elite_icon_x,
			_val_elite_icon_y,
			10,
			true
		);

		draw_set_font(
			fnt_gui_party_small
		);

		draw_set_colour(
			c_white
		);

		draw_set_halign(
			fa_center
		);

		draw_set_valign(
			fa_middle
		);

		draw_text(
			_val_elite_icon_x,
			_val_elite_icon_y,
			_str_elite_badge_text
		);

		//=======================//
		//ELITE COUNTER BADGE//
		//=======================//
		if (_str_elite_counter != ""){
			var _val_elite_counter_x =
				_val_elite_icon_x + 8;

			var _val_elite_counter_y =
				_val_elite_icon_y + 8;

			draw_set_colour(c_black);
			draw_circle(
				_val_elite_counter_x,
				_val_elite_counter_y,
				6,
				false
			);

			draw_set_colour(_c_elite_marker);
			draw_circle(
				_val_elite_counter_x,
				_val_elite_counter_y,
				6,
				true
			);

			draw_set_colour(c_white);
			draw_text(
				_val_elite_counter_x,
				_val_elite_counter_y,
				_str_elite_counter
			);
		}

		//==================//
		//BADGE INTERACTION//
		//==================//
		if (
			!scr_gui_check_cheats_active() &&
			_flag_elite_badge_hover
		){
			if (
				keyboard_check(
					vk_lcontrol
				)
			){
				scr_gui_request_battle_inspection(
					"BEAST",
					self,
					60
				);
			}
			else{
				scr_gui_set_hover_tooltip(
					_str_elite_tooltip_title,
					_str_elite_tooltip_body,
					60
				);
			}
		}

		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}

	//-------//
	//HP TEXT//
	//-------//
	draw_set_font(
		fnt_gui_small
	);

	draw_set_colour(
		c_black
	);

	var _str_hp_text =
		string(_val_cur_hp);

	if (_val_overhealth > 0){

		_str_hp_text +=
			" (+" +
			string(_val_overhealth) +
			")";
	}

	_str_hp_text +=
		"/" +
		string(_val_max_hp);

	draw_text(
		x -
			(
				string_width(
					_str_hp_text
				) *
				0.5
			),
		_val_bar_y1 - 16,
		_str_hp_text
	);

	#endregion

	#region ARMOR

	//------------//
	//DRAW ARMOR//
	//------------//
	if (_val_armor > 0){

		draw_set_font(
			fnt_gui_small
		);

		draw_set_colour(
			c_white
		);

		var _val_armor_icon_x =
			_val_bar_x2 - 16;

		var _val_armor_icon_y =
			_val_bar_y2 + 16;

		draw_sprite(
			spr_battle_icon_armor,
			0,
			_val_armor_icon_x,
			_val_armor_icon_y
		);

		draw_set_halign(
			fa_center
		);

		draw_set_valign(
			fa_middle
		);

		draw_text(
			_val_armor_icon_x,
			_val_armor_icon_y,
			string(_val_armor)
		);

		//================//
		//ARMOR TOOLTIP//
		//================//
		if (
			!scr_gui_check_cheats_active() &&
			point_in_rectangle(
				_val_mouse_x,
				_val_mouse_y,
				_val_armor_icon_x - 16,
				_val_armor_icon_y - 16,
				_val_armor_icon_x + 16,
				_val_armor_icon_y + 16
			)
		){

			scr_gui_set_hover_tooltip(
				"ARMOR",
				"",
				60
			);
		}

		draw_set_halign(
			fa_left
		);

		draw_set_valign(
			fa_top
		);
	}

	#endregion

	#region TARGETING ICONS

	//------------------------------//
	//CASTER ICON WHILE TARGETING//
	//------------------------------//
	if (
		_flag_state_select_card_target &&
		self == global.ref_caster_beast
	){

		draw_sprite(
			spr_battle_icon_caster_hover,
			0,
			x,
			y - 50
		);
	}

	//-------------------//
	//TARGET PREVIEW ICON//
	//-------------------//
	if (
		_flag_state_select_card_target &&
		_str_list == "ALIVE" &&
		_val_cur_hp > 0
	){

		var _arr_target_preview =
			obj_battle_player_controller
				._arr_target_preview;

		for (
			var _it_preview = 0;
			_it_preview <
				array_length(
					_arr_target_preview
				);
			_it_preview++
		){

			if (
				_arr_target_preview[
					_it_preview
				] == id
			){

				draw_sprite(
					spr_battle_icon_target_hover,
					0,
					x,
					y - 50
				);

				break;
			}
		}
	}

	#endregion

	#region SELECTION

	//----------------//
	//CASTER SELECTION//
	//----------------//
	if (
		global.ref_caster_beast ==
		self
	){

		draw_set_colour(
			c_black
		);

		draw_rectangle(
			x - 70,
			y - 90,
			x + 70,
			y + 90,
			true
		);
	}

	//----------------//
	//TARGET SELECTION//
	//----------------//
	if (
		global.ref_target_beast ==
		self
	){

		draw_set_colour(
			c_black
		);

		draw_rectangle(
			x - 75,
			y - 95,
			x + 75,
			y + 95,
			true
		);
	}

	#endregion

	//================//
	//RESET DRAW STATE//
	//================//
	draw_set_alpha(1);
	draw_set_colour(c_white);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
