//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BURSTING_SEED
// FUNCTION: Resolves Bursting Seed.
//           Applies Armorbreak for 2 rounds.
//           Applies Vulnerable for 1 round.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_bursting_seed(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY ARMORBREAK//
	//================//
	scr_status_apply_debuff("ARMORBREAK",2);

	//================//
	//APPLY VULNERABLE//
	//================//
	scr_status_apply_debuff("VULNERABLE",1);
}