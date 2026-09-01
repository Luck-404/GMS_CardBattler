//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SHATTER_STRIKE
// FUNCTION: Resolves the Shatter Strike card effect.
//           Deals linear physical damage to the selected target.
//           If the target survives, SHATTER consumes all Frostbite
//           and deals 3 NEU damage per stack consumed.
//
//===============================================================================//

function scr_card_cerulean_shatter_strike(
	_stct_card,
	_ref_caster,
	_ref_target
){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//---------//
	//SHATTER//
	//---------//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){

		scr_shatter_target(
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