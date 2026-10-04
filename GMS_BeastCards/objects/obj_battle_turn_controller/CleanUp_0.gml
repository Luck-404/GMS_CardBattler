//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_TURN_CONTROLLER
// FUNCTION: Releases battle-turn-controller-owned temporary data structures.
//           Safely handles duplicate controllers destroyed before full Create
//           initialization has completed.
//
//===============================================================================//

#region ENTRY TRIGGERS

//---------------------------//
//DESTROY ENTRY TRIGGER QUEUE//
//---------------------------//
if (
	variable_instance_exists(id,"_list_entry_triggers") &&
	_list_entry_triggers != undefined &&
	ds_exists(_list_entry_triggers,ds_type_list)
){
	ds_list_destroy(_list_entry_triggers);
	_list_entry_triggers = undefined;
}

#endregion