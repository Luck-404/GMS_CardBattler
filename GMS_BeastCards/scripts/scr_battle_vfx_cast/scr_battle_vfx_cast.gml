//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_CAST
// FUNCTION: Plays a short forward-and-back casting lunge.
//           Automatically faces the motion toward the opposing team.
//
//===============================================================================//

function scr_battle_vfx_cast(_ref_beast,_ct_duration=12,_val_distance=12){

	return scr_battle_vfx_beast_motion(_ref_beast,"CAST",_ct_duration,_val_distance);
}