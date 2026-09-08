//===============================================================================//
//
// SCRIPT: scr_trap_vfx_trigger
// FUNCTION: Plays shared Trap-trigger presentation.
//           Uses Friendly VFX for player-owned Traps.
//           Uses Enemy VFX for enemy-owned Traps.
//           Plays the shared mechanical Trap-trigger SFX.
//
//===============================================================================//

function scr_trap_vfx_trigger(_ref_trap){

	//---------------//
	//VALIDATE TRAP//
	//---------------//
	if (!instance_exists(_ref_trap)){
		return undefined;
	}

	//---------------//
	//SELECT SPRITE//
	//---------------//
	var _spr_vfx = spr_battle_trap_vfx_trigger_friendly;

	if (_ref_trap._str_owner_team == "PLAYER"){

		_spr_vfx =
			spr_battle_trap_vfx_trigger_enemy;
	}

	//----------------//
	//GET VFX TARGET//
	//----------------//
	var _ref_host =
		_ref_trap._ref_host;

	if (instance_exists(_ref_host)){

		return scr_battle_vfx(
			_ref_host,
			_spr_vfx,
			undefined,
			undefined,
			0,
			0,
			1,
			0,
			snd_battle_trap_trigger
		);
	}

	//----------------//
	//POSITION FALLBACK//
	//----------------//
	return scr_battle_vfx(
		undefined,
		_spr_vfx,
		_ref_trap.x,
		_ref_trap.y,
		0,
		0,
		1,
		0,
		snd_battle_trap_trigger
	);
}