//===============================================================================//
//
// SCRIPT: scr_battle_play_heal_vfx
// FUNCTION: Plays shared healing VFX/SFX on a battle Beast.
//           Plays Heal SFX once per card cast while allowing every healed
//           target to receive the Heal VFX.
//
//===============================================================================//

function scr_battle_play_heal_vfx(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return undefined;
	}

	//----------------//
	//SELECT HEAL SFX//
	//----------------//
	var _snd_sfx =
		snd_battle_heal;

	//------------------------//
	//ONLY PLAY ONCE PER CAST//
	//------------------------//
	if (instance_exists(global.ref_cast_card)){

		if (global.ref_cast_card._flag_heal_sfx_played){

			_snd_sfx =
				undefined;
		}
		else{

			global.ref_cast_card._flag_heal_sfx_played =
				true;
		}
	}

	//----------------//
	//PLAY HEAL VFX//
	//----------------//
	return scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_heal,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		_snd_sfx
	);
}