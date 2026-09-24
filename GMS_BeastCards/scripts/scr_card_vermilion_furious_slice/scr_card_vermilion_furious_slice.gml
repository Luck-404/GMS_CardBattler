//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FURIOUS_SLICE
// FUNCTION: Resolves Furious Slice.
//           Consumes 1 Rage before damage calculation.
//           If Rage is consumed, adds 4 damage to the attack.
//           Deals linear Physical damage to the selected target.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_furious_slice(_stct_card,_ref_caster,_ref_target){

	//================//
	//CONSUME RAGE//
	//================//
	var _ct_rage_consumed = scr_status_consume_rage(_ref_caster,1);

	//================//
	//CALCULATE DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude;

	if (_ct_rage_consumed > 0){
		_val_damage += 4;
	}

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target("LINEAR",_ref_caster,_ref_target,_val_damage,{card: _stct_card, card_instance: global.ref_cast_card});
}
