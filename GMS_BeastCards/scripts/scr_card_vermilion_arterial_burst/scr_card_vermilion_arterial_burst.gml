//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_ARTERIAL_BURST
// FUNCTION: Resolves Arterial Burst.
//           Deals linear Magical damage to the selected target.
//           Deals 4 additional damage if the target is already Bleeding.
//           Triggers HEMORRHAGE afterward.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_arterial_burst(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//CHECK BLEED//
	//================//
	var _ref_bleed = scr_status_check(
		"BLEED",
		_ref_target
	);

	var _flag_bleeding =
		_ref_bleed != -1 &&
		instance_exists(_ref_bleed);

	//================//
	//GET DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude;

	if (_flag_bleeding){
		_val_damage += 4;
	}

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_val_damage,
		_ref_target
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
	//HEMORRHAGE//
	//================//
	scr_battle_trigger_hemorrhage(_ref_target);
}