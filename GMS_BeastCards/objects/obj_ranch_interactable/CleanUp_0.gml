//===============================================================================//
//
// CLEANUP: OBJ_RANCH_INTERACTABLE
// FUNCTION: Releases the Ranch interactable's owned Beast-dummy reference list
//           when the interactable is destroyed or the Ranch room ends.
//
//===============================================================================//

#region DUMMY LIST

//------------------//
//DESTROY DUMMY LIST//
//------------------//
if (ds_exists(_list_ranch_dummies,ds_type_list)){
	ds_list_destroy(_list_ranch_dummies);
	_list_ranch_dummies = undefined;
}

#endregion