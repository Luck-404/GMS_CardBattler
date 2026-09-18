//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_ERUPTION
// FUNCTION: Plays shared ERUPTION trigger VFX/SFX on a battle Beast.
//
// INPUT:    _ref_target - Beast triggering ERUPTION.
// RETURNS: The created VFX instance, or undefined if invalid.
//
//===============================================================================//

function scr_battle_vfx_eruption(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return undefined;
	}

	//================//
	//ERUPTION VFX/SFX//
	//================//
	return scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_eruption,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		snd_battle_eruption
	);
}