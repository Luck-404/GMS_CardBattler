//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ARMOR_TRANSFER
// FUNCTION: Resolves Armor Transfer.
//           Transfers all current Armor from the caster to the selected
//           allied Beast.
//
//===============================================================================//

function scr_card_cerulean_armor_transfer(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	if (_ref_caster == _ref_target){
		return;
	}

	//------------------//
	//GET CASTER ARMOR//
	//------------------//
	var _val_armor_transfer =
		max(
			0,
			_ref_caster._val_armor
		);

	if (_val_armor_transfer <= 0){

		audio_play_sound(
			snd_battle_sfx_armor,
			0,
			false
		);

		return;
	}

	//----------------//
	//REMOVE ARMOR//
	//----------------//
	_ref_caster._val_armor = 0;

	//----------------//
	//TRANSFER ARMOR//
	//----------------//
	_ref_target._val_armor +=
		_val_armor_transfer;

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_battle_sfx_armor,
		0,
		false
	);
}