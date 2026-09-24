//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BATTLE_FRENZY
// FUNCTION: Applies 1 stack of Battle Frenzy to the caster.
//           Stacks accumulate until the caster's next Attack resolves.
//
// ARGUMENTS: _stct_card is the Battle Frenzy Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is unused for this Self-target Card.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_battle_frenzy(_stct_card,_ref_caster,_ref_target){

	//===================//
	//GAIN BATTLE FRENZY//
	//===================//
	scr_status_apply_buff("BATTLE_FRENZY", _ref_caster, 1);

}