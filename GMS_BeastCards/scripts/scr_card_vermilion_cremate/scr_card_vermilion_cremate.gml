//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_CREMATE
// FUNCTION: Sacrifices the selected corpse when valid; otherwise sacrifices
//           10 caster HP. Then draws 2 cards and grants 2 Rage.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected corpse or undefined.
// RETURNS: No value.
//
//===============================================================================//
function scr_card_vermilion_cremate(_stct_card,_ref_caster,_ref_target){

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}

	//===================//
	//PAY SACRIFICE COST//
	//===================//
	var _stct_sacrifice = scr_battle_sacrifice("CORPSE",_ref_target);

	if (!_stct_sacrifice._flag_success){
		scr_battle_sacrifice("HOST_HEALTH",_ref_caster,10);
	}

	//================//
	//DRAW 2 CARDS//
	//================//
	scr_battle_draw_cards(
		_stct_card._val_card_magnitude
	);

	//================//
	//GAIN 2 RAGE//
	//================//
	scr_status_gain_rage(
		_ref_caster,
		_stct_card._val_card_magnitude
	);
}
