//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_OLD_GROWTH_PUMMEL
// FUNCTION: Resolves the Old Growth Pummel card effect.
//           Deals three separate physical damage hits.
//           Each hit gains +1 damage for every 5 Armor on the caster.
//
//===============================================================================//

function scr_card_viridian_old_growth_pummel(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//CALCULATE ARMOR BONUS//
	//----------------------//
	var _val_armor_bonus = floor(
		_ref_caster._val_armor / 5
	);

	var _val_damage =
		_stct_card._val_card_magnitude +
		_val_armor_bonus;

	//----------------------//
	//DEAL DAMAGE (3 HITS)//
	//----------------------//
	repeat (3){

		if (
			!instance_exists(_ref_target) ||
			_ref_target._val_cur_hp <= 0
		){
			break;
		}

		scr_damage_target(
			_val_damage,
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