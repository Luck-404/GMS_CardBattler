//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_THORNMAIL
// FUNCTION: Resolves Thornmail.
//           Grants Armor to the caster and applies Thorns for 3 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_thornmail(_stct_card,_ref_caster,_ref_target){

	//================//
	//GRANT ARMOR//
	//================//
	scr_battle_armor_target(_stct_card._val_card_magnitude,_ref_caster);

	//================//
	//APPLY THORNS//
	//================//
	scr_status_apply_buff("THORNS",3,3);
}