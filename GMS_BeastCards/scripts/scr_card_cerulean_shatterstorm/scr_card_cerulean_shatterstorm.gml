//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SHATTERSTORM
// FUNCTION: Resolves Shatterstorm.
//           Deals linear PHY damage to every living enemy Beast.
//           SHATTERS each surviving target.
//           Applies 1 Bleed to each surviving target.
//
//===============================================================================//

function scr_card_cerulean_shatterstorm(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//GET ENEMY TEAM//
	//----------------//
	var _list_enemies =
		undefined;

	if (_ref_caster._str_team == "PLAYER"){

		_list_enemies =
			obj_battle_enemy_controller._list_beasts_alive;
	}
	else{

		_list_enemies =
			obj_battle_player_controller._list_beasts_alive;
	}

	if (_list_enemies == undefined){
		return;
	}

	//----------------//
	//COPY TARGETS//
	//----------------//
	var _arr_targets =
		[];

	for (
		var _it_target = 0;
		_it_target < ds_list_size(_list_enemies);
		_it_target++
	){

		var _ref_hit_target =
			ds_list_find_value(
				_list_enemies,
				_it_target
			);

		if (instance_exists(_ref_hit_target)){

			array_push(
				_arr_targets,
				_ref_hit_target
			);
		}
	}

	//----------------------//
	//STORE ORIGINAL TARGET//
	//----------------------//
	var _ref_original_target =
		global.ref_target_beast;

	//----------------//
	//RESOLVE TARGETS//
	//----------------//
	for (
		var _it_target = 0;
		_it_target < array_length(_arr_targets);
		_it_target++
	){

		var _ref_hit_target =
			_arr_targets[_it_target];

		if (!instance_exists(_ref_hit_target)){
			continue;
		}

		if (_ref_hit_target._val_cur_hp <= 0){
			continue;
		}

		global.ref_target_beast =
			_ref_hit_target;

		//------------//
		//DEAL DAMAGE//
		//------------//
		scr_battle_damage_target(
			_stct_card._val_card_magnitude,
			_ref_hit_target
		);

		if (
			!instance_exists(_ref_hit_target) ||
			_ref_hit_target._val_cur_hp <= 0
		){
			continue;
		}

		//---------//
		//SHATTER//
		//---------//
		scr_trigger_shatter(
			_ref_hit_target
		);

		if (
			!instance_exists(_ref_hit_target) ||
			_ref_hit_target._val_cur_hp <= 0
		){
			continue;
		}

		//-------------//
		//APPLY BLEED//
		//-------------//
		global.ref_target_beast =
			_ref_hit_target;

		scr_status_apply_dot(
			"BLEED"
		);
	}

	//----------------//
	//RESTORE TARGET//
	//----------------//
	global.ref_target_beast =
		_ref_original_target;
}