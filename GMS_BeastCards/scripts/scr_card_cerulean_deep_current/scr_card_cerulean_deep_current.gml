//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_DEEP_CURRENT
// FUNCTION: Resolves the Deep Current card effect.
//           Deals linear magical damage to the selected target,
//           then draws 1 card.
//
//===============================================================================//

function scr_card_cerulean_deep_current(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//DEAL DAMAGE//
	//-----------//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//-----------//
	//DRAW 1 CARD//
	//-----------//
	scr_battle_card_draw(1);

}