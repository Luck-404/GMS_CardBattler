//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_STATUS
// FUNCTION: Cleans up persistent presentation owned by this status.
//           Destroys persistent VFX and stops persistent looping audio.
//
//===============================================================================//

//----------------//
//PERSISTENT VFX//
//----------------//
if (instance_exists(_ref_persistent_vfx)){

	instance_destroy(
		_ref_persistent_vfx
	);
}

_ref_persistent_vfx =
	undefined;

//------------------//
//PERSISTENT AUDIO//
//------------------//
if (_val_persistent_audio != -1){

	audio_stop_sound(
		_val_persistent_audio
	);

	_val_persistent_audio =
		-1;
}