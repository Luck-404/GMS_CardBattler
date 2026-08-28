//===============================================================================//
//
// SCRIPT: SCR_GET_ENDLESS_BLOOM_STATUS
// FUNCTION: Returns the active Endless Bloom status when it protects the
//           supplied team.
//           Returns -1 when Endless Bloom is absent or belongs to another team.
//
//===============================================================================//

function scr_get_endless_bloom_status(_str_team){

	var _ref_status =
		scr_check_for_status(
			"ENDLESS_BLOOM",
			global.list_statuses
		);

	if (_ref_status == -1){
		return -1;
	}

	if (!instance_exists(_ref_status)){
		return -1;
	}

	if (
		!variable_instance_exists(
			_ref_status,
			"_str_status_team"
		)
	){
		return -1;
	}

	if (
		_ref_status._str_status_team !=
		_str_team
	){
		return -1;
	}

	return _ref_status;
}