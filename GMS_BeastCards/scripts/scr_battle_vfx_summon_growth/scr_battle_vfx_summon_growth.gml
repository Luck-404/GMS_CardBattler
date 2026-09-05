//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_SUMMON_GROWTH
// FUNCTION: Plays a temporary grow-and-shrink animation on a Minion.
//           Used whenever a Minion permanently gains HP and Magnitude.
//           Plays the shared Minion Growth SFX.
//
//===============================================================================//

function scr_battle_vfx_summon_growth(
	_ref_minion,
	_ct_duration=14,
	_val_growth=0.25
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

	//-------------//
	//START MOTION//
	//-------------//
	_ref_minion._str_vfx_motion =
		"GROWTH";

	_ref_minion._ct_vfx_motion_duration =
		max(
			1,
			_ct_duration
		);

	_ref_minion._ct_vfx_motion =
		_ref_minion._ct_vfx_motion_duration;

	_ref_minion._val_vfx_motion_intensity =
		max(
			0,
			_val_growth
		);

	_ref_minion._val_vfx_offset_x =
		0;

	_ref_minion._val_vfx_offset_y =
		0;

	_ref_minion._val_vfx_scale =
		1;

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_battle_sfx_summon_growth,
		0,
		false
	);

	return true;
}