//===============================================================================//
//
// SCRIPT: SCR_BATTLE_PLAY_SFX
// FUNCTION: Plays a battle SFX while suppressing near-simultaneous duplicates.
//           Prevents teamwide and mass effects from stacking identical sounds.
//           Different sounds may still play simultaneously.
//
// INPUTS:   _snd_sfx                 - Sound asset to play.
//           _val_duplicate_window_ms - Duplicate suppression window in ms.
//
//===============================================================================//

function scr_battle_play_sfx(_snd_sfx,_val_duplicate_window_ms=40){

	//----------------//
	//VALIDATE SOUND//
	//----------------//
	if (_snd_sfx == undefined){
		return -1;
	}

	_val_duplicate_window_ms =
		max(0,_val_duplicate_window_ms);

	//----------------//
	//RECENT SFX DATA//
	//----------------//
	static _stct_recent_sfx = {};

	var _str_sfx_key =
		"SFX_" +
		string(_snd_sfx);

	var _val_time_now = current_time;

	//----------------------//
	//CHECK RECENT DUPLICATE//
	//----------------------//
	if (variable_struct_exists(_stct_recent_sfx,_str_sfx_key)){

		var _val_last_time =
			variable_struct_get(
				_stct_recent_sfx,
				_str_sfx_key
			);

		if (_val_time_now - _val_last_time < _val_duplicate_window_ms){
			return -1;
		}
	}

	//----------------//
	//STORE PLAY TIME//
	//----------------//
	variable_struct_set(
		_stct_recent_sfx,
		_str_sfx_key,
		_val_time_now
	);

	//-----------//
	//PLAY SOUND//
	//-----------//
	return audio_play_sound(
		_snd_sfx,
		0,
		false
	);
}