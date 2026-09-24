//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_WILT
// FUNCTION: Resolves Wilt.
//           Applies Wither to the selected Beast for 3 rounds.
//           METABOLIZE 2 consumes exactly 2 Poison to increase
//           Wither's duration to 5 rounds instead.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_wilt(_stct_card,_ref_caster,_ref_target){

	//================//
	//SET LIFETIME//
	//================//
	var _val_wither_lifetime = 3;

	//================//
	//CHECK POISON//
	//================//
	var _ref_poison = scr_status_check(
		"POISON",
		_ref_target
	);

	if (
		_ref_poison != -1 &&
		instance_exists(_ref_poison) &&
		_ref_poison._ct_status_stacks >= 2
	){

		//================//
		//METABOLIZE 2//
		//================//
		var _ct_poison_consumed = scr_battle_trigger_metabolize(
			_ref_target,
			2
		);

		if (_ct_poison_consumed == 2){
			_val_wither_lifetime = 5;
		}
	}

	//================//
	//APPLY WITHER//
	//================//
	scr_status_apply_debuff("WITHER", _ref_target, _val_wither_lifetime);
}
