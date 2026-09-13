//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_CAST
// FUNCTION: Starts a short casting lunge on a battle Beast.
//           Uses the shared Beast-motion system and automatically faces
//           the motion toward the opposing team.
//
// INPUTS:   _ref_beast    - Battle Beast performing the cast motion.
//           _ct_duration  - Motion duration in frames.
//           _val_distance - Casting lunge distance.
//
//===============================================================================//

function scr_battle_vfx_cast(_ref_beast,_ct_duration=12,_val_distance=12){

	return scr_battle_vfx_beast_motion(
		_ref_beast,
		"CAST",
		_ct_duration,
		_val_distance
	);
}