//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_PLAGUE_GARDEN
// FUNCTION: Triggers Plague Garden after a Beast successfully gains Bleed,
//           Poison, or Venom.
//           If the Beast is an enemy of the Plague Garden owner, summons one
//           Sporeling on that Beast.
//           Normal Minion capacity/replacement rules apply.
//
//===============================================================================//

function scr_trigger_plague_garden(_ref_target,_str_dot_name){

	if (!instance_exists(_ref_target)){
		return false;
	}

	if (
		_str_dot_name != "BLEED" &&
		_str_dot_name != "POISON" &&
		_str_dot_name != "VENOM"
	){
		return false;
	}

	//----------------------//
	//GET OPPOSING TEAM ID//
	//----------------------//
	var _str_opposing_team;

	if (_ref_target._str_team == "PLAYER"){
		_str_opposing_team = "ENEMY";
	}
	else{
		_str_opposing_team = "PLAYER";
	}

	//---------------------//
	//CHECK PLAGUE GARDEN//
	//---------------------//
	var _ref_plague_garden =
		scr_get_plague_garden_status(
			_str_opposing_team
		);

	if (_ref_plague_garden == -1){
		return false;
	}

	//------------------//
	//SUMMON SPORELING//
	//------------------//
	scr_init_minion(
		"SPORELING",
		undefined,
		undefined,
		_ref_target
	);

	scr_spawn_popup_scrolling(
		"TEXT",
		"PLAGUE GARDEN",
		undefined,
		c_green,
		_ref_target.x,
		_ref_target.y - 48
	);

	return true;
}