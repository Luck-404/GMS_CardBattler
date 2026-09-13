//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_MINION_CAST
// FUNCTION: Starts a short casting motion on a battle Minion.
//           HOST casts use a vertical hop.
//           ENEMY casts use a horizontal lunge toward the opposing team.
//           Does not alter the Minion's actual battlefield position.
//           Does not play SFX.
//
// INPUTS:   _ref_minion    - Battle Minion performing the cast motion.
//           _str_cast_type - Cast motion type: HOST or ENEMY.
//           _ct_duration   - Motion duration in frames.
//           _val_distance  - Cast motion distance.
//
//===============================================================================//

function scr_battle_vfx_minion_cast(_ref_minion,_str_cast_type="ENEMY",_ct_duration=12,_val_distance=8){

	//-----------------//
	//VALIDATE MINION//
	//-----------------//
	if (!instance_exists(_ref_minion)){
		return false;
	}

	if (_ref_minion._val_cur_hp <= 0){
		return false;
	}

	//---------------//
	//VALIDATE TYPE//
	//---------------//
	if (
		_str_cast_type != "HOST" &&
		_str_cast_type != "ENEMY"
	){
		_str_cast_type = "ENEMY";
	}

	//-------------//
	//START MOTION//
	//-------------//
	_ref_minion._str_vfx_motion =
		(_str_cast_type == "HOST")
			? "CAST_HOST"
			: "CAST_ENEMY";

	_ref_minion._ct_vfx_motion_duration = max(1,_ct_duration);
	_ref_minion._ct_vfx_motion = _ref_minion._ct_vfx_motion_duration;

	_ref_minion._val_vfx_motion_intensity = _val_distance;

	_ref_minion._val_vfx_offset_x = 0;
	_ref_minion._val_vfx_offset_y = 0;

	return true;
}