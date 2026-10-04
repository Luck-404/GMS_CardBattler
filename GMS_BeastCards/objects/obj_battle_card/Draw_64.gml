//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_CARD
// FUNCTION: Draws animated player/enemy Cards using the existing movement system.
//           Uses native Card-object hitboxes for hover.
//
//           NORMAL HOVER:
//               - Slightly enlarges the Card.
//               - Displays the shared Card-name hover tooltip.
//
//           CTRL + HOVER:
//               - Slightly enlarges the Card.
//               - Draws the large centered Card preview in Draw GUI End.
//               - Registers the Card with the fixed battle inspection pane.
//
//===============================================================================//

//-----------------//
//BATTLE END HIDDEN//
//-----------------//
if (
	instance_exists(
		obj_gui_end_battle_pane
	)
){
	exit;
}

//================//
//CHEATS GUARD//
//================//
if (
	scr_gui_check_cheats_active()
){

	_spr_preview_card =
		undefined;
}

// A previously inspected player Card cannot retain a preview while moving
// or when it is no longer hovered.
if (_str_team == "PLAYER"){

	_spr_preview_card =
		undefined;
}

#region CARD MOVEMENT

if (
	_str_team == "PLAYER" &&
	_flag_card_moving
){

	if (_ct_card_move_delay > 0){
		exit;
	}

	var _val_progress =
		clamp(
			_val_card_move_progress,
			0,
			1
		);

	var _val_eased =
		1 -
		power(
			1 -
				_val_progress,
			3
		);

	var _val_scale =
		lerp(
			_val_card_move_scale_start,
			_val_card_move_scale_end,
			_val_eased
		);

	var _val_flip_x =
		1;

	var _spr_move_card =
		spr_card_back;

	if (_flag_card_move_flip){

		var _flag_first_half =
			(
				_val_progress <
				0.5
			);

		_val_flip_x =
			max(
				0.12,
				abs(
					1 -
					(
						2 *
						_val_progress
					)
				)
			);

		if (
			_str_card_move_type ==
			"DRAW"
		){

			_spr_move_card =
				_flag_first_half
					? spr_card_back
					: _spr_card;
		}
		else{

			_spr_move_card =
				_flag_first_half
					? _spr_card
					: spr_card_back;
		}
	}

	draw_sprite_ext(
		_spr_move_card,
		0,
		x,
		y,
		_val_scale *
			_val_flip_x,
		_val_scale,
		0,
		c_white,
		1
	);

	exit;
}

#endregion

#region PLAYER CARD

//============//
//PLAYER CARD//
//============//
if (_str_team == "PLAYER"){

	//--------------------//
	//RESET PRESENTATION//
	//--------------------//
	_spr_preview_card =
		undefined;

	_val_scale_x =
		0.30;

	_val_scale_y =
		0.30;

	_val_preview_scale =
		1.0;

	// Pile icons replace the old stack of Card backs.
	if (
		_str_location !=
		"HAND"
	){
		exit;
	}

	//--------//
	//HOVER//
	//--------//
	/*
		obj_battle_card continues using spr_battle_card_hitbox
		as its native sprite/collision.

		The Card artwork itself is only drawn through _spr_card.
	*/

	var _val_draw_x =
		x;

	var _flag_card_hover =
		position_meeting(
			device_mouse_x_to_gui(0),
			device_mouse_y_to_gui(0),
			self
		);

	if (_flag_card_hover){

		//================//
		//HOVER SCALE//
		//================//
		_val_scale_x =
			0.33;

		_val_scale_y =
			0.33;

		_val_draw_x =
			clamp(
				x,
				162,
				894
			);

		//================//
		//CTRL INSPECTION//
		//================//
		if (
			!scr_gui_check_cheats_active() &&
			keyboard_check(vk_lcontrol)
		){

			//--------------------//
			//LARGE CARD PREVIEW//
			//--------------------//
			_spr_preview_card =
				_spr_card;

			//---------------------//
			//INSPECTION PANE DATA//
			//---------------------//
			if (is_struct(_ref_card)){

				scr_gui_request_battle_inspection(
					"CARD",
					self,
					30
				);
			}
		}

		//================//
		//NORMAL TOOLTIP//
		//================//
		else if (
			!scr_gui_check_cheats_active() &&
			is_struct(_ref_card)
		){

			scr_gui_set_hover_tooltip(
				_ref_card._str_card_name,
				"",
				30
			);
		}
	}

	//----------------//
	//GET CARD TINT//
	//----------------//
	var _c_card_tint =
		c_white;

	if (
		obj_battle_player_controller
			._state_player ==
			ENUM_PLAYER_STATE.SELECT_CARD &&
		_flag_card_oom_check
	){

		_c_card_tint =
			c_ltgray;
	}
	else if (
		obj_battle_turn_controller
			._val_turn_tracker ==
			1
	){

		_c_card_tint =
			c_ltgray;
	}

	//-------------------//
	//DRAW CARD ARTWORK//
	//-------------------//
	draw_sprite_ext(
		_spr_card,
		0,
		_val_draw_x,
		y,
		_val_scale_x,
		_val_scale_y,
		0,
		_c_card_tint,
		1
	);

	//----------------//
	//CLEAR OOM CHECK//
	//----------------//
	if (
		obj_battle_player_controller
			._state_player !=
			ENUM_PLAYER_STATE.SELECT_CARD
	){

		_flag_card_oom_check =
			false;
	}

	exit;
}

#endregion

#region ENEMY CARD

//===========//
//ENEMY CARD//
//===========//
if (_str_team != "PLAYER"){

	draw_self();

	//----------------//
	//VALIDATE OWNER//
	//----------------//
	if (
		!instance_exists(
			_ref_unit
		)
	){

		visible =
			false;

		exit;
	}

	x =
		_ref_unit.x;

	//-----------------//
	//DEFEATED OWNER//
	//-----------------//
	if (
		_ref_unit._val_cur_hp <=
		0
	){

		visible =
			false;
	}

	//----------------//
	//LIVING OWNER//
	//----------------//
	else{

		//--------------------//
		//RESET PRESENTATION//
		//--------------------//
		_spr_preview_card =
			undefined;

		_val_scale_x =
			0.15;

		_val_scale_y =
			0.15;

		_val_preview_scale =
			1.0;

		//----------//
		//DECK CARD//
		//----------//
		if (
			_str_location ==
			"DECK"
		){

			visible =
				false;
		}

		//--------------//
		//REVEALED CARD//
		//--------------//
		else{

			visible =
				true;

			//-----//
			//HOVER//
			//-----//
			var _flag_enemy_card_hover =
				position_meeting(
					device_mouse_x_to_gui(0),
					device_mouse_y_to_gui(0),
					self
				);

			if (_flag_enemy_card_hover){

				//================//
				//HOVER SCALE//
				//================//
				_val_scale_x *=
					1.15;

				_val_scale_y *=
					1.15;

				//================//
				//CTRL INSPECTION//
				//================//
				if (
					!scr_gui_check_cheats_active() &&
					keyboard_check(vk_lcontrol)
				){

					//--------------------//
					//LARGE CARD PREVIEW//
					//--------------------//
					_spr_preview_card =
						_spr_card;

					//---------------------//
					//INSPECTION PANE DATA//
					//---------------------//
					if (is_struct(_ref_card)){

						scr_gui_request_battle_inspection(
							"CARD",
							self,
							30
						);
					}
				}

				//================//
				//NORMAL TOOLTIP//
				//================//
				else if (
					!scr_gui_check_cheats_active() &&
					is_struct(_ref_card)
				){

					scr_gui_set_hover_tooltip(
						_ref_card
							._str_card_name,
						"",
						30
					);
				}
			}

			//------------------//
			//DRAW DISABLED CARD//
			//------------------//
			if (_flag_card_disabled){

				draw_sprite_ext(
					_spr_card,
					0,
					x,
					y,
					_val_scale_x,
					_val_scale_y,
					0,
					c_ltgray,
					1
				);

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
					x,
					y - 60,
					"DISABLED"
				);

				draw_set_halign(
					fa_left
				);

				draw_set_valign(
					fa_top
				);
			}

			//----------------//
			//DRAW NORMAL CARD//
			//----------------//
			else{

				draw_sprite_ext(
					_spr_card,
					0,
					x,
					y,
					_val_scale_x,
					_val_scale_y,
					0,
					c_white,
					1
				);
			}
		}
	}
}

#endregion