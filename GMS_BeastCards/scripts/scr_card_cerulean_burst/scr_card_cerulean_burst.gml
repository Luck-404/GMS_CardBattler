//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_BURST
// FUNCTION: Resolves Burst.
//           Deals linear physical damage to the selected Melee target.
//
// ARGUMENTS: _stct_card is the Burst card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_burst(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);
}