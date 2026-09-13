//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BLOOMING_SPRITE
// FUNCTION: Resolves Blooming Sprite.
//           Summons a Blooming Sprite for the selected allied Beast.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_blooming_sprite(_stct_card,_ref_caster,_ref_target){

	//======================//
	//SUMMON BLOOMING SPRITE//
	//======================//
	scr_minion_init(
		"BLOOMING_SPRITE",
		_stct_card,
		_ref_caster,
		_ref_target
	);
}