//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GAIN_MANA
// FUNCTION: Grants Mana to the player and clamps it to Maximum Mana.
//           Plays shared Mana Gain VFX/SFX, refreshes the Mana HUD,
//           and logs the actual amount of Mana gained.
//
// INPUT:    _ct_amount - Amount of Mana requested.
// USES:     Player battle controller current/maximum Mana values,
//           shared battle VFX, and Mana HUD positioning.
//
//===============================================================================//

function scr_battle_gain_mana(_ct_amount=1){

	#region VALIDATION

	//----------------//
	//VALIDATE AMOUNT//
	//----------------//
	if (_ct_amount <= 0){
		return 0;
	}

	//-------------------//
	//VALIDATE CONTROLLER//
	//-------------------//
	if (!instance_exists(obj_battle_player_controller)){
		return 0;
	}

	#endregion

	#region GAIN MANA

	//----------------//
	//GET CONTROLLER//
	//----------------//
	var _ref_player_controller = obj_battle_player_controller;

	//----------------//
	//STORE OLD MANA//
	//----------------//
	var _val_old_mana = _ref_player_controller._val_cur_mana;

	//-----------//
	//GAIN MANA//
	//-----------//
	_ref_player_controller._val_cur_mana = clamp(
		_ref_player_controller._val_cur_mana + _ct_amount,
		0,
		_ref_player_controller._val_max_mana
	);

	//------------------//
	//GET ACTUAL AMOUNT//
	//------------------//
	var _ct_mana_gained = _ref_player_controller._val_cur_mana - _val_old_mana;

	if (_ct_mana_gained <= 0){
		return 0;
	}

	#endregion

	#region FEEDBACK

	//--------------------//
	//MANA GAIN VFX / SFX//
	//--------------------//
	scr_battle_vfx(
		undefined,
		spr_battle_vfx_mana_gain,
		room_width * 0.25,
		room_height * 0.30,
		0,
		0,
		1,
		0,
		snd_battle_mana_gain
	);

	//----------------//
	//REFRESH MANA HUD//
	//----------------//
	scr_battle_reposition_mana();

	#endregion

	#region DEBUG

	//---------------//
	//LOG MANA GAIN//
	//---------------//
	scr_debug_log(
		"BATTLE",
		"MANA",
		_ref_player_controller,
		"PLAYER GAINED " + string(_ct_mana_gained) +
		" MANA | " + string(_val_old_mana) +
		"/" + string(_ref_player_controller._val_max_mana) +
		" -> " + string(_ref_player_controller._val_cur_mana) +
		"/" + string(_ref_player_controller._val_max_mana),
		"BATTLE",
		"SCR_BATTLE_GAIN_MANA"
	);

	#endregion

	return _ct_mana_gained;
}