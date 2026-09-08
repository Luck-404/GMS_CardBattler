//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_STEELFUR
// FUNCTION: Resolves the Steelfur card effect.
//           Doubles the caster's current Armor.
//
//===============================================================================//

function scr_card_viridian_steelfur(_stct_card,_ref_caster,_ref_target){

	//-------------//
	//DOUBLE ARMOR//
	//-------------//
	var _val_armor_gain =
		_ref_caster._val_armor;

	scr_battle_armor_target(
		_val_armor_gain,
		_ref_caster
	);

}