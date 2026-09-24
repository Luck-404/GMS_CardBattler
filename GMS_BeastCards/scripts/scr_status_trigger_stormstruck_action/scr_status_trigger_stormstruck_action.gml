//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRIGGER_STORMSTRUCK_ACTION
// FUNCTION: Triggers Stormstruck when a Beast successfully performs an action.
//           Deals stored NEU damage per current stack using the pre-consumption
//           stack count, removes 1 stack, and refreshes remaining lifetime.
//           Logs the resolved trigger and actual Overhealth / HP damage.
//
// ARGUMENTS: _ref_beast is the Beast whose successful action triggers Stormstruck.
// RETURNS: True when Stormstruck successfully triggers; otherwise false.
//
//===============================================================================//

function scr_status_trigger_stormstruck_action(_ref_beast){

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (_ref_beast._str_list != "ALIVE" || _ref_beast._val_cur_hp <= 0){
		return false;
	}

	//===================//
	//CHECK STORMSTRUCK//
	//===================//
	var _ref_stormstruck = scr_status_check("STORMSTRUCK",_ref_beast);

	if (_ref_stormstruck == -1){
		return false;
	}

	if (!instance_exists(_ref_stormstruck)){
		return false;
	}

	//================//
	//GET STACK COUNT//
	//================//
	var _ct_stacks = _ref_stormstruck._ct_status_stacks;

	if (_ct_stacks <= 0){
		return false;
	}

	//================//
	//DAMAGE AMOUNT//
	//================//
	var _val_damage_total =
		_ct_stacks *
		_ref_stormstruck._val_status_magnitude;

	var _val_damage_remaining = _val_damage_total;

	var _val_overhealth_damage = 0;
	var _val_hp_damage = 0;

	//===================//
	//DAMAGE OVERHEALTH//
	//===================//
	if (
		_val_damage_remaining > 0 &&
		_ref_beast._val_overhealth > 0
	){

		_val_overhealth_damage = min(
			_ref_beast._val_overhealth,
			_val_damage_remaining
		);

		_ref_beast._val_overhealth -= _val_overhealth_damage;
		_val_damage_remaining -= _val_overhealth_damage;

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_overhealth_damage),
			undefined,
			c_green,
			_ref_beast.x + irandom_range(-32,32),
			_ref_beast.y - 24 + irandom_range(-32,32)
		);
	}

	//=============//
	//DAMAGE HP//
	//=============//
	if (
		_val_damage_remaining > 0 &&
		_ref_beast._val_cur_hp > 0
	){

		_val_hp_damage = min(
			_val_damage_remaining,
			_ref_beast._val_cur_hp
		);

		_ref_beast._val_cur_hp = max(
			0,
			_ref_beast._val_cur_hp - _val_hp_damage
		);

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_hp_damage),
			undefined,
			c_maroon,
			_ref_beast.x + irandom_range(-32,32),
			_ref_beast.y - 24 + irandom_range(-32,32)
		);
	}

	//==========//
	//TICK VFX//
	//==========//
	scr_battle_vfx(
		_ref_beast,
		spr_battle_vfx_stormstruck_tick,
		undefined,
		undefined,
		32,
		32,
		1,
		0,
		snd_battle_stormstruck
	);

	//================//
	//DEBUG TRIGGER//
	//================//
	var _ct_stacks_remaining = max(0,_ct_stacks - 1);

	scr_debug_log_battle_trigger(
		"STORMSTRUCK",
		_ref_beast,
		_ref_beast,
		"STACKS: " + string(_ct_stacks) +
		" -> " + string(_ct_stacks_remaining) +
		" | NEU DAMAGE: " +
		string(_val_overhealth_damage + _val_hp_damage) +
		" | OVERHEALTH: " + string(_val_overhealth_damage) +
		" | HP: " + string(_val_hp_damage),
		"SCR_STATUS_TRIGGER_STORMSTRUCK_ACTION"
	);

	//================//
	//REMOVE 1 STACK//
	//================//
	if (!instance_exists(_ref_stormstruck)){
		return true;
	}

	_ref_stormstruck._ct_status_stacks--;

	//--------------------//
	//REMOVE EMPTY STATUS//
	//--------------------//
	if (_ref_stormstruck._ct_status_stacks <= 0){

		scr_status_dot_stormstruck(
			"DEATH",
			_ref_stormstruck
		);

		return true;
	}

	//==================//
	//REFRESH LIFETIME//
	//==================//
	scr_status_refresh_lifetime(
		_ref_stormstruck,
		3
	);

	if (
		instance_exists(_ref_beast) &&
		_ref_beast._val_cur_hp > 0
	){
		scr_status_reposition(_ref_beast);
	}

	return true;
}
