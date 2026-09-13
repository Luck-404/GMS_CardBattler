//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURAL_RECOVERY
// FUNCTION: Resolves Natural Recovery.
//           Grants Armor, prioritizes cleansing CC over DoTs,
//           then restores HP to the selected target.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_natural_recovery(_stct_card,_ref_caster,_ref_target){

	//================//
	//GRANT ARMOR//
	//================//
	scr_battle_armor_target(_stct_card._val_card_magnitude,_ref_target);

	//================//
	//CLEANSE STATUS//
	//================//
	var _ct_cleansed = scr_status_cleanse_cc(_ref_target,1);

	if (_ct_cleansed <= 0){
		scr_status_cleanse_dot(_ref_target,1);
	}

	//================//
	//HEAL TARGET//
	//================//
	scr_battle_heal_target(_stct_card._val_card_magnitude,_ref_target);
}