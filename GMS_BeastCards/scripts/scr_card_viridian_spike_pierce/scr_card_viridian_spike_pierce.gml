//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SPIKE_PIERCE
// FUNCTION: Resolves the Spike Pierce card effect.
//           Deals armor-piercing physical damage to the selected target.
//           Damages Overhealth and HP without interacting with Armor.
//
//===============================================================================//

function scr_card_viridian_spike_pierce(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//DEAL PIERCING DAMAGE//
	//----------------------//
	scr_damage_target_armor_pierce(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}