//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ABYSSAL_HARPOON
// FUNCTION: Resolves Abyssal Harpoon.
//           Summons an Abyssal Harpoon on the caster.
//
// ARGUMENTS: _stct_card is the Abyssal Harpoon card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_abyssal_harpoon(_stct_card,_ref_caster,_ref_target){

	//=======================//
	//SUMMON ABYSSAL HARPOON//
	//=======================//
	scr_minion_init(
		"ABYSSAL_HARPOON",
		_stct_card,
		_ref_caster,
		_ref_caster
	);
}