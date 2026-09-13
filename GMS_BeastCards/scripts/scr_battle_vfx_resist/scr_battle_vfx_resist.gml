//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_RESIST
// FUNCTION: Starts a rapid rocking motion when a battle Beast resists an effect.
//
// INPUTS:   _ref_beast   - Battle Beast performing the resist motion.
//           _ct_duration - Motion duration in frames.
//           _val_angle   - Maximum rocking angle.
//
//===============================================================================//

function scr_battle_vfx_resist(_ref_beast,_ct_duration=14,_val_angle=8){

	return scr_battle_vfx_beast_motion(
		_ref_beast,
		"RESIST",
		_ct_duration,
		_val_angle
	);
}