//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ABYSSAL_TOUCH
// FUNCTION: Resolves Abyssal Touch.
//           Deals linear magical damage to the selected Ranged target.
//
// ARGUMENTS: _stct_card is the Abyssal Touch card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_abyssal_touch(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);
}