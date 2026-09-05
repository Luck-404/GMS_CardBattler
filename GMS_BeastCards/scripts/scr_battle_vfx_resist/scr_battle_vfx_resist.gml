//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_RESIST
// FUNCTION: Plays a rapid rocking animation when a Beast resists an effect.
//
//===============================================================================//

function scr_battle_vfx_resist(_ref_beast,_ct_duration=14,_val_angle=8){

	return scr_battle_vfx_beast_motion(_ref_beast,"RESIST",_ct_duration,_val_angle);
}