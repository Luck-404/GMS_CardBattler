//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_RAGEHOOK
// FUNCTION: Resolves Ragehook.
//           Deals linear Physical damage to the selected target.
//           If the caster had at least 2 Rage when attacking,
//           moves the surviving target forward 1 position.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_ragehook(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE BEASTS//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//CHECK 2 RAGE//
	//================//
	var _flag_rage_threshold = false;
	var _ref_rage = scr_status_check("RAGE",_ref_caster);

	if (
		_ref_rage != -1 &&
		instance_exists(_ref_rage) &&
		_ref_rage._ct_status_stacks >= 2
	){
		_flag_rage_threshold = true;
	}

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(_stct_card._val_card_magnitude,_ref_target);

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (_ref_target._val_cur_hp <= 0){
		return;
	}

	//===================//
	//REPOSITION FORWARD//
	//===================//
	if (_flag_rage_threshold){
		scr_battle_reposition_beast(_ref_target,-1);
	}
}