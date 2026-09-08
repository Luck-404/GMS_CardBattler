//===============================================================================//
//
// STEP: OBJ_BATTLE_BEAST
// FUNCTION: Updates temporary Beast visual-motion effects.
//           Supports cast lunges, dodge movement, and resist rotation.
//           Does not alter the Beast's actual battlefield position.
//
//===============================================================================//

//--------------------//
//RESET DRAW MODIFIERS//
//--------------------//
_val_vfx_offset_x = 0;
_val_vfx_offset_y = 0;
_val_vfx_angle = 0;

//----------------//
//NO ACTIVE MOTION//
//----------------//
if (_str_vfx_motion == "NONE" || _ct_vfx_motion <= 0){

	_str_vfx_motion = "NONE";
	_ct_vfx_motion = 0;

	exit;
}

//----------------//
//DEAD BEAST GUARD//
//----------------//
if (_val_cur_hp <= 0){

	_str_vfx_motion = "NONE";
	_ct_vfx_motion = 0;

	exit;
}

//------------------//
//ANIMATION PROGRESS//
//------------------//
var _val_progress = 1 - (_ct_vfx_motion / max(1,_ct_vfx_motion_duration));

//-------------//
//UPDATE MOTION//
//-------------//
switch(_str_vfx_motion){

	case "CAST":

		var _val_direction = (_str_team == "PLAYER") ? 1 : -1;

		_val_vfx_offset_x =
			sin(_val_progress * pi) *
			_val_vfx_motion_intensity *
			_val_direction;

	break;


	case "DODGE":

		_val_vfx_offset_x =
			sin(_val_progress * pi * 4) *
			_val_vfx_motion_intensity;

	break;

	case "REPOSITION":

		//--------------------//
		//REPOSITION PROGRESS//
		//--------------------//
		var _val_reposition_progress =
			1 -
			(
				(_ct_vfx_motion - 1) /
				max(
					1,
					_ct_vfx_motion_duration - 1
				)
			);

		//----------------//
		//SMOOTH EASING//
		//----------------//
		var _val_reposition_ease =
			_val_reposition_progress *
			_val_reposition_progress *
			(
				3 -
				(2 * _val_reposition_progress)
			);

		//----------------//
		//LERP TO NEW SLOT//
		//----------------//
		_val_vfx_offset_x =
			lerp(
				_val_vfx_motion_start_x,
				0,
				_val_reposition_ease
			);

	break;

	case "RESIST":

		_val_vfx_angle =
			sin(_val_progress * pi * 4) *
			_val_vfx_motion_intensity;

	break;
}

//---------//
//COUNTDOWN//
//---------//
_ct_vfx_motion--;