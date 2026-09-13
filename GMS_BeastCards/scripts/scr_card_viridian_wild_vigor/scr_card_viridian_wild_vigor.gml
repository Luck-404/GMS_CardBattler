//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_WILD_VIGOR
// FUNCTION: Resolves Wild Vigor.
//           Increases the target's PHYPOW and PHYDEF by 20 for 3 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_wild_vigor(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY WILD VIGOR//
	//================//
	scr_status_apply_buff("WILD_VIGOR",20,3);
}