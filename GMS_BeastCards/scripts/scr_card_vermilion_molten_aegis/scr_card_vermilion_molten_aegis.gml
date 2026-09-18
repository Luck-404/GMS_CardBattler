//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_MOLTEN_AEGIS
// FUNCTION: Resolves Molten Aegis.
//           Grants the target allied Beast 7 Armor.
//           Grants Molten Aegis, causing its next Attack to apply 1 Burn.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the allied Beast receiving Molten Aegis.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_molten_aegis(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//GAIN ARMOR//
	//================//
	scr_battle_armor_target(_stct_card._val_card_magnitude,_ref_target);

	//===================//
	//GAIN MOLTEN AEGIS//
	//===================//
	var _ref_original_target = global.ref_target_beast;

	global.ref_target_beast = _ref_target;

	scr_status_apply_buff("MOLTEN_AEGIS",1);

	global.ref_target_beast = _ref_original_target;
}