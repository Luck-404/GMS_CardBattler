//===============================================================================//
//
// SCRIPT: SCR_BATTLE_PLAY_HEAL_VFX
// FUNCTION: Plays shared Heal VFX/SFX on a battle Beast.
//           Every healed target receives Heal VFX, while Heal SFX only plays
//           once per Card cast.
//
// INPUT:    _ref_target - Battle Beast receiving the Heal presentation.
// USES:     Current cast-Card Heal SFX state and shared battle VFX system.
//
//===============================================================================//

function scr_battle_play_heal_vfx(_ref_target){

	#region VALIDATION

	//-----------------//
	//VALIDATE TARGET//
	//-----------------//
	if (!instance_exists(_ref_target)){
		return undefined;
	}

	#endregion

	#region HEAL SOUND

	//----------------//
	//SELECT HEAL SFX//
	//----------------//
	var _snd_heal = snd_battle_heal;

	//------------------------//
	//ONLY PLAY ONCE PER CAST//
	//------------------------//
	if (instance_exists(global.ref_cast_card)){

		if (global.ref_cast_card._flag_heal_sfx_played){
			_snd_heal = undefined;
		}
		else{
			global.ref_cast_card._flag_heal_sfx_played = true;
		}
	}

	#endregion

	#region HEAL PRESENTATION

	//---------------//
	//PLAY HEAL VFX//
	//---------------//
	return scr_battle_vfx(
		_ref_target,
		spr_battle_vfx_heal,
		undefined,
		undefined,
		0,
		0,
		1,
		0,
		_snd_heal
	);

	#endregion
}