//===============================================================================//
//
// SCRIPT: SCR_BATTLE_TRIGGER_DISCHARGE
// FUNCTION: Checks a Beast for the Stormstruck DISCHARGE threshold.
//           At 8+ stacks, deals 15 neutral damage to the host, reduces
//           Stormstruck to 4 stacks, and applies 2 Stormstruck to each
//           adjacent living Beast.
//
// INPUT:    _ref_host - Beast whose Stormstruck stacks are being checked.
// USES:     Stormstruck status data, adjacent battle targeting, status
//           application, status positioning, and shared battle feedback.
//
//===============================================================================//

function scr_battle_trigger_discharge(_ref_host){

	#region VALIDATION

	//---------------//
	//VALIDATE HOST//
	//---------------//
	if (!instance_exists(_ref_host)){
		return false;
	}

	//-------------------//
	//CHECK STORMSTRUCK//
	//-------------------//
	var _ref_stormstruck = scr_status_check("STORMSTRUCK",_ref_host);

	if (_ref_stormstruck == -1){
		return false;
	}

	if (_ref_stormstruck._ct_status_stacks < 8){
		return false;
	}

	#endregion

	#region DISCHARGE FEEDBACK

	//-------------------//
	//DISCHARGE VFX / SFX//
	//-------------------//
	scr_battle_vfx(
		_ref_host,
		spr_battle_vfx_discharge,
		undefined,
		undefined,
		0,
		0,
		1.5,
		0,
		snd_battle_discharge
	);

	//----------------//
	//DISCHARGE POPUP//
	//----------------//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"DISCHARGE",
		undefined,
		c_aqua,
		_ref_host.x,
		_ref_host.y - 48
	);

	#endregion

	#region STORMSTRUCK

	//------------------//
	//REDUCE TO 4 STACKS//
	//------------------//
	_ref_stormstruck._ct_status_stacks = 4;

	scr_status_refresh_lifetime(_ref_stormstruck,3);

	#endregion

	#region DAMAGE

	//----------------//
	//DEAL 15 DAMAGE//
	//----------------//
	var _val_damage_remaining = 15;

	//-----------------//
	//DAMAGE OVERHEALTH//
	//-----------------//
	if (_ref_host._val_overhealth > 0){

		var _val_overhealth_damage = min(_ref_host._val_overhealth,_val_damage_remaining);

		_ref_host._val_overhealth -= _val_overhealth_damage;
		_val_damage_remaining -= _val_overhealth_damage;
	}

	//----------//
	//DAMAGE HP//
	//----------//
	if (_val_damage_remaining > 0){
		_ref_host._val_cur_hp = max(0,_ref_host._val_cur_hp - _val_damage_remaining);
	}

	#endregion

	#region ADJACENT STORMSTRUCK

	//---------------------//
	//GET ADJACENT BEASTS//
	//---------------------//
	var _arr_adjacent_targets = [
		scr_battle_get_left_target(_ref_host),
		scr_battle_get_right_target(_ref_host)
	];

	var _ref_original_target = global.ref_target_beast;

	//---------------------------//
	//APPLY ADJACENT STORMSTRUCK//
	//---------------------------//
	for (var _it_target = 0; _it_target < array_length(_arr_adjacent_targets); _it_target++){

		var _ref_target = _arr_adjacent_targets[_it_target];

		if (!instance_exists(_ref_target)){
			continue;
		}

		if (_ref_target._val_cur_hp <= 0){
			continue;
		}

		global.ref_target_beast = _ref_target;

		repeat (2){
			scr_status_apply_dot("STORMSTRUCK");
		}
	}

	//-----------------------//
	//RESTORE GLOBAL TARGET//
	//-----------------------//
	global.ref_target_beast = _ref_original_target;

	#endregion

	#region STATUS POSITION

	//-------------------//
	//REFRESH STATUS GUI//
	//-------------------//
	scr_status_reposition(_ref_host);

	#endregion

	return true;
}