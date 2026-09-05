//===============================================================================//
//
// CLEANUP: OBJ_TREASURE_SPARKLE
// FUNCTION: Stops any looping treasure proximity sound owned by this sparkle.
//           Prevents nearby audio from continuing after leaving the room.
//
//===============================================================================//

//-------------------//
//STOP NEARBY SOUND//
//-------------------//
if (_val_nearby_sound_instance != -1){

	if (audio_is_playing(_val_nearby_sound_instance)){
		audio_stop_sound(_val_nearby_sound_instance);
	}

	_val_nearby_sound_instance = -1;
}