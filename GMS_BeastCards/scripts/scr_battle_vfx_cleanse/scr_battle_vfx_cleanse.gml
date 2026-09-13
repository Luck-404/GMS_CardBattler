//===============================================================================//
//
// SCRIPT: SCR_BATTLE_VFX_CLEANSE
// FUNCTION: Plays shared Cleanse VFX/SFX on a battle Beast.
//           Plays the Cleanse SFX once per card cast while allowing every
//           cleansed target to receive the Cleanse VFX.
//
// INPUT:    _ref_target - Battle Beast receiving the Cleanse VFX.
//
//===============================================================================//

function scr_battle_vfx_cleanse(_ref_target){

	//-----------------//
	//VALIDATE TARGET//
	//-----------------//
	if (!instance_exists(_ref_target)){
		return undefined;
	}

	//-------------------//
	//SELECT CLEANSE SFX//
	//-------------------//
	var _snd_sfx = snd_battle_cleanse;

	//------------------------//
	//ONLY PLAY ONCE PER CAST//
	//------------------------//
	if (instance_exists(global.ref_cast_card)){

		if (global.ref_cast_card._flag_cleanse_sfx_played){
			_snd_sfx = undefined;
		}
		else{
			global.ref_cast_card._flag_cleanse_sfx_played = true;
		}
	}

	//-----------------//
	//PLAY CLEANSE VFX//
	//-----------------//
	return scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_cleanse,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		_snd_sfx
	);
}