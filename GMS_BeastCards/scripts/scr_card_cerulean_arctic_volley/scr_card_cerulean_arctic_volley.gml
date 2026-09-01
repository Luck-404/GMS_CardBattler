//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ARCTIC_VOLLEY
// FUNCTION: Resolves the Arctic Volley card effect.
//           Deals linear physical damage to the selected target 3 times.
//
//===============================================================================//

function scr_card_cerulean_arctic_volley(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//DEAL THREE HITS//
	//----------------//
	for (
		var _it_hit = 0;
		_it_hit < 3;
		_it_hit++
	){

		if (!instance_exists(_ref_target)){
			break;
		}

		if (_ref_target._val_cur_hp <= 0){
			break;
		}

		scr_damage_target(
			_stct_card._val_card_magnitude,
			_ref_target
		);
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_attack,
		0,
		false
	);
}