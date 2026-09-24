//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_RENDING_BLOW
// FUNCTION: Resolves Rending Blow.
//           Deals linear Physical damage to the target.
//           If the target was already Bleeding before the attack,
//           applies 1 additional Bleed afterward.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_rending_blow(_stct_card,_ref_caster,_ref_target){

	//================//
	//CHECK BLEED//
	//================//
	var _flag_target_bleeding = false;

	if (instance_exists(_ref_target)){

		var _ref_bleed = scr_status_check("BLEED",_ref_target);

		if (_ref_bleed != -1 && instance_exists(_ref_bleed)){
			_flag_target_bleeding = true;
		}
	}

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
	//APPLY BLEED//
	//================//
	if (
		_flag_target_bleeding &&
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){

		scr_status_apply_dot("BLEED", _ref_target);

	}
}