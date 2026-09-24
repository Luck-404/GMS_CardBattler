//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_CINDER_KICK
// FUNCTION: Resolves Cinder Kick.
//           Deals Physical damage to the selected target.
//           ERUPTION 3 moves the surviving target backward 1 position.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_cinder_kick(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (_ref_target._val_cur_hp <= 0){
		return;
	}

	//================//
	//ERUPTION 3//
	//================//
	if (scr_battle_trigger_eruption(_ref_target,3)){
		scr_battle_reposition_beast(_ref_target,1);
	}
}
