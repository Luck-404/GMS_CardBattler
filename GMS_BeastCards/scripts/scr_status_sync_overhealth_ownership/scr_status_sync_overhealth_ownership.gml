//===============================================================================//
//
// SCRIPT: SCR_STATUS_SYNC_OVERHEALTH_OWNERSHIP
// FUNCTION: Synchronizes Status-owned portions of a Beast's shared Overhealth.
//           Temporary OVERHEALTH is treated as consumed before
//           PERSISTENT_OVERHEALTH.
//           Both mechanics continue using the Beast's single _val_overhealth
//           defensive pool.
//
// ARGUMENTS: _ref_target is the battle Beast whose Overhealth is synchronized.
// RETURNS: True when synchronization completes; otherwise false.
//
//===============================================================================//

function scr_status_sync_overhealth_ownership(_ref_target){

	//-----------------//
	//VALIDATE TARGET//
	//-----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
		return false;
	}

	//==================//
	//CLAMP TOTAL POOL//
	//==================//
	_ref_target._val_overhealth =
		max(
			0,
			_ref_target._val_overhealth
		);

	var _val_total_overhealth =
		_ref_target._val_overhealth;

	//=======================//
	//PERSISTENT OVERHEALTH//
	//=======================//
	var _ref_persistent_overhealth = scr_status_check(
		"PERSISTENT_OVERHEALTH",
		_ref_target
	);

	var _val_persistent_overhealth = 0;

	if (
		_ref_persistent_overhealth != -1 &&
		instance_exists(_ref_persistent_overhealth)
	){

		_val_persistent_overhealth = clamp(
			_ref_persistent_overhealth._val_status_remaining,
			0,
			_val_total_overhealth
		);

		_ref_persistent_overhealth._val_status_remaining =
			_val_persistent_overhealth;
	}

	//======================//
	//TEMPORARY OVERHEALTH//
	//======================//
	var _ref_overhealth = scr_status_check(
		"OVERHEALTH",
		_ref_target
	);

	if (
		_ref_overhealth != -1 &&
		instance_exists(_ref_overhealth)
	){

		var _val_temporary_available = max(
			0,
			_val_total_overhealth -
			_val_persistent_overhealth
		);

		_ref_overhealth._val_status_remaining = clamp(
			_ref_overhealth._val_status_remaining,
			0,
			_val_temporary_available
		);
	}

	return true;
}