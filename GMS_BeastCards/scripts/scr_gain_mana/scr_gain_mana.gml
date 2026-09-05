//===============================================================================//
//
// SCRIPT: SCR_GAIN_MANA
// FUNCTION: Grants Mana to the player.
//           Clamps current Mana to Maximum Mana.
//           Plays shared Mana Gain VFX and SFX when Mana is actually gained.
//           Refreshes Mana HUD positions after the gain.
//
//===============================================================================//

function scr_gain_mana(_ct_amount=1){

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

	//----------------//
	//GET CONTROLLER//
	//----------------//
	var _ref_controller =
		obj_battle_player_controller;

	//----------------//
	//STORE OLD MANA//
	//----------------//
	var _val_old_mana =
		_ref_controller._val_cur_mana;

	//-----------//
	//GAIN MANA//
	//-----------//
	_ref_controller._val_cur_mana =
		clamp(
			_ref_controller._val_cur_mana +
				_ct_amount,
			0,
			_ref_controller._val_max_mana
		);

	//------------------//
	//GET ACTUAL AMOUNT//
	//------------------//
	var _ct_mana_gained =
		_ref_controller._val_cur_mana -
		_val_old_mana;

	//----------------//
	//NO MANA GAINED//
	//----------------//
	if (_ct_mana_gained <= 0){
		return 0;
	}

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
		snd_battle_sfx_mana_gain
	);

	//-------------------//
	//REFRESH MANA HUD//
	//-------------------//
	scr_reposition_mana();

	return _ct_mana_gained;
}