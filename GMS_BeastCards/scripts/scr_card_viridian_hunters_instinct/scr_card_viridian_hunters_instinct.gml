//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_HUNTERS_INSTINCT
// FUNCTION: Resolves Hunter's Instinct.
//           Deals linear Physical damage to the selected target.
//           Deals 4 additional damage if the target is Bleeding.
//           EXECUTE grants the caster Boost for 2 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_hunters_instinct(_stct_card,_ref_caster,_ref_target){

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
	//CALCULATE DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude;
	var _ref_bleed = scr_status_check("BLEED",_ref_target);

	if (
		_ref_bleed != -1 &&
		instance_exists(_ref_bleed)
	){
		_val_damage += 4;
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
	//GAIN BOOST//
	//================//


	scr_status_apply_buff("BOOST", _ref_caster, 25, 2);

}