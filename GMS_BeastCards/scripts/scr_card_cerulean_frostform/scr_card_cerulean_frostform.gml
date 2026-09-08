//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROSTFORM
// FUNCTION: Resolves Frostform.
//           Applies the Frostform Self Aura.
//           Attaches the persistent Frostform VFX to the Aura status.
//
//===============================================================================//

function scr_card_cerulean_frostform(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	//----------------------//
	//STORE ORIGINAL TARGET//
	//----------------------//
	var _ref_original_target =
		global.ref_target_beast;

	//--------------//
	//TARGET CASTER//
	//--------------//
	global.ref_target_beast =
		_ref_caster;

	//----------------//
	//APPLY FROSTFORM//
	//----------------//
	var _ref_frostform =
		scr_status_apply_aura(
			"FROSTFORM",
			0
		);

	//----------------//
	//RESTORE TARGET//
	//----------------//
	global.ref_target_beast =
		_ref_original_target;

	//--------------------//
	//FROSTFORM VFX//
	//--------------------//
	if (
		instance_exists(_ref_frostform) &&
		!instance_exists(
			_ref_frostform._ref_persistent_vfx
		)
	){

		_ref_frostform._ref_persistent_vfx =
			scr_battle_vfx_persistent(
				_ref_caster,
				spr_battle_vfx_frostform
			);
	}
}