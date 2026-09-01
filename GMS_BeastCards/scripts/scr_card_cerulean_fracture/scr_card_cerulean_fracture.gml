//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FRACTURE
// FUNCTION: Resolves the Fracture card effect.
//           Deals linear MAG damage to each enemy Beast.
//           SHATTERS each surviving target.
//           Applies 1 Bleed to each surviving target.
//           Begins Snow Weather.
//
//===============================================================================//

function scr_card_cerulean_fracture(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//GET ENEMY TEAM//
	//----------------//
	var _list_targets =
		scr_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return;
	}

	//----------------//
	//COPY TARGETS//
	//----------------//
	var _arr_targets = [];

	for (
		var _it_target = 0;
		_it_target < ds_list_size(_list_targets);
		_it_target++
	){

		var _ref_hit_target =
			ds_list_find_value(
				_list_targets,
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

		//------------//
		//DEAL DAMAGE//
		//------------//
		scr_damage_target(
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
		scr_shatter_target(
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

		scr_apply_dot_status(
			"BLEED"
		);
	}

	//----------------//
	//RESTORE TARGET//
	//----------------//
	if (instance_exists(_ref_original_target)){
		global.ref_target_beast =
			_ref_original_target;
	}
	else{
		global.ref_target_beast =
			_ref_target;
	}

	//------------------//
	//BEGIN SNOW WEATHER//
	//------------------//
	scr_apply_weather_status(
		"SNOW"
	);

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_attack,
		0,
		false
	);
}