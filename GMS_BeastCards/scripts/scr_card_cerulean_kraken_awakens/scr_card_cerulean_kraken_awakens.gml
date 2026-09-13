//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_KRAKEN_AWAKENS
// FUNCTION: Resolves Kraken Awakens.
//           Deals linear physical damage to the selected target.
//           Applies 2 Bleed and 2 Stormstruck.
//
// ARGUMENTS: _stct_card is the Kraken Awakens card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_kraken_awakens(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//================//
	//APPLY BLEED//
	//================//
	scr_status_apply_dot("BLEED");
	scr_status_apply_dot("BLEED");

	//==================//
	//APPLY STORMSTRUCK//
	//==================//
	scr_status_apply_dot("STORMSTRUCK");
	scr_status_apply_dot("STORMSTRUCK");
}