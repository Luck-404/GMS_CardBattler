//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOODFLAME_NEEDLE
// FUNCTION: Resolves Bloodflame Needle.
//           Deals linear Magical damage to the selected target.
//           Applies 1 Bleed.
//           Applies 1 additional Bleed if the target is Burning.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_bloodflame_needle(_stct_card,_ref_caster,_ref_target){

	//================//
	//CHECK BURN//
	//================//
	var _flag_target_burning = false;

	if (instance_exists(_ref_target)){

		var _ref_burn = scr_status_check("BURN",_ref_target);

		if (_ref_burn != -1 && instance_exists(_ref_burn)){
			_flag_target_burning = true;
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
	//APPLY BLEED//
	//================//


	scr_status_apply_dot("BLEED", _ref_target);

	if (_flag_target_burning){
		scr_status_apply_dot("BLEED", _ref_target);
	}

}
