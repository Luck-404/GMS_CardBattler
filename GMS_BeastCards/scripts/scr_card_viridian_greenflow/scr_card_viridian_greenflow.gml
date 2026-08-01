//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_GREENFLOW
// FUNCTION: Resolves the Greenflow card effect.
//           Fires one damage bolt for each minion controlled by the caster.
//           Each bolt deals 5 neutral damage to the selected target.
//
//===============================================================================//

function scr_card_viridian_greenflow(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//COUNT CASTER'S MINIONS//
	//----------------------//
	var _ct_bolts = ds_list_size(_ref_caster._list_minions);

	//------------------//
	//NO MINIONS - FAIL//
	//------------------//
	if (_ct_bolts <= 0){

		scr_spawn_popup_scrolling(
			"TEXT",
			"FAILED: NO MINIONS",
			undefined,
			c_red,
			_ref_caster.x,
			_ref_caster.y - 48
		);

		return;
	}

	//------------//
	//FIRE BOLTS//
	//------------//
	repeat (_ct_bolts){

		scr_damage_target(
			_stct_card._val_card_magnitude,
			_ref_target
		);

		//----------------//
		//PLAY ANIMATION//
		//----------------//
	}

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}