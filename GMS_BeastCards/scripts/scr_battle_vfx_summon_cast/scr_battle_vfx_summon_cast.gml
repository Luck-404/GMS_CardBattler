//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_SUMMON_CAST
// FUNCTION: Plays a short casting motion on a Minion.
//           HOST effects use a vertical hop.
//           ENEMY effects use a horizontal lunge toward the opposing team.
//           Does not alter the Minion's actual battlefield position.
//           Does not play SFX.
//
//===============================================================================//

function scr_battle_vfx_summon_cast(
	_ref_minion,
	_str_cast_type="ENEMY",
	_ct_duration=12,
	_val_distance=8
){

	//-----------------//
	//VALIDATE MINION//
	//-----------------//
	if (!instance_exists(_ref_minion)){
		return false;
	}

	if (_ref_minion._val_cur_hp <= 0){
		return false;
	}

	//----------------//
	//VALIDATE TYPE//
	//----------------//
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

	_ref_minion._ct_vfx_motion_duration =
		max(
			1,
			_ct_duration
		);

	_ref_minion._ct_vfx_motion =
		_ref_minion._ct_vfx_motion_duration;

	_ref_minion._val_vfx_motion_intensity =
		_val_distance;

	_ref_minion._val_vfx_offset_x =
		0;

	_ref_minion._val_vfx_offset_y =
		0;

	return true;
}