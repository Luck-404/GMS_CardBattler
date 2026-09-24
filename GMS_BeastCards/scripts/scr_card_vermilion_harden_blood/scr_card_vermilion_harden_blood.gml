//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_HARDEN_BLOOD
// FUNCTION: Resolves Harden Blood.
//           Grants the caster 8 Armor.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_harden_blood(_stct_card,_ref_caster,_ref_target){

	//================//
	//GAIN ARMOR//
	//================//
	scr_battle_armor_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_caster
	);

}