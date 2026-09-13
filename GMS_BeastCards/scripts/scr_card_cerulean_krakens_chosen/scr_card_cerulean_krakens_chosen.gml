//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_KRAKENS_CHOSEN
// FUNCTION: Resolves Kraken's Chosen.
//           Applies the Kraken's Chosen Aura to the selected target.
//
// ARGUMENTS: _stct_card is the Kraken's Chosen card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_krakens_chosen(_stct_card,_ref_caster,_ref_target){

	//======================//
	//APPLY KRAKENS CHOSEN//
	//======================//
	scr_status_apply_aura(
		"KRAKENS_CHOSEN",
		0
	);
}