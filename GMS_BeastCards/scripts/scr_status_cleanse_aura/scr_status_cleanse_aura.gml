//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEANSE_AURA
// FUNCTION: Removes Aura Statuses from a target Beast.
//           Removes all cleansable Auras when no amount is supplied.
//           May also remove a limited number of Auras for future cards.
//           Plays Cleanse presentation when at least one Aura is removed.
//
//===============================================================================//

function scr_status_cleanse_aura(_ref_target,_ct_amount=undefined,_str_status_id=undefined){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
		return 0;
	}

	//----------------//
	//DEFAULT TO ALL//
	//----------------//
	if (_ct_amount == undefined){
		_ct_amount = ds_list_size(_ref_target._list_statuses);
	}

	//--------------//
	//CLEANSE AURAS//
	//--------------//
	var _ct_cleansed = scr_status_cleanse_type(
		_ref_target,
		"AURA",
		_ct_amount,
		_str_status_id
	);

	//----------------------//
	//CLEANSE PRESENTATION//
	//----------------------//
	if (_ct_cleansed > 0){
		scr_battle_vfx_cleanse(_ref_target);
	}

	return _ct_cleansed;
}