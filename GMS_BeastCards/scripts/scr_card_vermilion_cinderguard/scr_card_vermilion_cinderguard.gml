//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_CINDERGUARD
// FUNCTION: Resolves Cinderguard.
//           Grants 5 Armor and 2 Cinderguard charges.
//           Each charge burns the next enemy that directly damages the caster.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_cinderguard(_stct_card,_ref_caster,_ref_target){

	//================//
	//GAIN 5 ARMOR//
	//================//
	scr_battle_armor_target(
		"FIXED",
		5,
		_ref_caster
	);


	//====================//
	//GAIN CINDERGUARD//
	//====================//

	scr_status_apply_buff("CINDERGUARD",_ref_caster,2);

}