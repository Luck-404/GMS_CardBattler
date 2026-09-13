//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_STATUS
// FUNCTION: Guarantees this Status no longer exists in its owning Status list.
//           Cleans persistent presentation owned by this Status.
//           Destroys persistent VFX and stops persistent looping audio.
//
//===============================================================================//

//================//
//GET STATUS HOST//
//================//
var _ref_cleanup_host = _ref_host;

//====================//
//REMOVE LIST REFERENCE//
//====================//

//----------------//
//GLOBAL STATUS//
//----------------//
if (_ref_cleanup_host == undefined){

	if (
		variable_global_exists("list_statuses") &&
		ds_exists(global.list_statuses,ds_type_list)
	){

		var _it_status = ds_list_find_index(
			global.list_statuses,
			id
		);

		if (_it_status != -1){
			ds_list_delete(global.list_statuses,_it_status);
		}

		scr_status_prune_list(global.list_statuses);
		scr_status_reposition(global.list_statuses);
	}
}

//------------------//
//HOST-BOUND STATUS//
//------------------//
else if (instance_exists(_ref_cleanup_host)){

	if (ds_exists(_ref_cleanup_host._list_statuses,ds_type_list)){

		var _it_status = ds_list_find_index(
			_ref_cleanup_host._list_statuses,
			id
		);

		if (_it_status != -1){
			ds_list_delete(
				_ref_cleanup_host._list_statuses,
				_it_status
			);
		}

		scr_status_prune_list(_ref_cleanup_host._list_statuses);
		scr_status_reposition(_ref_cleanup_host);
	}
}

//================//
//PERSISTENT VFX//
//================//
if (instance_exists(_ref_persistent_vfx)){
	instance_destroy(_ref_persistent_vfx);
}

_ref_persistent_vfx = undefined;

//====================//
//PERSISTENT AUDIO//
//====================//
scr_status_stop_persistent_audio(id);