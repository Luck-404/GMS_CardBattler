//===============================================================================//
//
// CLEANUP: OBJ_BATTLE_STATUS
// FUNCTION: Guarantees this Status no longer exists in any owning Status
//           registry. Cleans persistent presentation owned by this Status and
//           destroys persistent VFX / audio state.
//
//           Supports host-bound Beast Statuses, PLAYER / ENEMY Team Statuses,
//           Weather and Event.
//
//===============================================================================//

//==============================//
//OUTLEVELED BATTLE-ONLY CLEANUP//
//==============================//
if (
    _str_status_name == "OUTLEVELED" &&
    _scr_status == scr_status_buff_outleveled
){

    scr_status_buff_outleveled(
        "CLEANUP",
        self
    );
}

//===================================//
//TEMPORARY TEAM MAX MANA SAFETY ROLLBACK//
//===================================//
// Inspiration, Manavine, and Mana Spring normally return their temporary
// Maximum Mana in their DEATH callbacks. If one of those Statuses is destroyed
// through any external path, Cleanup is the final balancing safeguard.
if (
	variable_instance_exists(
		id,
		"_val_team_max_mana_bonus_applied"
	) &&
	is_real(_val_team_max_mana_bonus_applied) &&
	_val_team_max_mana_bonus_applied > 0
){

	var _val_cleanup_max_mana_bonus =
		max(
			0,
			_val_team_max_mana_bonus_applied
		);

	_val_team_max_mana_bonus_applied = 0;

	if (
		_val_cleanup_max_mana_bonus > 0 &&
		instance_exists(obj_battle_player_controller)
	){
		scr_battle_change_max_mana(
			-_val_cleanup_max_mana_bonus
		);
	}
}

//================//
//GET STATUS HOST//
//================//
var _ref_cleanup_host = _ref_host;

var _flag_host_removed = false;
var _flag_player_removed = false;
var _flag_enemy_removed = false;
var _flag_weather_removed = false;
var _flag_event_removed = false;

//====================//
//HOST-BOUND REGISTRY//
//====================//
if (
	instance_exists(_ref_cleanup_host) &&
	ds_exists(_ref_cleanup_host._list_statuses,ds_type_list)
){

	var _it_host =
		ds_list_find_index(
			_ref_cleanup_host._list_statuses,
			id
		);

	if (_it_host != -1){
		ds_list_delete(
			_ref_cleanup_host._list_statuses,
			_it_host
		);

		_flag_host_removed = true;
	}

	scr_status_prune_list(
		_ref_cleanup_host._list_statuses
	);
}

//======================//
//PLAYER TEAM REGISTRY//
//======================//
var _list_player_statuses =
	scr_status_get_team_status_list("PLAYER");

if (
	_list_player_statuses != undefined &&
	ds_exists(_list_player_statuses,ds_type_list)
){

	var _it_player =
		ds_list_find_index(
			_list_player_statuses,
			id
		);

	if (_it_player != -1){
		ds_list_delete(
			_list_player_statuses,
			_it_player
		);

		_flag_player_removed = true;
	}

	scr_status_prune_list(
		_list_player_statuses
	);
}

//=====================//
//ENEMY TEAM REGISTRY//
//=====================//
var _list_enemy_statuses =
	scr_status_get_team_status_list("ENEMY");

if (
	_list_enemy_statuses != undefined &&
	ds_exists(_list_enemy_statuses,ds_type_list)
){

	var _it_enemy =
		ds_list_find_index(
			_list_enemy_statuses,
			id
		);

	if (_it_enemy != -1){
		ds_list_delete(
			_list_enemy_statuses,
			_it_enemy
		);

		_flag_enemy_removed = true;
	}

	scr_status_prune_list(
		_list_enemy_statuses
	);
}

//====================//
//WEATHER / EVENT REFS//
//====================//
if (
	variable_global_exists("ref_status_weather") &&
	global.ref_status_weather == id
){
	global.ref_status_weather = undefined;
	_flag_weather_removed = true;
}

if (
	variable_global_exists("ref_status_event") &&
	global.ref_status_event == id
){
	global.ref_status_event = undefined;
	_flag_event_removed = true;
}

//=========================//
//REFRESH STATUS POSITIONS//
//=========================//
if (
	_flag_host_removed &&
	instance_exists(_ref_cleanup_host)
){
	scr_status_reposition(_ref_cleanup_host);
}


if (_flag_player_removed){
	scr_status_reposition("PLAYER");
}

if (_flag_enemy_removed){
	scr_status_reposition("ENEMY");
}

if (_flag_weather_removed){
	scr_status_reposition("WEATHER");
}

if (_flag_event_removed){
	scr_status_reposition("EVENT");
}

//================//
//PERSISTENT VFX//
//================//
if (instance_exists(_ref_persistent_vfx)){
	instance_destroy(_ref_persistent_vfx);
}

_ref_persistent_vfx = undefined;

//====================//
//PERSISTENT AUDIO//
//====================//
scr_status_stop_persistent_audio(id);

//===============================================================================//
//
