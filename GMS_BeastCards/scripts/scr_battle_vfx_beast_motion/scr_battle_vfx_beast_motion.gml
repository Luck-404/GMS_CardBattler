//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_BEAST_MOTION
// FUNCTION: Starts a temporary visual-motion effect on a battle Beast.
//           Replaces any currently active host-motion effect.
//           Does not alter the Beast's actual battlefield position.
//
//===============================================================================//

function scr_battle_vfx_beast_motion(_ref_beast,_str_motion,_ct_duration,_val_intensity){

	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (_ref_beast._val_cur_hp <= 0){
		return false;
	}

	_ref_beast._str_vfx_motion = _str_motion;

	_ref_beast._ct_vfx_motion_duration = max(1,_ct_duration);
	_ref_beast._ct_vfx_motion = _ref_beast._ct_vfx_motion_duration;

	_ref_beast._val_vfx_motion_intensity = _val_intensity;

	_ref_beast._val_vfx_offset_x = 0;
	_ref_beast._val_vfx_offset_y = 0;
	_ref_beast._val_vfx_angle = 0;

	return true;
}