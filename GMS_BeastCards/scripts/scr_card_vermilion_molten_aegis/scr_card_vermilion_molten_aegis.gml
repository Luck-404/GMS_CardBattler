//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_MOLTEN_AEGIS
// FUNCTION: Resolves Molten Aegis.
//           Grants the target allied Beast 7 Armor.
//           Grants Molten Aegis, causing its next Attack to apply 1 Burn.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the allied Beast receiving Molten Aegis.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_molten_aegis(_stct_card,_ref_caster,_ref_target){

	//================//
	//GAIN ARMOR//
	//================//
	scr_battle_armor_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//===================//
	//GAIN MOLTEN AEGIS//
	//===================//


	scr_status_apply_buff("MOLTEN_AEGIS", _ref_target, 1);

}