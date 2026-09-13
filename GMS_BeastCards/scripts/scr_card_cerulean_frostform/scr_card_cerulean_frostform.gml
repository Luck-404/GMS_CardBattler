//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROSTFORM
// FUNCTION: Resolves Frostform.
//           Applies the Frostform Self Aura.
//
// ARGUMENTS: _stct_card is the Frostform card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_frostform(_stct_card,_ref_caster,_ref_target){

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
	//APPLY FROSTFORM//
	//================//
	scr_status_apply_aura(
		"FROSTFORM",
		0
	);

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;
}