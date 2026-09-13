//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CALM_SEAS
// FUNCTION: Resolves Calm Seas.
//           Applies an encounter-long Team Aura to the caster.
//
// ARGUMENTS: _stct_card is the Calm Seas card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_calm_seas(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATE CASTER//
	//================//
	if (!instance_exists(_ref_caster)){
		return;
	}

	//================//
	//TARGET CASTER//
	//================//
	var _ref_original_target = global.ref_target_beast;
	global.ref_target_beast = _ref_caster;

	//================//
	//APPLY CALM SEAS//
	//================//
	scr_status_apply_aura(
		"CALM_SEAS",
		0
	);

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;
}