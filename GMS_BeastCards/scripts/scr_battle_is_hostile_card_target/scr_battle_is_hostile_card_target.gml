//===============================================================================//
//
// SCRIPT: SCR_BATTLE_IS_HOSTILE_CARD_TARGET
// FUNCTION: Returns true when a Beast-cast Card selects an individual hostile
//           primary target and is therefore subject to Taunt.
//
//           Taunt does not restrict Self, friendly, Global, Teamwide,
//           corpse-targeting, or enemy-Card-targeting effects.
//
//           AoE Cards with a selected primary target remain subject to Taunt.
//           Their secondary targets are resolved normally by the Card.
//
//===============================================================================//

function scr_battle_is_hostile_card_target(_stct_card){

	//---------------//
	//VALIDATE CARD//
	//---------------//
	if (!is_struct(_stct_card)){
		return false;
	}

	var _str_range = _stct_card._str_card_range;
	var _str_type = _stct_card._str_card_type;
	var _str_effect = _stct_card._str_card_effect_type;
	var _str_count = _stct_card._str_card_target_count;

	//========================//
	//EXCLUDE OTHER TARGETING//
	//========================//
	if (
		_str_range == "SELF" ||
		_str_range == "TEAM" ||
		_str_range == "GLOBAL" ||
		_str_range == "ENEMY_CARD" ||
		_str_range == "CORPSE" ||
		_str_range == "CORPSE_OPTIONAL" ||
		_str_count == "TEAMWIDE" ||
		_str_count == "GLOBAL"
	){
		return false;
	}

	//================//
	//HOSTILE ATTACK//
	//================//
	if (_str_type == "ATTACK"){
		return true;
	}

	//======================//
	//HOSTILE EFFECT TYPES//
	//======================//
	if (
		_str_effect == "DIRECT" ||
		_str_effect == "DOT" ||
		_str_effect == "DEBUFF" ||
		_str_effect == "CC"
	){
		return true;
	}

	//=====================//
	//EXPLICIT ENEMY RANGE//
	//=====================//
	if (_str_range == "ENEMY"){
		return true;
	}

	//================//
	//HOSTILE TRAPS//
	//================//
	if (
		_str_effect == "TRAP" &&
		_stct_card._str_card_id != "DISTRACTING_TRAP"
	){
		return true;
	}

	return false;
}