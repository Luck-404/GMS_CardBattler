//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_PYROCLAST
// FUNCTION: Resolves Pyroclast.
//           Deals linear Magical damage to the target.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_pyroclast(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(_stct_card._val_card_magnitude,_ref_target);
}