//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_STATUS
// FUNCTION: Cleans up any persistent VFX owned by this status.
//
//===============================================================================//

if (instance_exists(_ref_persistent_vfx)){
	instance_destroy(_ref_persistent_vfx);
}

_ref_persistent_vfx = undefined;