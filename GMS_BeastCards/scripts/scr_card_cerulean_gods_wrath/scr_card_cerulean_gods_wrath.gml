//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_GODS_WRATH
// FUNCTION: Resolves Cerulean God's Wrath.
//           Activates an effect based on the current Cerulean Weather.
//
//===============================================================================//

function scr_card_cerulean_gods_wrath(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//CHECK WEATHER//
	//----------------//
	var _ref_rain =
		scr_status_check(
			"WEATHER: RAIN",
			global.list_statuses
		);

	var _ref_snow =
		scr_status_check(
			"WEATHER: SNOW",
			global.list_statuses
		);

	var _ref_storming =
		scr_status_check(
			"WEATHER: STORMING",
			global.list_statuses
		);

	//----------------//
	//GET TEAM LISTS//
	//----------------//
	var _list_allies =
		undefined;

	var _list_enemies =
		undefined;

	if (_ref_caster._str_team == "PLAYER"){

		_list_allies =
			obj_battle_player_controller._list_beasts_alive;

		_list_enemies =
			obj_battle_enemy_controller._list_beasts_alive;
	}
	else{

		_list_allies =
			obj_battle_enemy_controller._list_beasts_alive;

		_list_enemies =
			obj_battle_player_controller._list_beasts_alive;
	}

	//========//
	//RAIN//
	//========//
	if (_ref_rain != -1){

		for (
			var _it_beast = 0;
			_it_beast < ds_list_size(_list_allies);
			_it_beast++
		){

			var _ref_beast =
				ds_list_find_value(
					_list_allies,
					_it_beast
				);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			if (_ref_beast._val_cur_hp <= 0){
				continue;
			}

			scr_battle_heal_target(
				8,
				_ref_beast
			);
		}

		return;
	}

	//========//
	//SNOW//
	//========//
	if (_ref_snow != -1){

		//----------------//
		//ARMOR ALL ALLIES//
		//----------------//
		for (
			var _it_beast = 0;
			_it_beast < ds_list_size(_list_allies);
			_it_beast++
		){

			var _ref_beast =
				ds_list_find_value(
					_list_allies,
					_it_beast
				);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			if (_ref_beast._val_cur_hp <= 0){
				continue;
			}

			scr_battle_armor_target(
				15,
				_ref_beast
			);
		}

		return;
	}

	//===========//
	//STORMING//
	//===========//
	if (_ref_storming != -1){

		for (
			var _it_beast = 0;
			_it_beast < ds_list_size(_list_enemies);
			_it_beast++
		){

			var _ref_beast =
				ds_list_find_value(
					_list_enemies,
					_it_beast
				);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			if (_ref_beast._val_cur_hp <= 0){
				continue;
			}

			scr_battle_damage_target(
				8,
				_ref_beast
			);
			
			scr_battle_vfx(
				_ref_beast,
				spr_battle_vfx_event_storming_lightning_strike,
				undefined,
				undefined,
				0,
				0,
				1,
				0,
				snd_battle_weather_storming_lightning_strike
			);			
		}

		return;
	}

	//=====================//
	//NO CERULEAN WEATHER//
	//=====================//

	//----------------------//
	//STORE ORIGINAL TARGET//
	//----------------------//
	var _ref_original_target =
		global.ref_target_beast;

	global.ref_target_beast =
		_ref_caster;

	//----------------------//
	//DIVINE PROTECTION +1//
	//----------------------//
	scr_apply_buff_status(
		"DIVINE_PROTECTION",
		1
	);

	//-----------------------//
	//RANDOM CERULEAN MINION//
	//-----------------------//
	var _arr_cerulean_minions = [
		"TENTACLE",
		"ICE_WALL",
		"RIMEFROST_ELEMENTAL",
		"STORM_WISP",
		"CORAL_GUARDIAN",
		"ANCHOR_STONE",
		"ABYSSAL_HARPOON"
	];

	var _str_minion =
		_arr_cerulean_minions[
			irandom(
				array_length(_arr_cerulean_minions) - 1
			)
		];

	scr_minion_init(
		_str_minion,
		_stct_card,
		_ref_caster,
		_ref_caster
	);

	//----------------//
	//RESTORE TARGET//
	//----------------//
	global.ref_target_beast =
		_ref_original_target;
}