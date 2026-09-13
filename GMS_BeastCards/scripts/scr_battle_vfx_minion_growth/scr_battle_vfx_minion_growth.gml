//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_MINION_GROWTH
// FUNCTION: Starts a temporary grow-and-shrink animation on a battle Minion.
//           Used whenever a Minion permanently gains HP and Magnitude.
//           Plays the shared Minion Growth SFX.
//
// INPUTS:   _ref_minion - Battle Minion receiving the growth motion.
//           _ct_duration - Motion duration in frames.
//           _val_growth - Maximum additional visual scale.
//
//===============================================================================//

function scr_battle_vfx_minion_growth(_ref_minion,_ct_duration=14,_val_growth=0.25){

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
	_ref_minion._str_vfx_motion = "GROWTH";

	_ref_minion._ct_vfx_motion_duration = max(1,_ct_duration);
	_ref_minion._ct_vfx_motion = _ref_minion._ct_vfx_motion_duration;

	_ref_minion._val_vfx_motion_intensity = max(0,_val_growth);

	_ref_minion._val_vfx_offset_x = 0;
	_ref_minion._val_vfx_offset_y = 0;
	_ref_minion._val_vfx_scale = 1;

	//----------//
	//PLAY SFX//
	//----------//
	scr_battle_play_sfx(snd_battle_minion_growth);

	return true;
}