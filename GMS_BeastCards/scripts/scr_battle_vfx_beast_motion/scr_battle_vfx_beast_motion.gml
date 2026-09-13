//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_BEAST_MOTION
// FUNCTION: Starts a temporary visual-motion effect on a battle Beast.
//           Replaces any currently active Beast-motion effect without changing
//           the Beast's actual battlefield position.
//
// INPUTS:   _ref_beast     - Battle Beast receiving the visual motion.
//           _str_motion    - Motion effect identifier.
//           _ct_duration   - Motion duration in frames.
//           _val_intensity - Motion effect intensity.
//
//===============================================================================//

function scr_battle_vfx_beast_motion(_ref_beast,_str_motion,_ct_duration,_val_intensity){

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (_ref_beast._val_cur_hp <= 0){
		return false;
	}

	//----------------//
	//SET MOTION TYPE//
	//----------------//
	_ref_beast._str_vfx_motion = _str_motion;

	//-------------------//
	//SET MOTION TIMING//
	//-------------------//
	_ref_beast._ct_vfx_motion_duration = max(1,_ct_duration);
	_ref_beast._ct_vfx_motion = _ref_beast._ct_vfx_motion_duration;

	//--------------------//
	//SET MOTION STRENGTH//
	//--------------------//
	_ref_beast._val_vfx_motion_intensity = _val_intensity;

	//-------------------//
	//RESET DRAW OFFSETS//
	//-------------------//
	_ref_beast._val_vfx_offset_x = 0;
	_ref_beast._val_vfx_offset_y = 0;
	_ref_beast._val_vfx_angle = 0;

	return true;
}