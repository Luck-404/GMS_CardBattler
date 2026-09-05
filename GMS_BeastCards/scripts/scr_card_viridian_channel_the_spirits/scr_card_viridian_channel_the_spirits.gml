//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_CHANNEL_THE_SPIRITS
// FUNCTION: Resolves the Channel the Spirits Archetype card.
//           Deals twelve separate instances of Linear MAG damage.
//           Each hit independently selects a random living enemy Beast.
//
//===============================================================================//

function scr_card_viridian_channel_the_spirits(_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_caster)){
		return;
	}

	//-------------------//
	//GET OPPOSING TEAM//
	//-------------------//
	var _list_enemy;

	if (_ref_caster._str_team == "PLAYER"){

		_list_enemy =
			obj_battle_enemy_controller._list_beasts_alive;
	}
	else{

		_list_enemy =
			obj_battle_player_controller._list_beasts_alive;
	}

	if (_list_enemy == undefined){
		return;
	}

	//-------------------//
	//CHANNEL 12 SPIRITS//
	//-------------------//
	repeat (12){

		//----------------------//
		//BUILD LIVING TARGETS//
		//----------------------//
		var _arr_targets = [];

		for (
			var _it_enemy = 0;
			_it_enemy < ds_list_size(_list_enemy);
			_it_enemy++
		){

			var _ref_enemy =
				ds_list_find_value(
					_list_enemy,
					_it_enemy
				);

			if (!instance_exists(_ref_enemy)){
				continue;
			}

			if (
				_ref_enemy._str_list != "ALIVE" ||
				_ref_enemy._val_cur_hp <= 0
			){
				continue;
			}

			array_push(
				_arr_targets,
				_ref_enemy
			);
		}

		//----------------------//
		//NO ENEMIES REMAINING//
		//----------------------//
		if (array_length(_arr_targets) <= 0){
			break;
		}

		//-------------------//
		//GET RANDOM TARGET//
		//-------------------//
		var _ref_hit_target =
			_arr_targets[
				irandom(
					array_length(_arr_targets) - 1
				)
			];

		//------------//
		//DEAL DAMAGE//
		//------------//
		scr_damage_target(
			_stct_card._val_card_magnitude,
			_ref_hit_target
		);

		//----------------//
		//PLAY ANIMATION//
		//----------------//
	}

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_battle_sfx_neu_hit,
		0,
		false
	);
}