//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FURIOUS_SLICE
// FUNCTION: Resolves Furious Slice.
//           Deals linear Physical damage to the selected target.
//           If the caster has Rage, adds 4 damage to the attack and
//           consumes 1 Rage afterward.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_furious_slice(_stct_card,_ref_caster,_ref_target){

	//================//
	//CALCULATE DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude;
	var _flag_consume_rage = false;

	var _ref_rage = scr_status_check("RAGE",_ref_caster);

	if (
		_ref_rage != -1 &&
		instance_exists(_ref_rage) &&
		_ref_rage._ct_status_stacks > 0
	){
		_val_damage += 4;
		_flag_consume_rage = true;
	}

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(_val_damage,_ref_target);

	//================//
	//CONSUME RAGE//
	//================//
	if (_flag_consume_rage){
		scr_status_consume_rage(_ref_caster,1);
	}
}