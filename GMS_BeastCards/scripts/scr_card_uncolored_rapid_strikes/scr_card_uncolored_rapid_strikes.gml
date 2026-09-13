//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_RAPID_STRIKES
// FUNCTION: Resolves Rapid Strikes.
//           Deals damage to the target 3 times.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_uncolored_rapid_strikes(_stct_card,_ref_caster,_ref_target){

	//======================//
	//DEAL DAMAGE (3 HITS)//
	//======================//
	repeat (3){
		scr_battle_damage_target(_stct_card._val_card_magnitude,_ref_target);
	}
}