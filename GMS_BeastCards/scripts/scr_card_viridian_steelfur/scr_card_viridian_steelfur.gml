//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_STEELFUR
// FUNCTION: Resolves Steelfur.
//           Doubles the caster's current Armor.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_steelfur(_stct_card,_ref_caster,_ref_target){

	//================//
	//DOUBLE ARMOR//
	//================//
	var _val_armor_gain = _ref_caster._val_armor;

	scr_battle_armor_target(
		"FIXED",
		_val_armor_gain,
		_ref_caster
	);
}