//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FEED_THE_FLAME
// FUNCTION: Sacrifices the caster's oldest Minion and adds its Maximum HP to
//           this Attack's base damage. If none exists, sacrifices 6 caster HP.
//           Applies 2 Burn to the surviving target.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected enemy Beast.
// RETURNS: No value.
//
//===============================================================================//
function scr_card_vermilion_feed_the_flame(_stct_card,_ref_caster,_ref_target){

	//================//
	//BASE DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude;

	//================//
	//SACRIFICE MINION//
	//================//
	var _stct_sacrifice = scr_battle_sacrifice("MINION",_ref_caster,"OLDEST");

	if (_stct_sacrifice._flag_success){
		_val_damage += _stct_sacrifice._val_minion_max_hp;
	}
	else{
		scr_battle_sacrifice("HOST_HEALTH",_ref_caster,6);
	}

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_val_damage,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);

	if (!instance_exists(_ref_target)){
		return;
	}

	if (_ref_target._val_cur_hp <= 0){
		return;
	}

	//================//
	//APPLY 2 BURN//
	//================//


	repeat (2){
		scr_status_apply_dot("BURN", _ref_target);
	}

}