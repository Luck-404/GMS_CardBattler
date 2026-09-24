//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_GODS_WRATH
// FUNCTION: Resolves Cerulean God's Wrath.
//           Activates an effect based on the current Cerulean Weather.
//
// ARGUMENTS: _stct_card is the Cerulean God's Wrath card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_gods_wrath(_stct_card,_ref_caster,_ref_target){

	//================//
	//CHECK WEATHER//
	//================//
	var _ref_rain = scr_status_check("WEATHER: RAIN",global.list_statuses);
	var _ref_snow = scr_status_check("WEATHER: SNOW",global.list_statuses);
	var _ref_storming = scr_status_check("WEATHER: STORMING",global.list_statuses);

	//================//
	//GET TEAM LISTS//
	//================//
	var _list_allies = undefined;
	var _list_enemies = undefined;

	if (_ref_caster._str_team == "PLAYER"){
		_list_allies = obj_battle_player_controller._list_beasts_alive;
		_list_enemies = obj_battle_enemy_controller._list_beasts_alive;
	}
	else{
		_list_allies = obj_battle_enemy_controller._list_beasts_alive;
		_list_enemies = obj_battle_player_controller._list_beasts_alive;
	}

	//================//
	//RAIN//
	//================//
	if (_ref_rain != -1){

		for (var _it_beast = 0;_it_beast < ds_list_size(_list_allies);_it_beast++){

			var _ref_beast = ds_list_find_value(_list_allies,_it_beast);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			if (_ref_beast._val_cur_hp <= 0){
				continue;
			}
			
			scr_battle_heal_target(
				"FIXED",
				8,
				_ref_beast
			);
		}

		return;
	}

	//================//
	//SNOW//
	//================//
	if (_ref_snow != -1){

		for (var _it_beast = 0;_it_beast < ds_list_size(_list_allies);_it_beast++){

			var _ref_beast = ds_list_find_value(_list_allies,_it_beast);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			if (_ref_beast._val_cur_hp <= 0){
				continue;
			}

			scr_battle_armor_target(
				"FIXED",
				15,
				_ref_beast
			);
		}

		return;
	}

	//================//
	//STORMING//
	//================//
	if (_ref_storming != -1){

		for (var _it_beast = 0;_it_beast < ds_list_size(_list_enemies);_it_beast++){

			var _ref_beast = ds_list_find_value(_list_enemies,_it_beast);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			if (_ref_beast._val_cur_hp <= 0){
				continue;
			}

			scr_battle_damage_target(
				"LINEAR",
				_ref_caster,
				_ref_beast,
				8,
				{card: _stct_card, card_instance: global.ref_cast_card}
			);

			scr_battle_vfx(
				_ref_beast,
				spr_battle_vfx_weather_storming_lightning_strike,
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
	//DIVINE PROTECTION +1//
	//----------------------//
	scr_status_apply_buff("DIVINE_PROTECTION", _ref_caster, 1);

	//-----------------------//
	//RANDOM CERULEAN MINION//
	//-----------------------//
	if (
		variable_global_exists("list_pool_cerulean_minions") &&
		ds_exists(global.list_pool_cerulean_minions,ds_type_list) &&
		ds_list_size(global.list_pool_cerulean_minions) > 0
	){

		var _it_minion = irandom(ds_list_size(global.list_pool_cerulean_minions) - 1);
		var _str_minion = ds_list_find_value(global.list_pool_cerulean_minions,_it_minion);

		scr_minion_init(
			_str_minion,
			_stct_card,
			_ref_caster,
			_ref_caster
		);
	}

}