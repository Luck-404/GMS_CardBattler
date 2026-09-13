//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_DODGE
// FUNCTION: Starts a rapid horizontal dodge motion on a battle Beast.
//
// INPUTS:   _ref_beast    - Battle Beast performing the dodge motion.
//           _ct_duration  - Motion duration in frames.
//           _val_distance - Dodge movement distance.
//
//===============================================================================//

function scr_battle_vfx_dodge(_ref_beast,_ct_duration=12,_val_distance=8){

	return scr_battle_vfx_beast_motion(
		_ref_beast,
		"DODGE",
		_ct_duration,
		_val_distance
	);
}