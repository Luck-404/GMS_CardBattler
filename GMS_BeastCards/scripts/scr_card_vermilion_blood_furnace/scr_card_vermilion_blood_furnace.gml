//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOOD_FURNACE
// FUNCTION: Resolves Blood Furnace.
//           Deals linear Magical damage plus 2 additional damage
//           for each Char stack already on the target.
//           ERUPTION 3 applies 1 Char to the surviving target.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_blood_furnace(_stct_card,_ref_caster,_ref_target){

	//================//
	//GET CHAR STACKS//
	//================//
	var _ct_char = 0;
	var _ref_char = scr_status_check(
		"CHAR",
		_ref_target
	);

	if (
		_ref_char != -1 &&
		instance_exists(_ref_char)
	){
		_ct_char = _ref_char._ct_status_stacks;
	}

	//================//
	//GET DAMAGE//
	//================//
	var _val_damage =
		_stct_card._val_card_magnitude +
		(_ct_char * 2);

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
	//ERUPTION 3//
	//================//
	if (!scr_battle_trigger_eruption(_ref_target,3)){
		return;
	}

	//================//
	//APPLY CHAR//
	//================//


	scr_status_debuff_char("APPLY", undefined, undefined, _ref_target);

}