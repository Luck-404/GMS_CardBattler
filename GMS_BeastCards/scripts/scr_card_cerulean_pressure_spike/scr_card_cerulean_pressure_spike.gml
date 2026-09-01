//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_PRESSURE_SPIKE
// FUNCTION: Resolves the Pressure Spike card effect.
//           Deals linear magical damage to the selected target.
//           Deals 25% additional damage if the target has no Armor.
//
//===============================================================================//

function scr_card_cerulean_pressure_spike(
	_stct_card,
	_ref_caster,
	_ref_target
){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//----------------//
	//GET BASE DAMAGE//
	//----------------//
	var _val_damage =
		_stct_card._val_card_magnitude;

	//---------------------//
	//CHECK TARGET'S ARMOR//
	//---------------------//
	if (_ref_target._val_armor <= 0){

		_val_damage *= 1.25;
	}

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(
		_val_damage,
		_ref_target
	);

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