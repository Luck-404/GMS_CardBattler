//===============================================================================//
//
// SCRIPT: SCR_STATUS_DESTROY
// FUNCTION: Removes an exact Status instance from its owning Status list.
//           Supports Global Statuses and host-bound Statuses.
//           Purges stale references, destroys the Status instance, and
//           refreshes remaining Status icon positions.
//
// ARGUMENTS: _ref_status is the exact Status instance to remove and destroy.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_status_destroy(_ref_status){

	//-----------------//
	//VALIDATE STATUS//
	//-----------------//
	if (!instance_exists(_ref_status)){
		return;
	}

	var _ref_host = _ref_status._ref_host;

	//================//
	//GLOBAL STATUS//
	//================//
	if (_ref_host == undefined){

		if (ds_exists(global.list_statuses,ds_type_list)){

			//------------------//
			//REMOVE FROM LIST//
			//------------------//
			var _it_status = ds_list_find_index(
				global.list_statuses,
			_ref_status
			);

			if (_it_status != -1){
				ds_list_delete(global.list_statuses,_it_status);
			}

			//--------------------//
			//PURGE INVALID REFS//
			//--------------------//
			scr_status_prune_list(global.list_statuses);
		}

		//----------------//
		//DESTROY STATUS//
		//----------------//
		instance_destroy(_ref_status);

		//-------------------//
		//REPOSITION ICONS//
		//-------------------//
		if (ds_exists(global.list_statuses,ds_type_list)){
			scr_status_reposition(global.list_statuses);
		}

		return;
	}

	//====================//
	//HOST-BOUND STATUS//
	//====================//
	if (instance_exists(_ref_host)){

		if (ds_exists(_ref_host._list_statuses,ds_type_list)){

			//------------------//
			//REMOVE FROM LIST//
			//------------------//
			var _it_status = ds_list_find_index(
				_ref_host._list_statuses,
			_ref_status
			);

			if (_it_status != -1){
				ds_list_delete(_ref_host._list_statuses,_it_status);
			}

			//--------------------//
			//PURGE INVALID REFS//
			//--------------------//
			scr_status_prune_list(_ref_host._list_statuses);
		}

		//----------------//
		//DESTROY STATUS//
		//----------------//
		instance_destroy(_ref_status);

		//-------------------//
		//REPOSITION ICONS//
		//-------------------//
		if (instance_exists(_ref_host)){
			scr_status_reposition(_ref_host);
		}

		return;
	}

	//===================//
	//ORPHANED STATUS//
	//===================//
	instance_destroy(_ref_status);
}