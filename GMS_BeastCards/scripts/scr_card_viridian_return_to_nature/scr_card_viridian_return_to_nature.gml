//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_RETURN_TO_NATURE
// FUNCTION: Sacrifices the selected corpse when valid; otherwise sacrifices
//           10 caster HP. Then generates 1 Mana.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected corpse or undefined.
// RETURNS: No value.
//
//===============================================================================//
function scr_card_viridian_return_to_nature(_stct_card,_ref_caster,_ref_target){

	//===================//
	//PAY SACRIFICE COST//
	//===================//
	var _stct_sacrifice = scr_battle_sacrifice("CORPSE",_ref_target);

	if (!_stct_sacrifice._flag_success){
		scr_battle_sacrifice("HOST_HEALTH",_ref_caster,10);
	}

	//================//
	//GENERATE MANA//
	//================//
	scr_battle_gain_mana(1);
}