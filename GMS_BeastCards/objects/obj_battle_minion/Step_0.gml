//===============================================================================//
//
// STEP: OBJ_BATTLE_MINION
// FUNCTION: Updates temporary Minion presentation motion.
//           Supports casting lunges and growth pulses.
//           Does not alter the Minion's actual battlefield position.
//
//===============================================================================//

//--------------------//
//RESET DRAW MODIFIERS//
//--------------------//
_val_vfx_offset_x =
	0;

_val_vfx_offset_y =
	0;

_val_vfx_scale =
	1;

//----------------//
//NO ACTIVE MOTION//
//----------------//
if (
	_str_vfx_motion == "NONE" ||
	_ct_vfx_motion <= 0
){

	_str_vfx_motion =
		"NONE";

	_ct_vfx_motion =
		0;

	exit;
}

//------------------//
//DEAD MINION GUARD//
//------------------//
if (_val_cur_hp <= 0){

	_str_vfx_motion =
		"NONE";

	_ct_vfx_motion =
		0;

	exit;
}

//------------------//
//ANIMATION PROGRESS//
//------------------//
var _val_progress =
	1 -
	(
		_ct_vfx_motion /
		max(
			1,
			_ct_vfx_motion_duration
		)
	);

//-------------//
//UPDATE MOTION//
//-------------//
switch(_str_vfx_motion){

	//------------//
	//ENEMY CAST//
	//------------//
	case "CAST_ENEMY":

		var _val_direction =
			(_str_team == "PLAYER")
				? 1
				: -1;

		_val_vfx_offset_x =
			sin(
				_val_progress * pi
			) *
			_val_vfx_motion_intensity *
			_val_direction;

	break;


	//-----------//
	//HOST CAST//
	//-----------//
	case "CAST_HOST":

		_val_vfx_offset_y =
			-
			(
				sin(
					_val_progress * pi
				) *
				_val_vfx_motion_intensity
			);

	break;


	//--------//
	//GROWTH//
	//--------//
	case "GROWTH":

		_val_vfx_scale =
			1 +
			(
				sin(
					_val_progress * pi
				) *
				_val_vfx_motion_intensity
			);

	break;
}

//---------//
//COUNTDOWN//
//---------//
_ct_vfx_motion--;