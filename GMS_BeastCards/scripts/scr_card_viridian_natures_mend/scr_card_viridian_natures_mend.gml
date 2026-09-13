//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURES_MEND
// FUNCTION: Resolves Nature's Mend.
//           Removes one stack from every cleansable DoT and Debuff
//           on the selected Beast.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_natures_mend(_stct_card,_ref_caster,_ref_target){

	//=====================//
	//CLEANSE STATUS STACKS//
	//=====================//
	scr_status_cleanse_stacks(_ref_target,["DOT","DEBUFF"],1);
}