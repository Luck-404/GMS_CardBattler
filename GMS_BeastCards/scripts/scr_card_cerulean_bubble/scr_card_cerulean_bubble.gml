//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_BUBBLE
// FUNCTION: Resolves Bubble.
//           Grants the caster 1 Divine Protection.
//
// ARGUMENTS: _stct_card is the Bubble card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_bubble(_stct_card,_ref_caster,_ref_target){

	//================//
	//TARGET CASTER//
	//================//
	var _ref_original_target = global.ref_target_beast;
	global.ref_target_beast = _ref_caster;

	//========================//
	//GAIN DIVINE PROTECTION//
	//========================//
	scr_status_apply_buff(
		"DIVINE_PROTECTION",
		1
	);

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;
}