//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_EXPEND
// FUNCTION: Plays the shared Expend VFX and SFX.
//           Supports either an instance anchor or explicit room coordinates.
//           Used for discarded cards, disabled cards, and sacrificed resources.
//
//===============================================================================//

function scr_battle_vfx_expend(
	_ref_anchor=undefined,
	_val_x=undefined,
	_val_y=undefined,
	_ct_start_delay=0
){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (
		!instance_exists(_ref_anchor) &&
		(
			_val_x == undefined ||
			_val_y == undefined
		)
	){
		return undefined;
	}

	//------------//
	//PLAY EXPEND//
	//------------//
	return scr_battle_vfx(
		_ref_anchor,
		spr_battle_vfx_expend,
		_val_x,
		_val_y,
		0,
		0,
		1,
		_ct_start_delay,
		snd_battle_sfx_expend
	);
}