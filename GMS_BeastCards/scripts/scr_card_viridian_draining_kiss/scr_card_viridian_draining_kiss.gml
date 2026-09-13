//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_DRAINING_KISS
// FUNCTION: Resolves Draining Kiss.
//           Heals the caster for 5 HP.
//           Applies Drained to the selected target for 3 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_draining_kiss(_stct_card,_ref_caster,_ref_target){

	//================//
	//HEAL CASTER//
	//================//
	scr_battle_heal_target(_stct_card._val_card_magnitude,_ref_caster);

	//================//
	//APPLY DRAINED//
	//================//
	scr_status_apply_debuff("DRAINED",3);
}