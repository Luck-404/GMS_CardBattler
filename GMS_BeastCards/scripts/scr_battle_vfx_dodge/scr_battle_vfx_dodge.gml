//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_DODGE
// FUNCTION: Plays a rapid horizontal Beast dodge animation.
//
//===============================================================================//

function scr_battle_vfx_dodge(_ref_beast,_ct_duration=12,_val_distance=8){

	return scr_battle_vfx_beast_motion(_ref_beast,"DODGE",_ct_duration,_val_distance);
}