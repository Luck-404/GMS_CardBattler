//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_SPAWN_COMPANION_BEAST
// FUNCTION: Spawns the player's active companion Beast in the overworld.
//           Removes any existing player companion before creating a new one.
//           Uses the first Beast in the active player party.
//
// ARGUMENTS: None.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_overworld_spawn_companion_beast(){

	//================//
	//VALIDATE ROOM//
	//================//
	if (room == rm_battle){
		return;
	}

	//================//
	//CLEAR COMPANION//
	//================//
	with (obj_overworld_beast){

		if (_str_team == "PLAYER"){
			instance_destroy();
		}
	}

	//================//
	//VALIDATE SUMMON//
	//================//
	if (!global.flag_companion_summoned){
		return;
	}

	if (!instance_exists(obj_player)){
		return;
	}

	if (ds_list_size(global.list_player_party) <= 0){
		return;
	}

	//================//
	//GET COMPANION//
	//================//
	var _stct_unit = ds_list_find_value(global.list_player_party,0);

	if (_stct_unit == undefined){
		return;
	}

	//================//
	//SPAWN COMPANION//
	//================//
	var _ref_beast = instance_create_layer(
		obj_player.x,
		obj_player.y + 32,
		"ily_npcs",
		obj_overworld_beast
	);

	_ref_beast._str_team = "PLAYER";
	_ref_beast._stct_unit = _stct_unit;

	_ref_beast._spr_shadow = scr_beast_get_type_shadow(_stct_unit._str_beast_color_type);
	_ref_beast._spr_beast = _stct_unit._spr_beast;
}