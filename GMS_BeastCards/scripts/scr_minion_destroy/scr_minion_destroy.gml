//===============================================================================//
//
// SCRIPT: SCR_MINION_DESTROY
// FUNCTION: Removes a battle Minion for combat death, sacrifice, replacement,
//           or generic removal. Sacrifice remains a distinct removal reason.
//           Optional suppression prevents Endless Bloom replacement when a
//           caller intentionally needs the sacrificed slots to remain empty.
//
// ARGUMENTS: _ref_minion - Minion being removed.
//            _str_reason - DEATH, SACRIFICE, REPLACE, or REMOVE.
//            _ref_killer_minion - optional Minion credited for combat death.
//            _flag_suppress_endless_bloom - skip Endless Bloom replacement.
// RETURNS: True when the Minion is destroyed; otherwise false.
//
//===============================================================================//
function scr_minion_destroy(_ref_minion,_str_reason="REMOVE",_ref_killer_minion=undefined,_flag_suppress_endless_bloom=false){

	//-----------------//
	//VALIDATE MINION//
	//-----------------//
	if (!instance_exists(_ref_minion)){
		return false;
	}

	//------------------//
	//STORE MINION DATA//
	//------------------//
	var _ref_host = _ref_minion._ref_host;
	var _str_team = _ref_minion._str_team;

	var _str_minion_name = _ref_minion._str_name;

	var _val_minion_hp = _ref_minion._val_cur_hp;
	var _val_minion_max_hp = _ref_minion._val_max_hp;
	var _val_minion_magnitude = _ref_minion._val_magnitude;

	//----------------//
	//STORE POSITION//
	//----------------//
	var _val_minion_x = _ref_minion.x;
	var _val_minion_y = _ref_minion.y;

	//----------------//
	//MINION DEATH VFX//
	//----------------//
	if (_str_reason == "DEATH"){

		scr_battle_vfx(
			undefined,
			spr_battle_vfx_minion_death,
			_val_minion_x,
			_val_minion_y,
			0,
			0,
			1,
			0,
			snd_battle_minion_death
		);
	}

	//------------------//
	//MINION EXPEND VFX//
	//------------------//
	if (_str_reason == "SACRIFICE"){

		scr_battle_vfx_expend(
			undefined,
			_val_minion_x,
			_val_minion_y
		);
	}

	//-----------------------//
	//SPECIAL DEATH EFFECTS//
	//-----------------------//
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

	//---------------------//
	//CHECK ENDLESS BLOOM//
	//---------------------//
	var _flag_endless_bloom = false;

	var _val_hp_bonus = 0;
	var _val_magnitude_bonus = 0;

	if (
		!_flag_suppress_endless_bloom &&
		(
			_str_reason == "DEATH" ||
			_str_reason == "SACRIFICE"
		) &&
		instance_exists(_ref_host) &&
		_ref_host._str_list == "ALIVE" &&
		_ref_host._val_cur_hp > 0
	){

		var _ref_endless_bloom = scr_status_get_endless_bloom(_str_team);

		if (_ref_endless_bloom != -1){

			_flag_endless_bloom = true;

			//----------------//
			//GET BASE MAX HP//
			//----------------//
			var _val_base_max_hp = _ref_minion._val_max_hp;

			if (variable_instance_exists(_ref_minion,"_val_base_max_hp")){
				_val_base_max_hp = _ref_minion._val_base_max_hp;
			}

			//-------------------//
			//GET BASE MAGNITUDE//
			//-------------------//
			var _val_base_magnitude = _ref_minion._val_magnitude;

			if (variable_instance_exists(_ref_minion,"_val_base_magnitude")){
				_val_base_magnitude = _ref_minion._val_base_magnitude;
			}

			//-------------------//
			//CALCULATE HP BONUS//
			//-------------------//
			_val_hp_bonus =
				max(
					0,
					_ref_minion._val_max_hp -
					_val_base_max_hp
				);

			//--------------------------//
			//CALCULATE MAGNITUDE BONUS//
			//--------------------------//
			_val_magnitude_bonus =
				max(
					0,
					_ref_minion._val_magnitude -
					_val_base_magnitude
				);
		}
	}

	//==============================//
	//REMOVE MINION-SOURCED STATUSES//
	//==============================//
	scr_status_remove_minion_sourced(_ref_minion);

	//----------------------//
	//REMOVE FROM HOST LIST//
	//----------------------//
	if (
		instance_exists(_ref_host) &&
		ds_exists(_ref_host._list_minions,ds_type_list)
	){

		var _it_minion = ds_list_find_index(
			_ref_host._list_minions,
			_ref_minion
		);

		if (_it_minion != -1){
			ds_list_delete(_ref_host._list_minions,_it_minion);
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
		scr_status_apply_dot("POISON", _ref_host, undefined, false);


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

		//-------------//
		//APPLY SLEEP//
		//-------------//
		scr_status_apply_cc("SLEEP", _ref_host, 3, true);

	}

	//================//
	//DEBUG REMOVAL//
	//================//
	var _str_host_name = "UNKNOWN";

	if (
		instance_exists(_ref_host) &&
		is_struct(_ref_host._ref_unit)
	){
		_str_host_name = string_upper(_ref_host._ref_unit._str_beast_name);
	}

	var _str_removal_action = "REMOVED";

	switch (_str_reason){

		case "DEATH":
			_str_removal_action = "DIED";
		break;

		case "SACRIFICE":
			_str_removal_action = "WAS SACRIFICED";
		break;

		case "REPLACE":
			_str_removal_action = "WAS REPLACED";
		break;
	}

	scr_debug_log(
		"MINIONS",
		"REMOVE",
		_ref_minion,
		string_upper(_str_team) + " " +
		string_upper(_str_minion_name) +
		" " + _str_removal_action +
		" | HOST: " + _str_host_name +
		" | REASON: " + string_upper(_str_reason) +
		" | HP: " +
		string(_val_minion_hp) +
		"/" +
		string(_val_minion_max_hp) +
		" | MAGNITUDE: " +
		string(_val_minion_magnitude),
		"BATTLE",
		"SCR_MINION_DESTROY"
	);

	//======================//
	//CINDERLING DEATH BURN//
	//======================//
	if (
		_ref_minion._str_name == "CINDERLING" &&
		_str_reason == "DEATH"
	){

		scr_minion_cinderling_death(
			_ref_minion,
			_ref_killer_minion
		);
	}
	
	//---------------//
	//DESTROY MINION//
	//---------------//
	instance_destroy(_ref_minion);

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
		var _ref_seed = scr_minion_init(
			"DORMANT_SEED",
			undefined,
			undefined,
			_ref_host
		);

		if (instance_exists(_ref_seed)){

			//-------------------//
			//TRANSFER HP BONUS//
			//-------------------//
			_ref_seed._val_max_hp += _val_hp_bonus;
			_ref_seed._val_cur_hp += _val_hp_bonus;

			//--------------------------//
			//TRANSFER MAGNITUDE BONUS//
			//--------------------------//
			_ref_seed._val_magnitude += _val_magnitude_bonus;

			_ref_seed._val_cur_hp =
				min(
					_ref_seed._val_cur_hp,
					_ref_seed._val_max_hp
				);

			//----------//
			//FEEDBACK//
			//----------//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"ENDLESS BLOOM",
				undefined,
				c_green,
				_ref_seed.x,
				_ref_seed.y - 24
			);
		}
	}

	//--------------------------//
	//REFRESH MINION-COUNT BUFFS//
	//--------------------------//
	if (instance_exists(_ref_host)){

		scr_minion_trigger_count_buffs(_ref_host);
		scr_minion_reposition(_ref_host);
		scr_status_reposition(_ref_host);
	}

	return true;
}