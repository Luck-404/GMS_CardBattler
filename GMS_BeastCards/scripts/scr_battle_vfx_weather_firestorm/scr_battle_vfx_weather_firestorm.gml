//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_WEATHER_FIRESTORM
// FUNCTION: Plays Firestorm's start or end-of-round Weather VFX.
//           START plays at the battlefield center.
//           TICK plays on the supplied Beast.
//
// ARGUMENTS: _str_phase is "START" or "TICK".
//            _ref_target is the Beast receiving the tick VFX.
//            _flag_play_sound controls whether the SFX plays.
// RETURNS: The created VFX instance.
//
//===============================================================================//

function scr_battle_vfx_weather_firestorm(_str_phase="START",_ref_target=undefined,_flag_play_sound=true){

	//================//
	//SELECT SOUND//
	//================//
	var _snd_sfx = undefined;

	if (_flag_play_sound){
		_snd_sfx = snd_battle_burn;
	}

	//================//
	//START VFX//
	//================//
	if (_str_phase == "START"){

		return scr_battle_vfx(
			undefined,
			spr_battle_vfx_weather_firestorm_start,
			room_width * 0.5,
			room_height * 0.5,
			0,
			0,
			1,
			0,
			_snd_sfx
		);
	}

	//================//
	//TICK VFX//
	//================//
	if (_str_phase == "TICK"){

		//----------------//
		//VALIDATE TARGET//
		//----------------//
		if (!instance_exists(_ref_target)){
			return undefined;
		}

		//----------------//
		//PLAY ON BEAST//
		//----------------//
		return scr_battle_vfx(
			_ref_target,
			spr_battle_vfx_weather_firestorm_tick,
			undefined,
			undefined,
			0,
			0,
			1,
			0,
			_snd_sfx
		);
	}

	return undefined;
}