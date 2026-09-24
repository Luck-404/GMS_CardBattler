//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURES_WRATH
// FUNCTION: Resolves Nature's Wrath.
//           Deals 1 additional damage per Poison stack on the target.
//           METABOLIZE 2 consumes up to 2 Poison and heals the caster
//           for 3 HP per Poison consumed.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_natures_wrath(_stct_card,_ref_caster,_ref_target){

	//================//
	//CALCULATE DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude;
	var _ref_poison = scr_status_check("POISON",_ref_target);

	if (_ref_poison != -1){
		_val_damage += _ref_poison._ct_status_stacks;
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
	//METABOLIZE 2//
	//================//
	if (
		instance_exists(_ref_target) &&
		instance_exists(_ref_caster)
	){

		var _ct_poison_consumed = scr_battle_trigger_metabolize(
			_ref_target,
			2
		);

		if (_ct_poison_consumed > 0){

			scr_battle_heal_target(
				"FIXED",
				_ct_poison_consumed * 3,
				_ref_caster
			);
		}
	}
}