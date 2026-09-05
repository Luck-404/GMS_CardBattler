//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_DISCHARGE
// FUNCTION: Checks a Beast for the Stormstruck DISCHARGE threshold.
//           At 8+ stacks, deals 15 neutral damage to the host,
//           reduces Stormstruck to 4 stacks, and applies
//           2 Stormstruck to each adjacent Beast.
//
//===============================================================================//

function scr_trigger_discharge(_ref_host){

	if (!instance_exists(_ref_host)){
		return false;
	}

	var _ref_stormstruck = scr_check_for_status(
		"STORMSTRUCK",
		_ref_host
	);

	if (_ref_stormstruck == -1){
		return false;
	}

	if (_ref_stormstruck._ct_status_stacks < 8){
		return false;
	}
	
	//----------------//
	//DISCHARGE VFX/SFX//
	//----------------//
	scr_battle_vfx(
		_ref_host,
		spr_battle_vfx_discharge,
		undefined,
		undefined,
		0,
		0,
		1.5,
		0,
		snd_battle_sfx_discharge
	);

	//-----------//
	//DISCHARGE//
	//-----------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"DISCHARGE",
		undefined,
		c_aqua,
		_ref_host.x,
		_ref_host.y - 48
	);

	//-------------------//
	//REDUCE TO 4 STACKS//
	//-------------------//
	_ref_stormstruck._ct_status_stacks = 4;

	scr_status_refresh_lifetime(
		_ref_stormstruck,
		3
	);

	//----------------//
	//DEAL 15 DAMAGE//
	//----------------//
	var _val_damage = 15;

	if (_ref_host._val_overhealth > 0){

		var _val_overhealth_damage = min(
			_ref_host._val_overhealth,
			_val_damage
		);

		_ref_host._val_overhealth -=
			_val_overhealth_damage;

		_val_damage -=
			_val_overhealth_damage;
	}

	if (_val_damage > 0){

		_ref_host._val_cur_hp = max(
			0,
			_ref_host._val_cur_hp -
			_val_damage
		);
	}

	//---------------------//
	//GET ADJACENT BEASTS//
	//---------------------//
	var _arr_adjacent = [
		scr_get_left_target(_ref_host),
		scr_get_right_target(_ref_host)
	];

	//------------------------//
	//APPLY ADJACENT STORMSTRUCK//
	//------------------------//
	for (var _it_target = 0; _it_target < array_length(_arr_adjacent); _it_target++){

		var _ref_target = _arr_adjacent[_it_target];

		if (!instance_exists(_ref_target)){
			continue;
		}

		if (_ref_target._val_cur_hp <= 0){
			continue;
		}

		var _ref_original_target =
			global.ref_target_beast;

		global.ref_target_beast =
			_ref_target;

		repeat (2){
			scr_apply_dot_status("STORMSTRUCK");
		}

		global.ref_target_beast =
			_ref_original_target;
	}

	scr_reposition_statuses(_ref_host);

	return true;
}