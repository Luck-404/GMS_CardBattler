//===============================================================================//
//
// SCRIPT: SCR_STATUS_STOP_PERSISTENT_AUDIO
// FUNCTION: Stops looping ambience owned by a battle status.
//           Clears the stored audio instance reference.
//
//===============================================================================//

function scr_status_stop_persistent_audio(_ref_status){

	//-----------------//
	//VALIDATE STATUS//
	//-----------------//
	if (!instance_exists(_ref_status)){
		return false;
	}

	//------------------//
	//NO ACTIVE AMBIENCE//
	//------------------//
	if (_ref_status._val_persistent_audio == -1){
		return false;
	}

	//-----------//
	//STOP AUDIO//
	//-----------//
	audio_stop_sound(
		_ref_status._val_persistent_audio
	);

	_ref_status._val_persistent_audio =
		-1;

	return true;
}