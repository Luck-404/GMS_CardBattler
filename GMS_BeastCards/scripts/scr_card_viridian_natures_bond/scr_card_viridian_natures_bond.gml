//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURES_BOND
// FUNCTION: Resolves Nature's Bond.
//           Applies one stack of Nature's Bond for 5 rounds.
//           Heals the caster for 5 HP.
//           Healing triggers the newly applied Nature's Bond stack.
//
//===============================================================================//
function scr_card_viridian_natures_bond(_stct_card,_ref_caster,_ref_target){

	//-------------------//
	//APPLY NATURE'S BOND//
	//-------------------//
	global.ref_target_beast = _ref_caster;

	scr_apply_buff_status(
		"NATURES_BOND",
		2,
		5
	);

	//-----------//
	//HEAL CASTER//
	//-----------//
	scr_heal_target(
		_stct_card._val_card_magnitude,
		_ref_caster
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_heal,0,false);
}