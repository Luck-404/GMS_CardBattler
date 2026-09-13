//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_PLAGUE_GARDEN
// FUNCTION: Triggers Plague Garden after a Beast successfully gains Bleed,
//           Poison, or Venom.
//           If the Beast is an enemy of the Plague Garden owner, summons one
//           Sporeling on that Beast.
//           Normal Minion capacity and replacement rules apply.
//
//===============================================================================//

function scr_status_trigger_plague_garden(_ref_target,_str_dot_name){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	//--------------//
	//VALIDATE DOT//
	//--------------//
	if (
		_str_dot_name != "BLEED" &&
		_str_dot_name != "POISON" &&
		_str_dot_name != "VENOM"
	){
		return false;
	}

	//----------------//
	//VALIDATE TEAM//
	//----------------//
	if (
		_ref_target._str_team != "PLAYER" &&
		_ref_target._str_team != "ENEMY"
	){
		return false;
	}

	//===================//
	//GET OPPOSING TEAM//
	//===================//
	var _str_opposing_team = "PLAYER";

	if (_ref_target._str_team == "PLAYER"){
		_str_opposing_team = "ENEMY";
	}

	//=====================//
	//CHECK PLAGUE GARDEN//
	//=====================//
	var _ref_plague_garden = scr_status_get_plague_garden(_str_opposing_team);

	if (_ref_plague_garden == -1){
		return false;
	}

	if (!instance_exists(_ref_plague_garden)){
		return false;
	}

	//==================//
	//SUMMON SPORELING//
	//==================//
	scr_minion_init(
		"SPORELING",
		undefined,
		undefined,
		_ref_target
	);

	//==========//
	//FEEDBACK//
	//==========//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"PLAGUE GARDEN",
		undefined,
		c_green,
		_ref_target.x,
		_ref_target.y - 48
	);

	return true;
}