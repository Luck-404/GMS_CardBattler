//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_SPAWN_WILD_BEAST_FROM_ZONE
// FUNCTION: Rolls a visible wild Beast spawn from an encounter zone.
//           Uses the zone's encounter pool.
//           Assigns the zone as the spawned Beast's home leash.
//
// ARGUMENTS: _ref_zone is the overworld encounter zone spawning the Beast.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_overworld_spawn_wild_beast_from_zone(_ref_zone){

	//================//
	//VALIDATE ZONE//
	//================//
	if (!instance_exists(_ref_zone)){
		return;
	}

	if (!variable_instance_exists(_ref_zone,"_arr_encounter_beasts")){
		return;
	}

	if (!is_array(_ref_zone._arr_encounter_beasts) || array_length(_ref_zone._arr_encounter_beasts) <= 0){
		return;
	}

	//================//
	//ROLL SPAWN//
	//================//
	if (irandom_range(1,100) > 30){
		return;
	}

	var _stct_unit = scr_beast_get_random(_ref_zone._arr_encounter_beasts);

	if (!is_struct(_stct_unit)){
		return;
	}

	//================//
	//GET SPAWN POSITION//
	//================//
	var _val_spawn_x = _ref_zone.x + irandom_range(-96,96);
	var _val_spawn_y = _ref_zone.y + irandom_range(-96,96);

	//================//
	//CREATE WILD BEAST//
	//================//
	var _ref_beast = instance_create_layer(
		_val_spawn_x,
		_val_spawn_y,
		"ily_npcs",
		obj_overworld_beast
	);

	_ref_beast._str_team = "WILD";
	_ref_beast._stct_unit = _stct_unit;

	//================//
	//ASSIGN HOME ZONE//
	//================//
	_ref_beast._ref_home = _ref_zone;

	_ref_beast._val_home_x = _ref_zone.x;
	_ref_beast._val_home_y = _ref_zone.y;

	//================//
	//ASSIGN VISUALS//
	//================//
	_ref_beast._spr_beast = _stct_unit._spr_beast;
	_ref_beast._spr_shadow = scr_beast_get_type_shadow(_stct_unit._str_beast_color_type);
}