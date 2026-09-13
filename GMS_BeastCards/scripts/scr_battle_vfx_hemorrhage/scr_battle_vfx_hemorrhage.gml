//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_HEMORRHAGE
// FUNCTION: Plays the HEMORRHAGE trigger VFX/SFX on a battle Beast.
//
// INPUT:    _ref_target - Beast triggering HEMORRHAGE.
// RETURNS: The created VFX instance, or undefined if invalid.
//
//===============================================================================//

function scr_battle_vfx_hemorrhage(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return undefined;
	}

	//================//
	//HEMORRHAGE VFX//
	//================//
	return scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_hemorrhage,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		snd_battle_hemorrhage
	);
}