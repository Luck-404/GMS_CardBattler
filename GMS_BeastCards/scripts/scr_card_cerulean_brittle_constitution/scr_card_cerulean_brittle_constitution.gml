//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_BRITTLE_CONSTITUTION
// FUNCTION: Resolves Brittle Constitution.
//           Reduces the target's CON and may preserve its DoT durations.
//
// ARGUMENTS: _stct_card is the Brittle Constitution card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_brittle_constitution(_stct_card,_ref_caster,_ref_target){

	//============================//
	//APPLY BRITTLE CONSTITUTION//
	//============================//
	scr_status_apply_debuff(
		"BRITTLE_CONSTITUTION",
		3
	);
}