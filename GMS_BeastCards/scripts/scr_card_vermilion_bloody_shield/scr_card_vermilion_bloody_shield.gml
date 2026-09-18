//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOODY_SHIELD
// FUNCTION: Resolves Bloody Shield.
//           Consumes up to 2 Rage from the caster.
//           Grants 5 Armor plus 5 additional Armor per Rage consumed.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_bloody_shield(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	//================//
	//CONSUME RAGE//
	//================//
	var _ct_rage_consumed = scr_status_consume_rage(_ref_caster,2);

	//================//
	//CALCULATE ARMOR//
	//================//
	var _val_armor = _stct_card._val_card_magnitude + (_ct_rage_consumed * 5);

	//================//
	//GAIN ARMOR//
	//================//
	scr_battle_armor_target(_val_armor,_ref_caster);
}