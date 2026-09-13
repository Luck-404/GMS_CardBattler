//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_STATUS
// FUNCTION: Cleans up persistent presentation owned by this Status.
//           Destroys persistent VFX and stops persistent looping audio.
//
//===============================================================================//

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