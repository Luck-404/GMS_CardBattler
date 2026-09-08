//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BLOOMING_SPRITE
// FUNCTION: Resolves the Blooming Sprite card effect.
//           Summons a Blooming Sprite for the selected allied Beast.
//
//===============================================================================//

function scr_card_viridian_blooming_sprite(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//SUMMON BLOOMING SPRITE//
	//----------------------//
	scr_minion_init(
		"BLOOMING_SPRITE",
		_stct_card,
		_ref_caster,
		_ref_target
	);

}