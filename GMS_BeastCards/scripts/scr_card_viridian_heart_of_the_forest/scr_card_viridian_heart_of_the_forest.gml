//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_HEART_OF_THE_FOREST
// FUNCTION: Resolves Heart of the Forest.
//           Applies a teamwide healing-trigger Buff for 5 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_heart_of_the_forest(_stct_card,_ref_caster,_ref_target){

	//==========================//
	//APPLY HEART OF THE FOREST//
	//==========================//
	scr_status_apply_buff("HEART_OF_THE_FOREST", _ref_target, 0, 5);
}