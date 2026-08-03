//===============================================================================//
//
// SCRIPT: SCR_TRANSFORM_MINION
// FUNCTION: Replaces one exact minion with another minion type.
//           Preserves the source minion's host and list position.
//           Does not replace unrelated minions.
//
//===============================================================================//

function scr_transform_minion(_ref_minion,_str_new_minion_id){

	if (!instance_exists(_ref_minion)){
		return undefined;
	}

	var _ref_host = _ref_minion._ref_host;

	if (!instance_exists(_ref_host)){
		return undefined;
	}

	var _it_minion = ds_list_find_index(_ref_host._list_minions,_ref_minion);

	if (_it_minion == -1){
		return undefined;
	}

	//----------------------//
	//REMOVE SOURCE MINION//
	//----------------------//
	ds_list_delete(_ref_host._list_minions,_it_minion);

	instance_destroy(_ref_minion);

	//--------------------//
	//CREATE TRANSFORMATION//
	//--------------------//
	var _ref_new_minion = scr_init_minion(_str_new_minion_id,undefined,undefined,_ref_host);

	//----------------------//
	//RESTORE LIST POSITION//
	//----------------------//
	var _it_new = ds_list_find_index(_ref_host._list_minions,_ref_new_minion);

	if (_it_new != -1 && _it_minion < ds_list_size(_ref_host._list_minions)){

		ds_list_delete(_ref_host._list_minions,_it_new);
		ds_list_insert(_ref_host._list_minions,_it_minion,_ref_new_minion);
	}

	scr_reposition_minions(_ref_host);

	return _ref_new_minion;
}