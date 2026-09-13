//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SERPENT_SUMMON
// FUNCTION: Resolves Serpent Summon.
//           Summons 3 Serpent Minions on the caster.
//           Each Serpent attacks a random enemy and applies Venom each round.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_serpent_summon(_stct_card,_ref_caster,_ref_target){

	//================//
	//SUMMON SERPENTS//
	//================//
	repeat (3){
		scr_minion_init("SERPENT",_stct_card,_ref_caster,_ref_caster);
	}
}