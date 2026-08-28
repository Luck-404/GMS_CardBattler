//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_HONEYED_SCENT
// FUNCTION: Resolves the Honeyed Scent card effect.
//           Applies an encounter-long Team Aura to the caster.
//           Allied Attack casts summon Wasp Drones while the Aura remains active.
//
//===============================================================================//
function scr_card_viridian_honeyed_scent(_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_caster)){
		return;
	}

	//----------------------//
	//STORE CURRENT TARGET//
	//----------------------//
	var _ref_original_target = global.ref_target_beast;

	//------------//
	//APPLY AURA//
	//------------//
	global.ref_target_beast = _ref_caster;

	scr_apply_aura_status("HONEYED_SCENT",_stct_card._val_card_magnitude);

	//----------------//
	//RESTORE TARGET//
	//----------------//
	global.ref_target_beast = _ref_original_target;

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}