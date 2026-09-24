//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROZEN_ARMOR
// FUNCTION: Resolves Frozen Armor.
//           For 3 rounds, successful enemy Attack damage against the caster
//           applies 1 Frostbite to the attacker.
//
// ARGUMENTS: _stct_card is the Frozen Armor card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_frozen_armor(_stct_card,_ref_caster,_ref_target){


	//===================//
	//APPLY FROZEN ARMOR//
	//===================//
	scr_status_apply_buff("FROZEN_ARMOR", _ref_caster, 1, 3);

}