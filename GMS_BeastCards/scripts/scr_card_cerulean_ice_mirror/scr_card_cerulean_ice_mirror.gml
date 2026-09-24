//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICE_MIRROR
// FUNCTION: Resolves Ice Mirror.
//           For 3 rounds, successful enemy Attack damage against the caster
//           grants the caster Armor.
//
// ARGUMENTS: _stct_card is the Ice Mirror card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_ice_mirror(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY ICE MIRROR//
	//================//
	scr_status_apply_buff("ICE_MIRROR", _ref_target, _stct_card._val_card_magnitude, 3);
}