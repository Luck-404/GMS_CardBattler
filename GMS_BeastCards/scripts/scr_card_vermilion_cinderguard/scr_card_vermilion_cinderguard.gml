//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_CINDERGUARD
// FUNCTION: Resolves Cinderguard.
//           Grants 5 Armor and 1 Cinderguard charge.
//           Each charge burns the next enemy that directly damages the caster.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_cinderguard(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	//================//
	//GAIN 5 ARMOR//
	//================//
	scr_battle_armor_target(5,_ref_caster);

	//================//
	//STORE TARGET//
	//================//
	var _ref_original_target = global.ref_target_beast;

	//====================//
	//GAIN CINDERGUARD//
	//====================//
	global.ref_target_beast = _ref_caster;

	scr_status_apply_buff("CINDERGUARD",1);

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;
}