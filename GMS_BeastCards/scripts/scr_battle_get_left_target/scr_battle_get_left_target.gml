//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_LEFT_TARGET
// FUNCTION: Returns the living Beast immediately before the supplied target
//           in its team's active formation list.
//           Returns undefined when no valid left target exists.
//
// INPUT:    _ref_target - Battle Beast whose left-adjacent Beast is requested.
// USES:     Shared battle team-list lookup.
//
//===============================================================================//

function scr_battle_get_left_target(_ref_target){

	#region TEAM DATA

	//--------------------//
	//GET TARGET TEAM LIST//
	//--------------------//
	var _list_targets = scr_battle_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return undefined;
	}

	//----------------//
	//GET TARGET INDEX//
	//----------------//
	var _it_target = ds_list_find_index(_list_targets,_ref_target);

	if (_it_target == -1){
		return undefined;
	}

	#endregion

	#region LEFT TARGET

	//-----------------//
	//CHECK LEFT INDEX//
	//-----------------//
	var _it_left_target = _it_target - 1;

	if (_it_left_target < 0){
		return undefined;
	}

	//---------------//
	//GET LEFT TARGET//
	//---------------//
	var _ref_left_target = ds_list_find_value(_list_targets,_it_left_target);

	if (!instance_exists(_ref_left_target)){
		return undefined;
	}

	#endregion

	return _ref_left_target;
}