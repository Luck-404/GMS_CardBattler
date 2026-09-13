//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_COMBUSTION
// FUNCTION: Resolves Combustion.
//           Deals Magical damage equal to a percentage of the target's
//           maximum HP.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_combustion(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target_percent(_stct_card._val_card_magnitude,_ref_target);
}