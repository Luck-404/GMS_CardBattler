//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SNARLING_BITE
// FUNCTION: Resolves the Snarling Bite specialty card effect.
//           Deals linear physical damage to the selected target.
//           Applies Vulnerable if the attack damages the target's HP.
//
//===============================================================================//

function scr_card_viridian_snarling_bite(_stct_card,_ref_caster,_ref_target){

	//-------------------//
	//SNAPSHOT TARGET HP//
	//-------------------//
	var _val_hp_before = _ref_target._val_cur_hp;

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//--------------------------------//
	//APPLY VULNERABLE IF HP WAS HIT//
	//--------------------------------//
		var _val_hp_after =
			_ref_target._val_cur_hp;

		if (_val_hp_after < _val_hp_before){

			global.ref_target_beast =
				_ref_target;

			scr_apply_debuff_status(
				"VULNERABLE"
			);
		}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}