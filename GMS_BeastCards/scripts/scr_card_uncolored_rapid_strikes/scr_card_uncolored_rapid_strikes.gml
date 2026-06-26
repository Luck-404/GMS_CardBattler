//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_RAPID_STRIKES
// FUNCTION: Resolves the Rapid Strikes card effect.
//           Deals damage to the target three times.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_uncolored_rapid_strikes(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//DEAL DAMAGE (3 HITS)//
	//----------------------//
	for (var _it_hit = 0; _it_hit < 3; _it_hit++){

		scr_damage_target(_stct_card._val_card_magnitude,_ref_target);

		//----------------//
		//PLAY ANIMATION//
		//----------------//

		//-----------//
		//PLAY SOUND//
		//-----------//
	}
}