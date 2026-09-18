//===============================================================================//
//
// SCRIPT: SCR_CC_GET_BLIND_ATTACK_TARGET_MODE
// FUNCTION: Returns the targeting restriction imposed by Blind.
//           NONE allows normal targeting.
//           FRONT forces an Attack to target the front enemy Beast.
//           BLOCK prevents Flank/Backline Attacks from being cast.
//           Teamwide, Global, and Self Attacks remain unaffected.
//
//===============================================================================//

function scr_cc_get_blind_attack_target_mode(_ref_caster,_stct_card){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return "NONE";
	}

	//---------------//
	//VALIDATE CARD//
	//---------------//
	if (!is_struct(_stct_card)){
		return "NONE";
	}

	//================//
	//CHECK BLIND//
	//================//
	var _ref_blind = scr_status_check("BLIND",_ref_caster);

	if (
		_ref_blind == -1 ||
		!instance_exists(_ref_blind)
	){
		return "NONE";
	}

	//======================//
	//ONLY RESTRICT ATTACKS//
	//======================//
	if (_stct_card._str_card_type != "ATTACK"){
		return "NONE";
	}

	//==========================//
	//TEAMWIDE / GLOBAL ARE FINE//
	//==========================//
	if (
		_stct_card._str_card_target_count == "TEAMWIDE" ||
		_stct_card._str_card_target_count == "GLOBAL" ||
		_stct_card._str_card_range == "GLOBAL"
	){
		return "NONE";
	}

	//====================//
	//SELF IS UNAFFECTED//
	//====================//
	if (_stct_card._str_card_range == "SELF"){
		return "NONE";
	}

	//====================//
	//BLOCK FLANK / BACK//
	//====================//
	if (
		_stct_card._str_card_range == "BACK" ||
		_stct_card._str_card_range == "FLANK"
	){
		return "BLOCK";
	}

	//=========================//
	//OTHER ATTACKS GO FRONT//
	//=========================//
	return "FRONT";
}