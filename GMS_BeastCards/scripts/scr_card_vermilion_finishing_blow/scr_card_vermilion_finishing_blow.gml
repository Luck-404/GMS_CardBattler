//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FINISHING_BLOW
// FUNCTION: Resolves Finishing Blow.
//           Deals linear Physical damage to the selected target.
//           EXECUTE grants the caster 1 Rage.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_finishing_blow(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE BEASTS//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	//====================//
	//STORE EXECUTE STATE//
	//====================//
	var _flag_target_alive = _ref_target._val_cur_hp > 0;

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

	//================//
	//EXECUTE//
	//================//
	if (
		!scr_battle_trigger_execute(
			_ref_caster,
			_ref_target,
			_flag_target_alive
		)
	){
		return;
	}

	//================//
	//GAIN 1 RAGE//
	//================//
	scr_status_gain_rage(
		_ref_caster,
		1
	);
}