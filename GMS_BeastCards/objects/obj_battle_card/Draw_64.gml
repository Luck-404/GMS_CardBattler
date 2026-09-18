//===============================================================================//
//
// DRAW GUI: OBJ_BATTLE_CARD
// FUNCTION: Draws animated player Cards using the existing movement system.
//           Restores native sprite-based Hand hover and Ctrl preview,
//           while preserving enemy Card rendering and the HUD layout.
//
//===============================================================================//

//-----------------//
//BATTLE END HIDDEN//
//-----------------//
if (instance_exists(obj_gui_end_battle_pane)){
    exit;
}

// A previously inspected Card cannot retain a preview while moving.
if (_str_team == "PLAYER"){
    _spr_preview_card = undefined;
}

#region CARD MOVEMENT

if (_str_team == "PLAYER" && _flag_card_moving){

    if (_ct_card_move_delay > 0){
        exit;
    }

    // Retain the existing two-phase face flip, now over a variable card scale.
    var _val_progress = clamp(_val_card_move_progress,0,1);
    var _val_eased = 1 - power(1 - _val_progress,3);
    var _val_scale = lerp(_val_card_move_scale_start,_val_card_move_scale_end,_val_eased);
    var _val_flip_x = 1;
    var _spr_move_card = spr_card_back;

    if (_flag_card_move_flip){

        var _flag_first_half = (_val_progress < 0.5);
        _val_flip_x = max(0.12,abs(1 - (2 * _val_progress)));

        if (_str_card_move_type == "DRAW"){
            _spr_move_card = _flag_first_half ? spr_card_back : _spr_card;
        }
        else{
            _spr_move_card = _flag_first_half ? _spr_card : spr_card_back;
        }
    }

    draw_sprite_ext(_spr_move_card,0,x,y,_val_scale * _val_flip_x,_val_scale,0,c_white,1);
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
    _spr_preview_card = undefined;
    _val_scale_x = 0.30;
    _val_scale_y = 0.30;
    _val_preview_scale = 1.0;

    // Pile icons replace the old stack of Card backs.
    if (_str_location != "HAND"){
        exit;
    }

    //--------//
    //HOVER//
    //--------//
    // Original enemy-Card method: the native object sprite is the hitbox.
    // Do not substitute artwork, a mask, cached focus, or visual rectangles.
    var _val_draw_x = x;

    if (position_meeting(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),self)){

        // Original scaling behavior, with the hand-area-safe hover scale.
        _val_scale_x = 0.33;
        _val_scale_y = 0.33;
        _val_draw_x = clamp(x,162,894);

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

    //-------------------//
    //DRAW CARD ARTWORK//
    //-------------------//
    draw_sprite_ext(_spr_card,0,_val_draw_x,y,_val_scale_x,_val_scale_y,0,_c_card_tint,1);

    //----------------//
    //CLEAR OOM CHECK//
    //----------------//
    if (obj_battle_player_controller._state_player != ENUM_PLAYER_STATE.SELECT_CARD){
        _flag_card_oom_check = false;
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
