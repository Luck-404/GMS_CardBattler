//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_EXECUTE
// FUNCTION: Plays shared EXECUTE trigger VFX/SFX on the defeated target.
//
// ARGUMENTS: _ref_target is the Beast defeated by EXECUTE.
// RETURNS: The created VFX instance, or undefined if invalid.
//
//===============================================================================//

function scr_battle_vfx_execute(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return undefined;
	}

	//================//
	//EXECUTE VFX / SFX//
	//================//
	return scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_execute,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		snd_battle_execute
	);
}