//===============================================================================//
//
// SCRIPT: SCR_STATUS_START_PERSISTENT_AUDIO
// FUNCTION: Starts looping ambience owned by a battle Status.
//           Stops any previously owned persistent audio before starting the
//           replacement and stores the new audio instance for Cleanup.
//
// INPUTS:   _ref_status - Status instance that owns the persistent audio.
//           _snd_audio  - Looping sound asset to play.
//           _val_gain   - Playback gain from 0 to 1.
//
//===============================================================================//

function scr_status_start_persistent_audio(_ref_status,_snd_audio,_val_gain=0.25){

	//-----------------//
	//VALIDATE STATUS//
	//-----------------//
	if (!instance_exists(_ref_status)){
		return -1;
	}

	//----------------//
	//VALIDATE AUDIO//
	//----------------//
	if (_snd_audio == undefined){
		return -1;
	}

	//-------------------//
	//STOP EXISTING AUDIO//
	//-------------------//
	if (_ref_status._val_persistent_audio != -1){

		audio_stop_sound(_ref_status._val_persistent_audio);

		_ref_status._val_persistent_audio = -1;
	}

	//-------------------//
	//START LOOPING AUDIO//
	//-------------------//
	var _val_audio_instance = audio_play_sound(
		_snd_audio,
		0,
		true
	);

	if (_val_audio_instance == -1){
		return -1;
	}

	//----------//
	//SET GAIN//
	//----------//
	var _val_audio_gain = clamp(_val_gain,0,1);

	audio_sound_gain(
		_val_audio_instance,
		_val_audio_gain,
		0
	);

	//----------------//
	//STORE OWNERSHIP//
	//----------------//
	_ref_status._val_persistent_audio = _val_audio_instance;

	return _val_audio_instance;
}