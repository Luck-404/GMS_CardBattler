//===============================================================================//
//
// SCRIPT: SCR_DESTROY_MINION
// FUNCTION: Removes a battle Minion.
//           Distinguishes combat death from sacrifice, replacement, and other
//           forms of removal.
//           Plays Minion Death presentation on true combat death.
//           Removes statuses sourced by the exact Minion.
//           Endless Bloom converts defeated allied Minions into Dormant Seeds
//           while preserving accumulated HP and Magnitude bonuses.
//
// REASONS:
//           "DEATH"     - Minion was defeated by damage.
//           "SACRIFICE" - Minion was intentionally sacrificed.
//           "REPLACE"   - Minion was removed because its slot was replaced.
//           "REMOVE"    - Generic removal.
//
//===============================================================================//

function scr_destroy_minion(_ref_minion,_str_reason="REMOVE"){

	//-----------------//
	//VALIDATE MINION//
	//-----------------//
	if (!instance_exists(_ref_minion)){
		return false;
	}

	//------------------//
	//STORE MINION DATA//
	//------------------//
	var _ref_host =
		_ref_minion._ref_host;

	var _str_team =
		_ref_minion._str_team;

	//----------------//
	//STORE POSITION//
	//----------------//
	var _val_minion_x =
		_ref_minion.x;

	var _val_minion_y =
		_ref_minion.y;

	//----------------//
	//MINION DEATH VFX//
	//----------------//
	if (_str_reason == "DEATH"){

		scr_battle_vfx(
			undefined,
			spr_battle_vfx_summon_death,
			_val_minion_x,
			_val_minion_y,
			0,
			0,
			1,
			0,
			snd_battle_sfx_summon_death
		);
	}

	var _flag_sporeling_poison =
	(
		_ref_minion._str_name == "SPORELING" &&
		(
			_str_reason == "DEATH" ||
			_str_reason == "REPLACE"
		)
	);

	var _flag_fungi_sleep =
	(
		_ref_minion._str_name == "FUNGI" &&
		_str_reason == "DEATH"
	);
	
	//------------------------//
	//CHECK ENDLESS BLOOM//
	//------------------------//
	var _flag_endless_bloom =
		false;

	var _val_hp_bonus =
		0;

	var _val_magnitude_bonus =
		0;

	if (
		(
			_str_reason == "DEATH" ||
			_str_reason == "SACRIFICE"
		) &&
		instance_exists(_ref_host) &&
		_ref_host._str_list == "ALIVE" &&
		_ref_host._val_cur_hp > 0
	){

		var _ref_endless_bloom =
			scr_get_endless_bloom_status(
				_str_team
			);

		if (_ref_endless_bloom != -1){

			_flag_endless_bloom =
				true;

			//------------------//
			//GET BASE MAX HP//
			//------------------//
			var _val_base_max_hp =
				_ref_minion._val_max_hp;

			if (
				variable_instance_exists(
					_ref_minion,
					"_val_base_max_hp"
				)
			){

				_val_base_max_hp =
					_ref_minion._val_base_max_hp;
			}

			//---------------------//
			//GET BASE MAGNITUDE//
			//---------------------//
			var _val_base_magnitude =
				_ref_minion._val_magnitude;

			if (
				variable_instance_exists(
					_ref_minion,
					"_val_base_magnitude"
				)
			){

				_val_base_magnitude =
					_ref_minion._val_base_magnitude;
			}

			//-----------------------//
			//CALCULATE HP BONUS//
			//-----------------------//
			_val_hp_bonus =
				max(
					0,
					_ref_minion._val_max_hp -
					_val_base_max_hp
				);

			//----------------------------//
			//CALCULATE MAGNITUDE BONUS//
			//----------------------------//
			_val_magnitude_bonus =
				max(
					0,
					_ref_minion._val_magnitude -
					_val_base_magnitude
				);
		}
	}


//================================//
//REMOVE MINION-SOURCED STATUSES//
//================================//
scr_remove_minion_sourced_statuses(
	_ref_minion
);


	//----------------------//
	//REMOVE FROM HOST LIST//
	//----------------------//
	if (instance_exists(_ref_host)){

		var _it_minion =
			ds_list_find_index(
				_ref_host._list_minions,
				_ref_minion
			);

		if (_it_minion != -1){

			ds_list_delete(
				_ref_host._list_minions,
				_it_minion
			);
		}
	}

	//========================//
	//SPORELING DEATH EFFECT//
	//========================//
	if (
		_flag_sporeling_poison &&
		instance_exists(_ref_host) &&
		_ref_host._str_list == "ALIVE" &&
		_ref_host._val_cur_hp > 0
	){

		//----------------------//
		//STORE CURRENT TARGET//
		//----------------------//
		var _ref_original_target =
			global.ref_target_beast;

		//-------------//
		//TARGET HOST//
		//-------------//
		global.ref_target_beast =
			_ref_host;

		//----------------//
		//APPLY 1 POISON//
		//----------------//
		/*
			Do not allow this Poison application to retrigger
			Plague Garden. Otherwise a replacement could recurse
			indefinitely:
		
			replace Sporeling
			→ Poison
			→ spawn Sporeling
			→ replace Sporeling
			→ Poison...
		*/
		scr_apply_dot_status(
			"POISON",
			undefined,
			false
		);

		//----------------//
		//RESTORE TARGET//
		//----------------//
		if (instance_exists(_ref_original_target)){

			global.ref_target_beast =
				_ref_original_target;
		}
		else{

			global.ref_target_beast =
				_ref_host;
		}
	}

	//------------------//
	//FUNGI DEATH SLEEP//
	//------------------//
	if (
		_flag_fungi_sleep &&
		instance_exists(_ref_host) &&
		_ref_host._str_list == "ALIVE" &&
		_ref_host._val_cur_hp > 0
	){

		var _ref_original_target =
			global.ref_target_beast;

		global.ref_target_beast =
			_ref_host;

		scr_apply_cc_status(
			"SLEEP",
			3,
			true
		);

		global.ref_target_beast =
			_ref_original_target;
	}

	//---------------//
	//DESTROY MINION//
	//---------------//
	instance_destroy(
		_ref_minion
	);


	//================//
	//ENDLESS BLOOM//
	//================//
	if (
		_flag_endless_bloom &&
		instance_exists(_ref_host) &&
		_ref_host._str_list == "ALIVE" &&
		_ref_host._val_cur_hp > 0
	){

		//-------------------//
		//CREATE DORMANT SEED//
		//-------------------//
		var _ref_seed =
			scr_init_minion(
				"DORMANT_SEED",
				undefined,
				undefined,
				_ref_host
			);

		if (instance_exists(_ref_seed)){

			//-------------------//
			//TRANSFER HP BONUS//
			//-------------------//
			_ref_seed._val_max_hp +=
				_val_hp_bonus;

			_ref_seed._val_cur_hp +=
				_val_hp_bonus;

			//--------------------------//
			//TRANSFER MAGNITUDE BONUS//
			//--------------------------//
			_ref_seed._val_magnitude +=
				_val_magnitude_bonus;

			_ref_seed._val_cur_hp =
				min(
					_ref_seed._val_cur_hp,
					_ref_seed._val_max_hp
				);

			//----------//
			//FEEDBACK//
			//----------//
			scr_spawn_popup_scrolling(
				"TEXT",
				"ENDLESS BLOOM",
				undefined,
				c_green,
				_ref_seed.x,
				_ref_seed.y - 24
			);
		}
	}


	//-------------------------//
	//REFRESH MINION COUNT BUFFS//
	//-------------------------//
	if (instance_exists(_ref_host)){

		scr_trigger_minion_count_buffs(
			_ref_host
		);

		scr_reposition_minions(
			_ref_host
		);

		scr_reposition_statuses(
			_ref_host
		);
	}

	return true;
}