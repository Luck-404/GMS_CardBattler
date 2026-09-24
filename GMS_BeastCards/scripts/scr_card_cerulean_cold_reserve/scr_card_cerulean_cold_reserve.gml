//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_COLD_RESERVE
// FUNCTION: Consumes up to the card magnitude of the caster's own Armor.
//           Heals exactly 1 HP per Armor actually consumed.
//
// ARGUMENTS: _stct_card - Cold Reserve card struct, including magnitude.
//            _ref_caster - Armor source/heal recipient; _ref_target - unused.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_cold_reserve(_stct_card,_ref_caster,_ref_target){

	//================//
	//CONSUME ARMOR//
	//================//
	var _stct_armor_result = scr_battle_destroy_armor(_ref_caster,_stct_card._val_card_magnitude);
	var _val_armor_consumed = _stct_armor_result._val_armor_removed;

	if (_val_armor_consumed <= 0){
		return;
	}

	//================//
	//HEAL CASTER//
	//================//
	scr_battle_heal_target(
		"FIXED",
		_val_armor_consumed,
		_ref_caster
	);
}
