//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_RAGEPLATE
// FUNCTION: Resolves Rageplate.
//           Consumes all Rage from the caster.
//           Grants 5 Armor per Rage consumed.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_rageplate(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	//================//
	//GET RAGE//
	//================//
	var _ct_rage = 0;
	var _ref_rage = scr_status_check("RAGE",_ref_caster);

	if (
		_ref_rage != -1 &&
		instance_exists(_ref_rage)
	){
		_ct_rage = _ref_rage._ct_status_stacks;
	}

	//----------------//
	//NO RAGE//
	//----------------//
	if (_ct_rage <= 0){
		return;
	}

	//================//
	//CONSUME ALL RAGE//
	//================//
	_ct_rage = scr_status_consume_rage(_ref_caster,_ct_rage);

	//================//
	//GAIN ARMOR//
	//================//
	var _val_armor = _ct_rage * _stct_card._val_card_magnitude;

	scr_battle_armor_target(_val_armor,_ref_caster);
}