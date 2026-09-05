//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_CARD
// FUNCTION: Draws player and enemy battle cards.
//           Handles card movement and flip presentation.
//           Handles hand/deck/discard/exhaust visuals, hover scaling,
//           disabled tinting, and card previews.
//
//===============================================================================//

//-----------------//
//BATTLE END HIDDEN//
//-----------------//
if (instance_exists(obj_gui_end_battle_pane)){
	exit;
}

//=======================//
//CARD MOVEMENT ANIMATION//
//=======================//
if (
	_str_team == "PLAYER" &&
	_flag_card_moving
){

	//-----------------//
	//HIDE DURING DELAY//
	//-----------------//
	if (_ct_card_move_delay > 0){
		exit;
	}

	//-------------------//
	//GET ANIMATION FRAME//
	//-------------------//
	var _ct_move_frame = clamp(
		_ct_card_move_timer - 1,
		0,
		7
	);

	var _val_flip_scale_x =
		0.3;

	//==============================//
	//DRAW: BACK -> EDGE -> CARD FACE//
	//==============================//
	if (_str_card_move_type == "DRAW"){

		//----------------//
		//BACK CLOSES//
		//----------------//
		if (_ct_move_frame <= 3){

			var _val_flip_progress =
				_ct_move_frame /
				3;

			_val_flip_scale_x = lerp(
				0.30,
				0.04,
				_val_flip_progress
			);

			draw_sprite_ext(
				spr_card_back,
				0,
				x,
				y,
				_val_flip_scale_x,
				0.30,
				0,
				c_white,
				1
			);
		}

		//----------------//
		//FACE OPENS//
		//----------------//
		else{

			var _val_flip_progress =
				(_ct_move_frame - 4) /
				3;

			_val_flip_scale_x = lerp(
				0.04,
				0.30,
				_val_flip_progress
			);

			draw_sprite_ext(
				_spr_card,
				0,
				x,
				y,
				_val_flip_scale_x,
				0.30,
				0,
				c_white,
				1
			);
		}
	}

	//===================================//
	//DISCARD / EXHAUST: FACE -> CARD BACK//
	//===================================//
	else{

		//----------------//
		//FACE CLOSES//
		//----------------//
		if (_ct_move_frame <= 3){

			var _val_flip_progress =
				_ct_move_frame /
				3;

			_val_flip_scale_x = lerp(
				0.30,
				0.04,
				_val_flip_progress
			);

			draw_sprite_ext(
				_spr_card,
				0,
				x,
				y,
				_val_flip_scale_x,
				0.30,
				0,
				c_white,
				1
			);
		}

		//----------------//
		//BACK OPENS//
		//----------------//
		else{

			var _val_flip_progress =
				(_ct_move_frame - 4) /
				3;

			_val_flip_scale_x = lerp(
				0.04,
				0.30,
				_val_flip_progress
			);

			draw_sprite_ext(
				spr_card_back,
				0,
				x,
				y,
				_val_flip_scale_x,
				0.30,
				0,
				c_white,
				1
			);
		}
	}

	exit;
}

//----------------//
//NORMAL SELF DRAW//
//----------------//
draw_self();

//
// PLAYER CARD
//
#region PLAYER CARD

if (_str_team == "PLAYER"){

	_spr_preview_card = undefined;

	_val_scale_x = 0.3;
	_val_scale_y = 0.3;
	_val_preview_scale = 1.0;

	//-----------------//
	//NON-HAND LOCATION//
	//-----------------//
	if (_str_location != "HAND"){

		switch(_str_location){

			case "DISCARD":

				draw_sprite_ext(
					spr_card_back,
					0,
					x,
					y,
					_val_scale_x,
					_val_scale_y,
					0,
					c_red,
					1
				);

			break;

			case "EXHAUST":

				draw_sprite_ext(
					spr_card_back,
					0,
					x,
					y,
					_val_scale_x,
					_val_scale_y,
					0,
					global.c_dk_gray,
					1
				);

			break;

			default:

				draw_sprite_ext(
					spr_card_back,
					0,
					x,
					y,
					_val_scale_x,
					_val_scale_y,
					0,
					c_white,
					1
				);

			break;
		}
	}

	//----------//
	//HAND CARD//
	//----------//
	else{

		//-----//
		//HOVER//
		//-----//
		if (
			position_meeting(
				device_mouse_x_to_gui(0),
				device_mouse_y_to_gui(0),
				self
			)
		){

			_val_scale_x *=
				1.15;

			_val_scale_y *=
				1.15;

			if (keyboard_check(vk_lcontrol)){
				_spr_preview_card = _spr_card;
			}
		}

		//----------------//
//OUT OF MANA CARD//
//----------------//
		if (
			obj_battle_player_controller._state_player ==
				ENUM_PLAYER_STATE.SELECT_CARD &&
			_flag_card_oom_check
		){

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
		}

		//-----------//
//NORMAL CARD//
//-----------//
		else{

			if (
				obj_battle_turn_controller._val_turn_tracker ==
				1
			){

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
			}
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

	//----------------//
//CLEAR OOM CHECK//
//----------------//
	if (
		obj_battle_player_controller._state_player !=
			ENUM_PLAYER_STATE.SELECT_CARD
	){
		_flag_card_oom_check = false;
	}
}

#endregion

//
// ENEMY CARD
//
#region ENEMY CARD

else{

	x = _ref_unit.x;

	if (_ref_unit._val_cur_hp <= 0){

		visible = false;
	}
	else{

		_spr_preview_card = undefined;

		_val_scale_x = 0.15;
		_val_scale_y = 0.15;
		_val_preview_scale = 1.0;

		if (_str_location == "DECK"){

			visible = false;
		}
		else{

			visible = true;

			//-----//
			//HOVER//
			//-----//
			if (
				position_meeting(
					device_mouse_x_to_gui(0),
					device_mouse_y_to_gui(0),
					self
				)
			){

				_val_scale_x *=
					1.15;

				_val_scale_y *=
					1.15;

				if (keyboard_check(vk_lcontrol)){
					_spr_preview_card = _spr_card;
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

				draw_set_font(fnt_small_gui);
				draw_set_colour(c_black);
				draw_set_halign(fa_center);
				draw_set_valign(fa_middle);

				draw_text(
					x,
					y - 60,
					"DISABLED"
				);

				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
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

//------------//
//CARD PREVIEW//
//------------//
if (_spr_preview_card != undefined){

	draw_sprite_ext(
		_spr_preview_card,
		0,
		room_width * 0.5,
		room_height * 0.5,
		_val_preview_scale,
		_val_preview_scale,
		0,
		c_white,
		1
	);
}