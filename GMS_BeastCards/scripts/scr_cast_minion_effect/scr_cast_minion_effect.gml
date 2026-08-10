//===============================================================================//
//
// SCR_CAST_MINION_EFFECT
// FUNCTION: Casts the active effect of a battle minion.
//           Determines friendly and enemy Beast lists from the minion team.
//           Executes the minion's recurring behavior.
//
//===============================================================================//

function scr_cast_minion_effect(_ref_minion){

	if (!instance_exists(_ref_minion)){
		return;
	}

	var _str_minion_name =
		_ref_minion._str_name;

	var _str_minion_team =
		_ref_minion._str_team;

	var _list_enemy;
	var _list_friendly;

	if (_str_minion_team == "PLAYER"){

		_list_friendly =
			obj_battle_player_controller._list_beasts_alive;

		_list_enemy =
			obj_battle_enemy_controller._list_beasts_alive;
	}
	else{

		_list_enemy =
			obj_battle_player_controller._list_beasts_alive;

		_list_friendly =
			obj_battle_enemy_controller._list_beasts_alive;
	}

	switch(_str_minion_name){

//-----------//
		//SPORELING//
		//-----------//
		case "SPORELING":

			if (!instance_exists(_ref_minion._ref_host)){
				break;
			}

			if (
				_ref_minion._ref_host._str_list != "ALIVE" ||
				_ref_minion._ref_host._val_cur_hp <= 0
			){
				break;
			}

			//----------------------//
			//STORE CURRENT TARGET//
			//----------------------//
			var _ref_original_target =
				global.ref_target_beast;

			//--------------//
			//POISON HOST//
			//--------------//
			global.ref_target_beast =
				_ref_minion._ref_host;

			repeat (_ref_minion._val_magnitude){
				scr_apply_dot_status("POISON");
			}

			//----------------//
			//RESTORE TARGET//
			//----------------//
			global.ref_target_beast =
				_ref_original_target;

			//-----------//
			//PLAY SOUND//
			//-----------//
			audio_play_sound(snd_debuff,0,false);

		break;

		//--------//
		//SERPENT//
		//--------//
		case "SERPENT":

			if (ds_list_size(_list_enemy) <= 0){
				break;
			}

			//-----------------//
			//GET RANDOM ENEMY//
			//-----------------//
			var _ref_target = ds_list_find_value(
				_list_enemy,
				irandom(ds_list_size(_list_enemy) - 1)
			);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------------//
			//STORE CURRENT TARGET//
			//----------------------//
			var _ref_original_target = global.ref_target_beast;

			//-------------//
			//APPLY VENOM//
			//-------------//
			global.ref_target_beast = _ref_target;

			repeat (_ref_minion._val_magnitude){
				scr_apply_dot_status("VENOM");
			}

			//----------------//
			//RESTORE TARGET//
			//----------------//
			global.ref_target_beast = _ref_original_target;

			//-----------//
			//PLAY SOUND//
			//-----------//
			audio_play_sound(snd_debuff,0,false);

		break;

		//--------------//
		//DORMANT SEED//
		//--------------//
		case "DORMANT SEED":

			_ref_minion._ct_age++;

			if (_ref_minion._ct_age >= 2){
				scr_hatch_dormant_seed(_ref_minion);
			}

		break;

		//----------//
		//THORNLING//
		//----------//
		case "THORNLING":

			if (ds_list_size(_list_enemy) <= 0){
				break;
			}

			//-----------------//
			//GET RANDOM ENEMY//
			//-----------------//
			var _ref_target = ds_list_find_value(
				_list_enemy,
				irandom(ds_list_size(_list_enemy) - 1)
			);

			if (!instance_exists(_ref_target)){
				break;
			}

			//----------------//
			//CALCULATE DAMAGE//
			//----------------//
			var _val_damage =
				_ref_minion._val_magnitude *
				2;

			//------------//
			//DEAL DAMAGE//
			//------------//
			scr_damage_target_minion(_val_damage,_ref_target);

			//-----------//
			//PLAY SOUND//
			//-----------//
			audio_play_sound(snd_attack,0,false);

		break;


		//-------------//
		//LIFE SPIRIT//
		//-------------//
		case "LIFE SPIRIT":

			if (!instance_exists(_ref_minion._ref_host)){
				break;
			}

			//-----------------//
			//CALCULATE HEALING//
			//-----------------//
			var _val_healing =
				_ref_minion._val_magnitude *
				2;

			//---------//
			//HEAL HOST//
			//---------//
			scr_heal_target(_val_healing,_ref_minion._ref_host);

			//-----------//
			//PLAY SOUND//
			//-----------//
			audio_play_sound(snd_heal,0,false);

		break;
	}
}