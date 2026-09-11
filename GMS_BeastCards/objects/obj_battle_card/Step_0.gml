//===============================================================================//
//
// STEP: OBJ_BATTLE_CARD
// FUNCTION: Updates temporary battle-Card movement animations.
//           Handles delayed movement, Draw SFX, eased interpolation,
//           and completion of Card transitions between battle piles.
//
// USES:     Card movement state, timing, movement type, and start/end positions
//           initialized on this Card instance by the battle Card-flow system.
//
//===============================================================================//

//----------------//
//CARD NOT MOVING//
//----------------//
if (!_flag_card_moving){
	exit;
}

#region CARD MOVEMENT

//-----------//
//START DELAY//
//-----------//
if (_ct_card_move_delay > 0){

	_ct_card_move_delay--;

	if (_ct_card_move_delay > 0){
		exit;
	}
}

//--------//
//PLAY SFX//
//--------//
if (!_flag_card_move_sfx_played){

	_flag_card_move_sfx_played = true;

	switch(_str_card_move_type){

		case "DRAW":
			audio_play_sound(snd_battle_card_draw,0,false);
		break;
	}
}

//----------------//
//CHECK COMPLETION//
//----------------//
if (_ct_card_move_timer >= _ct_card_move_duration){

	x = _val_card_move_end_x;
	y = _val_card_move_end_y;

	_flag_card_moving = false;
	_flag_card_move_sfx_played = false;

	_str_card_move_type = "";

	_ct_card_move_timer = 0;

	exit;
}

//-------------------//
//CALCULATE PROGRESS//
//-------------------//
var _val_move_progress = clamp(_ct_card_move_timer / max(1,_ct_card_move_duration - 1),0,1);

//----------------//
//EASE OUT MOTION//
//----------------//
var _val_move_eased = 1 - power(1 - _val_move_progress,3);

//----------//
//MOVE CARD//
//----------//
x = lerp(_val_card_move_start_x,_val_card_move_end_x,_val_move_eased);
y = lerp(_val_card_move_start_y,_val_card_move_end_y,_val_move_eased);

//-----------------//
//ADVANCE ANIMATION//
//-----------------//
_ct_card_move_timer++;

#endregion