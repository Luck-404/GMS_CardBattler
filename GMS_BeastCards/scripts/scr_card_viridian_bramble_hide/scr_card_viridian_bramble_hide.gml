//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BRAMBLE_HIDE
// FUNCTION: Resolves Bramble Hide.
//           Grants the selected Beast Thorns for 3 rounds.
//           Thorns deals stored neutral damage back to melee attackers.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_bramble_hide(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY THORNS//
	//================//
	scr_status_apply_buff("THORNS", _ref_target, _stct_card._val_card_magnitude, 3);
}