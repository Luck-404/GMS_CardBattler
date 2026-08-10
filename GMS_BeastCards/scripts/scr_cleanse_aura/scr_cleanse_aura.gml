//===============================================================================//
//
// SCRIPT: SCR_CLEANSE_AURA
// FUNCTION: Removes Aura statuses from a target Beast.
//           Removes all cleansable Auras when no amount is supplied.
//           May also remove a limited number of Auras for future cards.
//
//===============================================================================//
function scr_cleanse_aura(_ref_target,_ct_amount=undefined,_str_status_id=undefined){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	//----------------//
	//DEFAULT TO ALL//
	//----------------//
	if (_ct_amount == undefined){

		_ct_amount =
			ds_list_size(
				_ref_target._list_statuses
			);
	}

	//--------------//
	//CLEANSE AURAS//
	//--------------//
	return scr_cleanse_status_type(
		_ref_target,
		"AURA",
		_ct_amount,
		_str_status_id
	);
}