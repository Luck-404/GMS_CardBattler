//===============================================================================//
//
// SCRIPT: SCR_GET_BLIND_ATTACK_TARGET_MODE
// FUNCTION: Returns the targeting restriction imposed by Blind.
//           NONE allows normal targeting.
//           FRONT forces an Attack to target the front enemy Beast.
//           BLOCK prevents Flank/Backline Attacks from being cast.
//           Teamwide, Global, and Self Attacks remain unaffected.
//
//===============================================================================//
function scr_get_blind_attack_target_mode(_ref_caster,_stct_card){

	if (!instance_exists(_ref_caster)){
		return "NONE";
	}

	if (!is_struct(_stct_card)){
		return "NONE";
	}

	if (scr_check_for_status("BLIND",_ref_caster) == -1){
		return "NONE";
	}

	//--------------------//
	//ONLY RESTRICT ATTACKS//
	//--------------------//
	if (_stct_card._str_card_type != "ATTACK"){
		return "NONE";
	}

	//---------------------------//
	//TEAMWIDE / GLOBAL ARE FINE//
	//---------------------------//
	if (
		_stct_card._str_card_target_count == "TEAMWIDE" ||
		_stct_card._str_card_target_count == "GLOBAL" ||
		_stct_card._str_card_range == "GLOBAL"
	){
		return "NONE";
	}

	//----------------//
	//SELF IS UNAFFECTED//
	//----------------//
	if (_stct_card._str_card_range == "SELF"){
		return "NONE";
	}

	//----------------------//
	//FLANK CANNOT BE USED//
	//----------------------//
	if (
		_stct_card._str_card_range == "BACK" ||
		_stct_card._str_card_range == "FLANK"
	){
		return "BLOCK";
	}

	//----------------------//
	//OTHER ATTACKS GO FRONT//
	//----------------------//
	return "FRONT";
}