//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_KRAKEN_AWAKENS
// FUNCTION: Resolves Kraken Awakens.
//           Deals linear PHY damage.
//           Applies 2 Bleed and 2 Stormstruck.
//
//===============================================================================//

function scr_card_cerulean_kraken_awakens(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//-------------//
	//APPLY BLEED//
	//-------------//
	scr_status_apply_dot(
		"BLEED"
	);

	scr_status_apply_dot(
		"BLEED"
	);

	//-------------------//
	//APPLY STORMSTRUCK//
	//-------------------//
	scr_status_apply_dot(
		"STORMSTRUCK"
	);

	scr_status_apply_dot(
		"STORMSTRUCK"
	);
}