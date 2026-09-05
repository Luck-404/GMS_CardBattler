//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_DEEPFLOW_WHISPERSONG
// FUNCTION: Resolves Deepflow Whispersong.
//           Performs 10 random Tentacle summon/growth attempts across
//           the selected team.
//
//===============================================================================//

function scr_card_cerulean_deepflow_whispersong(
	_stct_card,
	_ref_caster,
	_ref_target
){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	//-------------------//
	//GET SELECTED TEAM//
	//-------------------//
	var _list_team;

	if (_ref_target._str_team == "PLAYER"){

		_list_team =
			obj_battle_player_controller
				._list_beasts_alive;
	}
	else{

		_list_team =
			obj_battle_enemy_controller
				._list_beasts_alive;
	}

	//====================//
	//10 TENTACLE ATTEMPTS//
	//====================//
	repeat (_stct_card._val_card_magnitude){

		var _arr_valid_hosts = [];

		//--------------------//
		//BUILD VALID HOSTS//
		//--------------------//
		for (
			var _it_beast = 0;
			_it_beast < ds_list_size(_list_team);
			_it_beast++
		){

			var _ref_beast =
				ds_list_find_value(
					_list_team,
					_it_beast
				);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			if (
				_ref_beast._str_list != "ALIVE" ||
				_ref_beast._val_cur_hp <= 0
			){
				continue;
			}

			//----------------//
			//HAS OPEN SLOT//
			//----------------//
			if (scr_has_open_minion_slot(_ref_beast)){

				array_push(
					_arr_valid_hosts,
					_ref_beast
				);

				continue;
			}

			//----------------------//
			//FULL — CHECK TENTACLE//
			//----------------------//
			var _ref_tentacle =
				scr_get_oldest_minion_by_name(
					_ref_beast,
					"TENTACLE"
				);

			if (instance_exists(_ref_tentacle)){

				array_push(
					_arr_valid_hosts,
					_ref_beast
				);
			}
		}

		//----------------//
		//NO VALID HOSTS//
		//----------------//
		if (array_length(_arr_valid_hosts) <= 0){
			break;
		}

		//-------------------//
		//ROLL RANDOM HOST//
		//-------------------//
		var _ref_host =
			_arr_valid_hosts[
				irandom(
					array_length(_arr_valid_hosts) - 1
				)
			];

		//==================//
		//OPEN SLOT — SUMMON//
		//==================//
		if (scr_has_open_minion_slot(_ref_host)){

			scr_init_minion(
				"TENTACLE",
				_stct_card,
				_ref_caster,
				_ref_host
			);
		}

		//=====================//
		//FULL SLOTS — GROW//
		//=====================//
		else{

			var _arr_tentacles = [];

			//-------------------//
			//COLLECT TENTACLES//
			//-------------------//
			for (
				var _it_minion = 0;
				_it_minion < ds_list_size(_ref_host._list_minions);
				_it_minion++
			){

				var _ref_minion =
					ds_list_find_value(
						_ref_host._list_minions,
						_it_minion
					);

				if (!instance_exists(_ref_minion)){
					continue;
				}

				if (_ref_minion._str_name != "TENTACLE"){
					continue;
				}

				array_push(
					_arr_tentacles,
					_ref_minion
				);
			}

			//--------------------//
			//GROW RANDOM TENTACLE//
			//--------------------//
			if (array_length(_arr_tentacles) > 0){

				var _ref_growth_target =
					_arr_tentacles[
						irandom(
							array_length(_arr_tentacles) - 1
						)
					];

				scr_grow_minion(
					_ref_growth_target,
					1
				);
			}
		}
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_buff,
		0,
		false
	);

	return true;
}