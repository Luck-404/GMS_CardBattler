//===============================================================================//
//
// SCRIPT: scr_battle_get_healing_received_amount
// FUNCTION: Calculates the final healing amount received by a battle Beast.
//           Applies active healing-received Buffs and future modifiers.
//           Returns the adjusted healing amount without restoring HP.
//
//===============================================================================//

function scr_battle_get_healing_received_amount(_val_amount,_ref_target){

	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (_val_amount <= 0){
		return 0;
	}

	var _val_healing =
		_val_amount;

	//----------------//
	//CHECK STATUSES//
	//----------------//
	for (var _it_status = 0; _it_status < ds_list_size(_ref_target._list_statuses); _it_status++){

		var _ref_status =
			ds_list_find_value(_ref_target._list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		//-----------------//
		//SAILOR'S RESOLVE//
		//-----------------//
		if (_ref_status._str_status_name == "SAILORS_RESOLVE"){

			_val_healing *=
				1 + (_ref_status._val_status_magnitude / 100);
		}
	}

	return max(0,ceil(_val_healing));
}