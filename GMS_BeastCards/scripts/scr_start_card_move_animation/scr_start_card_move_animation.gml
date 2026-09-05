//===============================================================================//
//
// SCRIPT: SCR_START_CARD_MOVE_ANIMATION
// FUNCTION: Starts a battle-card movement animation.
//           Moves the actual card instance between two supplied positions.
//           Supports Draw, Discard, and Exhaust presentation types.
//
//===============================================================================//

function scr_start_card_move_animation(
	_ref_card,
	_str_move_type,
	_val_start_x,
	_val_start_y,
	_val_end_x,
	_val_end_y,
	_ct_duration=8,
	_ct_delay=0
){

	//---------------//
	//VALIDATE CARD//
	//---------------//
	if (!instance_exists(_ref_card)){
		return false;
	}

	//----------------//
	//SET MOVE STATE//
	//----------------//
	_ref_card._flag_card_moving =
		true;

	_ref_card._flag_card_move_sfx_played =
		false;

	_ref_card._str_card_move_type =
		_str_move_type;

	//--------//
	//TIMING//
	//--------//
	_ref_card._ct_card_move_timer =
		0;

	_ref_card._ct_card_move_duration =
		max(1,_ct_duration);

	_ref_card._ct_card_move_delay =
		max(0,_ct_delay);

	//---------------//
	//START POSITION//
	//---------------//
	_ref_card._val_card_move_start_x =
		_val_start_x;

	_ref_card._val_card_move_start_y =
		_val_start_y;

	//-------------//
	//END POSITION//
	//-------------//
	_ref_card._val_card_move_end_x =
		_val_end_x;

	_ref_card._val_card_move_end_y =
		_val_end_y;

	//----------------------//
	//PLACE CARD AT START//
	//----------------------//
	_ref_card.x =
		_val_start_x;

	_ref_card.y =
		_val_start_y;

	return true;
}