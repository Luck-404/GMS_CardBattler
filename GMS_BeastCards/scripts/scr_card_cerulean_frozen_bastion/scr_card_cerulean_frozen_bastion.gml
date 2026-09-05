//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROZEN_BASTION
// FUNCTION: Resolves Frozen Bastion.
//           Doubles the caster's current Armor.
//
//===============================================================================//

function scr_card_cerulean_frozen_bastion(_stct_card,_ref_caster,_ref_target){

	//-----------------//
	//GET CURRENT ARMOR//
	//-----------------//
	var _val_armor_gain =
		_ref_caster._val_armor;

	//-------------//
	//DOUBLE ARMOR//
	//-------------//
	scr_armor_target(
		_val_armor_gain,
		_ref_caster
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_armor,0,false);
}