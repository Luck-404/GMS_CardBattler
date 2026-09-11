//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_HEALING_RECEIVED_AMOUNT
// FUNCTION: Calculates the final healing amount received by a battle Beast.
//           Applies active healing-received modifiers and returns the adjusted
//           amount without restoring HP.
//
// INPUTS:   _val_amount - Base healing amount before received-healing modifiers.
//           _ref_target - Battle Beast receiving the healing.
// USES:     Target Status list and healing-received Status magnitudes.
//
//===============================================================================//

function scr_battle_get_healing_received_amount(_val_amount,_ref_target){

	#region VALIDATION

	//-----------------//
	//VALIDATE TARGET//
	//-----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	//-----------------//
	//VALIDATE AMOUNT//
	//-----------------//
	if (_val_amount <= 0){
		return 0;
	}

	#endregion

	#region HEALING MODIFIERS

	//----------------//
	//BASE HEALING//
	//----------------//
	var _val_healing = _val_amount;
	var _list_statuses = _ref_target._list_statuses;
	var _ct_statuses = ds_list_size(_list_statuses);

	//----------------//
	//CHECK STATUSES//
	//----------------//
	for (var _it_status = 0; _it_status < _ct_statuses; _it_status++){

		var _ref_status = ds_list_find_value(_list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		//-----------------//
		//SAILOR'S RESOLVE//
		//-----------------//
		if (_ref_status._str_status_name == "SAILORS_RESOLVE"){
			_val_healing *= 1 + (_ref_status._val_status_magnitude / 100);
		}
	}

	#endregion

	return max(0,ceil(_val_healing));
}