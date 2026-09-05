//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_BLOCKED
// FUNCTION: Plays the general Blocked VFX and SFX on a battle Beast.
//           Supports an optional delay for synchronization with hit VFX.
//
//===============================================================================//

function scr_battle_vfx_blocked(_ref_target,_ct_start_delay=0){

	if (!instance_exists(_ref_target)){
		return undefined;
	}

	return scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_blocked,
		undefined,
		undefined,
		0,
		0,
		1,
		_ct_start_delay,
		snd_battle_vfx_blocked
	);
}