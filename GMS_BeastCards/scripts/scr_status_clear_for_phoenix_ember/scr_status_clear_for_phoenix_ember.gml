//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEAR_FOR_PHOENIX_EMBER
// FUNCTION: Removes hosted Status effects when Phoenix Ember prevents defeat.
//
//           Phoenix Ember intentionally removes permanent and nonpermanent
//           Statuses alike.
//
//           The following effects are preserved:
//           - OUTLEVELED
//           - LAST_STAND
//           - PHOENIX_REBIRTH
//           - SECOND_LIFE
//
//           Each removed Status receives its normal DEATH cleanup so owned stat
//           changes and other Status-specific state are reversed correctly.
//
// ARGUMENTS: _ref_target - Beast whose Status effects are being cleared.
// RETURNS: Number of Statuses removed.
//
//===============================================================================//

function scr_status_clear_for_phoenix_ember(_ref_target){

	#region VALIDATION

	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (
		!ds_exists(
			_ref_target._list_statuses,
			ds_type_list
		)
	){
		return 0;
	}

	#endregion

	#region BUILD REMOVE QUEUE

	var _arr_remove = [];

	for (
		var _it_status = 0;
		_it_status <
			ds_list_size(
				_ref_target._list_statuses
			);
		_it_status++
	){

		var _ref_status =
			ds_list_find_value(
				_ref_target._list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_status)){
			continue;
		}

		var _str_status_name =
			"";

		if (
			variable_instance_exists(
				_ref_status,
				"_str_status_name"
			)
		){

			_str_status_name =
				string_upper(
					string(
						_ref_status
							._str_status_name
					)
				);
		}

		//=========================//
		//PRESERVE RESURRECT STATE//
		//=========================//
		switch (_str_status_name){

			case "OUTLEVELED":
			case "LAST_STAND":
			case "PHOENIX_REBIRTH":
			case "SECOND_LIFE":
				continue;
		}

		array_push(
			_arr_remove,
			_ref_status
		);
	}

	#endregion

	#region REMOVE STATUSES

	var _ct_removed = 0;

	for (
		var _it_remove = 0;
		_it_remove <
			array_length(
				_arr_remove
			);
		_it_remove++
	){

		var _ref_status =
			_arr_remove[
				_it_remove
			];

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (
			variable_instance_exists(
				_ref_status,
				"_scr_status"
			) &&
			_ref_status._scr_status !=
				undefined
		){

			_ref_status._scr_status(
				"DEATH",
				_ref_status
			);
		}
		else{

			scr_status_destroy(
				_ref_status
			);
		}

		_ct_removed++;
	}

	#endregion

	#region PRESENTATION

	if (
		_ct_removed > 0 &&
		instance_exists(_ref_target)
	){

		scr_battle_vfx_cleanse(
			_ref_target
		);

		scr_status_reposition(
			_ref_target
		);
	}

	#endregion

	return _ct_removed;
}
