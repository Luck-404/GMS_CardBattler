//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_CARD
// FUNCTION: Draws player and enemy battle Cards.
//           Handles movement flips, pile visuals, hover scaling, disabled and
//           unavailable states, and enlarged Card inspection previews.
//
// USES:     Card team, owner, location, movement state, Card sprite, player
//           controller state, turn state, and Ctrl-key inspection input.
//
//===============================================================================//

//-----------------//
//BATTLE END HIDDEN//
//-----------------//
if (instance_exists(obj_gui_end_battle_pane)){
	exit;
}

#region CARD MOVEMENT

//=======================//
//CARD MOVEMENT ANIMATION//
//=======================//
if (_str_team == "PLAYER" && _flag_card_moving){

	//-----------------//
	//HIDE DURING DELAY//
	//-----------------//
	if (_ct_card_move_delay > 0){
		exit;
	}

	//-------------------//
	//GET ANIMATION FRAME//
	//-------------------//
	var _ct_card_move_frame = clamp(_ct_card_move_timer - 1,0,7);
	var _flag_flip_first_half = (_ct_card_move_frame <= 3);

	//-----------------------//
	//CALCULATE FLIP PROGRESS//
	//-----------------------//
	var _val_flip_progress = 0;
	var _val_flip_scale_x = 0.3;

	if (_flag_flip_first_half){
		_val_flip_progress = _ct_card_move_frame / 3;
		_val_flip_scale_x = lerp(0.30,0.04,_val_flip_progress);
	}
	else{
		_val_flip_progress = (_ct_card_move_frame - 4) / 3;
		_val_flip_scale_x = lerp(0.04,0.30,_val_flip_progress);
	}

	//------------------//
	//SELECT FLIP SPRITE//
	//------------------//
	var _spr_move_card = _spr_card;

	if (_str_card_move_type == "DRAW"){
		_spr_move_card = _flag_flip_first_half ? spr_card_back : _spr_card;
	}
	else{
		_spr_move_card = _flag_flip_first_half ? _spr_card : spr_card_back;
	}

	//----------------//
	//DRAW MOVING CARD//
	//----------------//
	draw_sprite_ext(
		_spr_move_card,
		0,
		x,
		y,
		_val_flip_scale_x,
		0.30,
		0,
		c_white,
		1
	);

	exit;
}

#endregion

//----------------//
//NORMAL SELF DRAW//
//----------------//
draw_self();

#region PLAYER CARD

//============//
//PLAYER CARD//
//============//
if (_str_team == "PLAYER"){

	//--------------------//
	//RESET PRESENTATION//
	//--------------------//
	_spr_preview_card = undefined;

	_val_scale_x = 0.3;
	_val_scale_y = 0.3;
	_val_preview_scale = 1.0;

	//-----------------//
	//NON-HAND LOCATION//
	//-----------------//
	if (_str_location != "HAND"){

		var _c_card_back = c_white;

		switch(_str_location){

			case "DISCARD":
				_c_card_back = c_red;
			break;

			case "EXHAUST":
				_c_card_back = global.c_dk_gray;
			break;
		}

		draw_sprite_ext(
			spr_card_back,
			0,
			x,
			y,
			_val_scale_x,
			_val_scale_y,
			0,
			_c_card_back,
			1
		);
	}

	//----------//
	//HAND CARD//
	//----------//
	else{

		//-----//
		//HOVER//
		//-----//
		if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){

			_val_scale_x *= 1.15;
			_val_scale_y *= 1.15;

			if (keyboard_check(vk_lcontrol)){
				_spr_preview_card = _spr_card;
			}
		}

		//----------------//
		//GET CARD TINT//
		//----------------//
		var _c_card_tint = c_white;

		if (
			obj_battle_player_controller._state_player == ENUM_PLAYER_STATE.SELECT_CARD &&
			_flag_card_oom_check
		){
			_c_card_tint = c_ltgray;
		}
		else if (obj_battle_turn_controller._val_turn_tracker == 1){
			_c_card_tint = c_ltgray;
		}

		//----------//
		//DRAW CARD//
		//----------//
		draw_sprite_ext(
			_spr_card,
			0,
			x,
			y,
			_val_scale_x,
			_val_scale_y,
			0,
			_c_card_tint,
			1
		);
	}

	//----------------//
	//CLEAR OOM CHECK//
	//----------------//
	if (obj_battle_player_controller._state_player != ENUM_PLAYER_STATE.SELECT_CARD){
		_flag_card_oom_check = false;
	}
}

#endregion

#region ENEMY CARD

//===========//
//ENEMY CARD//
//===========//
else{

	//----------------//
	//VALIDATE OWNER//
	//----------------//
	if (!instance_exists(_ref_unit)){
		visible = false;
		exit;
	}

	x = _ref_unit.x;

	//-----------------//
	//DEFEATED OWNER//
	//-----------------//
	if (_ref_unit._val_cur_hp <= 0){
		visible = false;
	}

	//----------------//
	//LIVING OWNER//
	//----------------//
	else{

		_spr_preview_card = undefined;

		_val_scale_x = 0.15;
		_val_scale_y = 0.15;
		_val_preview_scale = 1.0;

		//----------//
		//DECK CARD//
		//----------//
		if (_str_location == "DECK"){
			visible = false;
		}

		//--------------//
		//REVEALED CARD//
		//--------------//
		else{

			visible = true;

			//-----//
			//HOVER//
			//-----//
			if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){

				_val_scale_x *= 1.15;
				_val_scale_y *= 1.15;

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

				draw_set_font(fnt_gui_small);
				draw_set_colour(c_black);
				draw_set_halign(fa_center);
				draw_set_valign(fa_middle);

				draw_text(x,y - 60,"DISABLED");

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

#region CARD PREVIEW

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

#endregion