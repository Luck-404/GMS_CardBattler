//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_CHAR
// FUNCTION: Plays the Char trigger VFX/SFX on a battle Beast.
//           Used when Burn reaches its Char threshold and converts into Char.
//
// INPUT:    _ref_target - Beast triggering Char.
// RETURNS: The created VFX instance, or undefined if the target is invalid.
//
//===============================================================================//

function scr_battle_vfx_char(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return undefined;
	}

	//================//
	//CHAR VFX / SFX//
	//================//
	return scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_char,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		snd_battle_char
	);
}