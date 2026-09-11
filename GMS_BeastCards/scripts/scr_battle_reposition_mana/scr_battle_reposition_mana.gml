//===============================================================================//
//
// SCRIPT: SCR_BATTLE_REPOSITION_MANA
// FUNCTION: Calculates GUI positions for all player Mana orb slots.
//           Arranges Mana into rows using the player controller's HUD settings
//           and rebuilds the position array when Maximum Mana changes.
//
// USES:     Player battle controller Maximum Mana, Mana HUD origin,
//           orb size, gap, row capacity, and stored Mana-position array.
//
//===============================================================================//

function scr_battle_reposition_mana(){

	#region VALIDATION

	//-------------------//
	//VALIDATE CONTROLLER//
	//-------------------//
	if (!instance_exists(obj_battle_player_controller)){
		return;
	}

	#endregion

	#region MANA DATA

	//----------------//
	//GET CONTROLLER//
	//----------------//
	var _ref_player_controller = obj_battle_player_controller;

	//------------------//
	//RESET POSITIONS//
	//------------------//
	_ref_player_controller._arr_mana_positions = [];

	//----------------//
	//GET MANA SLOTS//
	//----------------//
	var _ct_mana_slots = max(0,_ref_player_controller._val_max_mana);

	if (_ct_mana_slots <= 0){
		return;
	}

	//------------------//
	//CALCULATE SPACING//
	//------------------//
	var _val_mana_spacing =
		_ref_player_controller._val_mana_orb_size +
		_ref_player_controller._val_mana_orb_gap;

	#endregion

	#region MANA POSITIONS

	//----------------//
	//BUILD MANA SLOTS//
	//----------------//
	for (var _it_mana = 0; _it_mana < _ct_mana_slots; _it_mana++){

		//------------//
		//GET ROW/COL//
		//------------//
		var _it_column = _it_mana mod _ref_player_controller._ct_mana_per_row;
		var _it_row = floor(_it_mana / _ref_player_controller._ct_mana_per_row);

		//-----------------//
		//GET SLOT POSITION//
		//-----------------//
		var _val_mana_x =
			_ref_player_controller._val_mana_start_x +
			(_it_column * _val_mana_spacing);

		var _val_mana_y =
			_ref_player_controller._val_mana_start_y +
			(_it_row * _val_mana_spacing);

		//----------------//
		//STORE POSITION//
		//----------------//
		var _stct_mana_position = {
			_val_x : _val_mana_x,
			_val_y : _val_mana_y
		};

		array_push(_ref_player_controller._arr_mana_positions,_stct_mana_position);
	}

	#endregion
}