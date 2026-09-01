//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_PRESSURE_CRUSH
// FUNCTION: Resolves the Pressure Crush card effect.
//           Deals armor-piercing PHY damage equal to
//           20% of the target's current Armor.
//
//===============================================================================//

function scr_card_cerulean_pressure_crush(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//-----------------------//
	//CALCULATE ARMOR DAMAGE//
	//-----------------------//
	var _val_damage =
		_ref_target._val_armor *
		0.20;

	//----------------------//
	//DEAL PIERCING DAMAGE//
	//----------------------//
	if (_val_damage > 0){

		scr_damage_target_armor_pierce(
			_val_damage,
			_ref_target
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