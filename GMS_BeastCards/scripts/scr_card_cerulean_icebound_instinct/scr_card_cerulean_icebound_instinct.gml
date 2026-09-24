//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICEBOUND_INSTINCT
// FUNCTION: Resolves Icebound Instinct.
//           Increases the caster's card-applied CC duration for 4 rounds.
//
// ARGUMENTS: _stct_card is the Icebound Instinct card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_icebound_instinct(_stct_card,_ref_caster,_ref_target){

	//========================//
	//APPLY ICEBOUND INSTINCT//
	//========================//
	scr_status_apply_buff("ICEBOUND_INSTINCT", _ref_target, _stct_card._val_card_magnitude, 4);
}