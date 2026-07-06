//===============================================================================//
//
// SCRIPT: SCR_SPAWN_WORLD_BEAST_FROM_ZONE
// FUNCTION: Rolls a visible wild beast spawn from a battle zone.
//           Uses the zone encounter pool.
//           Leashes the wild beast to the battle zone host.
//
//===============================================================================//

function scr_spawn_world_beast_from_zone(_ref_zone){

	if (!instance_exists(_ref_zone)){
		exit;
	}

	if (!variable_instance_exists(_ref_zone,"_arr_encounter_beasts")){
		exit;
	}

	if (irandom_range(1,100) > 20){
		exit;
	}

	var _stct_unit = scr_get_random_beast(_ref_zone._arr_encounter_beasts);

	if (_stct_unit == undefined){
		exit;
	}

	var _val_spawn_x = _ref_zone.x + irandom_range(-96,96);
	var _val_spawn_y = _ref_zone.y + irandom_range(-96,96);

	var _ref_beast = instance_create_layer(_val_spawn_x,_val_spawn_y,"ily_npcs",obj_beast_world);

	_ref_beast._str_team = "WILD";
	_ref_beast._ref_unit = _stct_unit;
	_ref_beast._ref_home = _ref_zone;

	_ref_beast._val_home_x = _ref_zone.x;
	_ref_beast._val_home_y = _ref_zone.y;

	_ref_beast._spr_beast = _stct_unit._spr_beast;
}