//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROZEN_FANG
// FUNCTION: Resolves Frozen Fang.
//           Deals linear physical damage to the selected target.
//           Applies 1 Frostbite if the target survives.
//
// ARGUMENTS: _stct_card is the Frozen Fang card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_frozen_fang(_stct_card,_ref_caster,_ref_target){

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
	//APPLY FROSTBITE//
	//================//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){
		scr_status_apply_dot("FROSTBITE", _ref_target);
	}
}
