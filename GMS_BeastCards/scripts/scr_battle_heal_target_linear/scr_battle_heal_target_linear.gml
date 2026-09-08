//===============================================================================//
//
// SCRIPT: scr_battle_heal_target_linear
// FUNCTION: Calculates linearly scaled healing and resolves it on the target.
//           Healing attempts still resolve when the target is at Maximum HP.
//
//===============================================================================//
function scr_battle_heal_target_linear(_val_amount,_ref_target){

	var _val_healing =
		scr_battle_get_heal_linear_amount(
			_val_amount,
			global.ref_caster_beast,
			global.ref_cast_card._ref_card
		);

	if (_val_healing <= 0){
		return false;
	}

	return scr_battle_heal_target(
		_val_healing,
		_ref_target
	);
}