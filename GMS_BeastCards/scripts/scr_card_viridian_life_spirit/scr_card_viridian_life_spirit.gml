//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_LIFE_SPIRIT
// FUNCTION: Resolves Life Spirit.
//           Summons a Life Spirit Minion for the selected allied Beast.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_life_spirit(_stct_card,_ref_caster,_ref_target){

	//===================//
	//SUMMON LIFE SPIRIT//
	//===================//
	scr_minion_init("LIFE_SPIRIT",_stct_card,_ref_caster,_ref_target);
}