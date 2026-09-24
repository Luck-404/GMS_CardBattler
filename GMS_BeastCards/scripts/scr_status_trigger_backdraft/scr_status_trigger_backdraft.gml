//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_BACKDRAFT
// FUNCTION: Checks the incoming direct-damage recipient for Backdraft.
//           Reflects the configured percentage of resolved incoming damage
//           to its source as fixed NEU damage.
//           Removes the reflected amount from the original damage instance
//           and consumes Backdraft.
//
// ARGUMENTS: _ref_defender is the Beast receiving direct damage.
//            _ref_source is the Beast responsible for the damage.
//            _val_incoming_damage is resolved damage before absorption.
// RETURNS: Remaining damage to continue resolving against the defender.
//
//===============================================================================//

function scr_status_trigger_backdraft(_ref_defender,_ref_source,_val_incoming_damage){

	//-------------------//
	//VALIDATE DEFENDER//
	//-------------------//
	if (!instance_exists(_ref_defender)){
		return _val_incoming_damage;
	}

	//----------------//
	//VALIDATE SOURCE//
	//----------------//
	if (!instance_exists(_ref_source)){
		return _val_incoming_damage;
	}

	if (_ref_source == _ref_defender){
		return _val_incoming_damage;
	}

	if (_ref_source._val_cur_hp <= 0){
		return _val_incoming_damage;
	}

	//----------------//
	//VALIDATE DAMAGE//
	//----------------//
	_val_incoming_damage = max(0,floor(_val_incoming_damage));

	if (_val_incoming_damage <= 0){
		return 0;
	}

	//================//
	//CHECK BACKDRAFT//
	//================//
	var _ref_backdraft = scr_status_check("BACKDRAFT",_ref_defender);

	if (_ref_backdraft == -1 || !instance_exists(_ref_backdraft)){
		return _val_incoming_damage;
	}

	//==================//
	//CALCULATE REFLECT//
	//==================//
	var _val_reflect_percent = clamp(_ref_backdraft._val_status_magnitude,0,100);
	var _val_reflected_damage = floor(_val_incoming_damage * (_val_reflect_percent / 100));
	var _val_remaining_damage = max(0,_val_incoming_damage - _val_reflected_damage);

	//==================//
	//CONSUME BACKDRAFT//
	//==================//
	scr_status_buff_backdraft("DEATH",_ref_backdraft);

	//==========//
	//FEEDBACK//
	//==========//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"BACKDRAFT",
		undefined,
		c_red,
		_ref_defender.x,
		_ref_defender.y - 48
	);

	//================//
	//REFLECT DAMAGE//
	//================//
	if (_val_reflected_damage > 0){
		scr_battle_damage_target(
			"FIXED",
			undefined,
			_ref_source,
			_val_reflected_damage
		);
	}

	//================//
	//DEBUG TRIGGER//
	//================//
	scr_debug_log_battle_trigger(
		"BACKDRAFT",
		_ref_defender,
		_ref_source,
		"INCOMING: " + string(_val_incoming_damage) +
		" | REFLECTED NEU: " + string(_val_reflected_damage) +
		" | REMAINING: " + string(_val_remaining_damage),
		"SCR_STATUS_TRIGGER_BACKDRAFT"
	);

	return _val_remaining_damage;
}