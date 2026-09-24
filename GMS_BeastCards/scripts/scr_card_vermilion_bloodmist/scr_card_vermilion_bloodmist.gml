//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOODMIST
// FUNCTION: Begins the Bloodmist Event for the caster's team.
//           Bloodmist resolves and decrements only at that team's turn END.
//
// ARGUMENTS: _stct_card is the Card struct.
//            _ref_caster and _ref_target are the casting and target references.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_bloodmist(_stct_card,_ref_caster,_ref_target){

	//================//
	//BEGIN BLOODMIST//
	//================//
	scr_status_apply_event("BLOODMIST",3,_ref_caster._str_team);
}