//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_CAST_MINION
// FUNCTION: Starts a short downward casting motion on a battle Beast.
//           Used when the Beast is directly interacting with its Minion row.
//           Does not alter the Beast's actual battlefield position.
//
// INPUTS:   _ref_beast    - Battle Beast performing the cast motion.
//           _ct_duration  - Motion duration in frames.
//           _val_distance - Downward cast-motion distance.
//
// RETURNS:  True if the motion starts successfully.
//
//===============================================================================//

function scr_battle_vfx_cast_minion(_ref_beast,_ct_duration=12,_val_distance=8){

	return scr_battle_vfx_beast_motion(
		_ref_beast,
		"CAST_MINION",
		_ct_duration,
		_val_distance
	);
}