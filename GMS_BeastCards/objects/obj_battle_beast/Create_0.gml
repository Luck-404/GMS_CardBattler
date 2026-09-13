//===============================================================================//
//
// CREATE: OBJ_BATTLE_BEAST
// FUNCTION: Initializes a battle Beast instance.
//           Stores combat state, presentation state, owned battle lists,
//           targeting checks, and object-local positioning/death helpers.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
#region VARIABLES

//----------------//
//VISUAL / IDENTITY//
//----------------//
_spr_beast = undefined;
_uid_beast = -1;

_c_beast_draw_tint = c_white;
_val_beast_draw_scale_multiplier = 1;

_snd_cry = undefined;
_snd_death = undefined;

//------------------//
//BATTLE VFX MOTION//
//------------------//
_str_vfx_motion = "NONE";

_ct_vfx_motion = 0;
_ct_vfx_motion_duration = 1;

_val_vfx_motion_intensity = 0;
_val_vfx_motion_start_x = 0;

_val_vfx_offset_x = 0;
_val_vfx_offset_y = 0;
_val_vfx_angle = 0;

//----------------//
//TEAM / POSITION//
//----------------//
_str_team = "PLAYER";
_str_list = "ALIVE";
_val_pos = -1;

//------------//
//UNIT / ITEM//
//------------//
_ref_unit = undefined;
_stct_held_item = undefined;

//--------------//
//HP / DEFENSE//
//--------------//
_val_cur_hp = 1;
_val_max_hp = 1;

_val_overhealth = 0;
_val_armor = 0;

//--------------//
//COMBAT STATS//
//--------------//
_val_crit_chance = 0;
_val_crit_damage = 25;

_val_speed_base = 150;
_val_speed_bonus = 0;

//---------------------//
//CC DURATION MODIFIERS//
//---------------------//
_val_cc_duration_bonus = 0;

//--------------------------//
//OUTGOING DAMAGE MODIFIERS//
//--------------------------//
_val_dmg_linear_bonus = 0;
_val_dmg_linear_reduction = 0;

_val_dmg_scalar_bonus = 0;
_val_dmg_scalar_reduction = 0;

//--------------------------//
//INCOMING DAMAGE MODIFIERS//
//--------------------------//
_val_dmg_taken_linear_bonus = 0;
_val_dmg_taken_linear_reduction = 0;

_val_dmg_taken_scalar_bonus = 0;
_val_dmg_taken_scalar_reduction = 0;

//-----------------//
//DODGE MODIFIERS//
//-----------------//
_val_dodge_bonus = 0;
_ct_dodge_disabled = 0;

//--------------------------//
//STATUSES / MINIONS / TRAPS//
//--------------------------//
_list_statuses = ds_list_create();

_ct_minions_max = 1;
_list_minions = ds_list_create();

_list_traps = ds_list_create();

//-------//
//CARDS//
//-------//
_list_deck = ds_list_create();
_val_hand_pos = 0;

//-------------//
//STATE FLAGS//
//-------------//
_flag_captured = false;
_flag_death_handled = false;
_flag_death_presented = false;
_flag_preview_beast = false;
_flag_corpse_consumed = false;

//---------------//
//CASTING CHECKS//
//---------------//
_flag_beast_color_check = true;
_flag_beast_archetype_check = true;
_flag_beast_class_check = true;
_flag_beast_range_check = true;
_flag_beast_able_check = true;

_flag_ignore_caster_requirements = false;

#endregion

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_battle_get_active_x
// FUNCTION: Returns an active battlefield X position by team and formation slot.
//—------------------------------------------------------------------------------//
hscr_battle_get_active_x = function(_str_team_check,_val_pos_check){

	if (_str_team_check == "PLAYER"){
		return room_width * 0.5 - 80 - (100 * _val_pos_check);
	}

	return room_width * 0.5 + 80 + (100 * _val_pos_check);
};

//—------------------------------------------------------------------------------//
// hscr_battle_get_graveyard_x
// FUNCTION: Returns a graveyard X position using active and dead formation counts.
//—------------------------------------------------------------------------------//
hscr_battle_get_graveyard_x = function(_str_team_check,_ct_alive,_val_dead_pos){

	var _val_position = _ct_alive + _val_dead_pos;

	if (_str_team_check == "PLAYER"){
		return room_width * 0.5 - 80 - (100 * _val_position);
	}

	return room_width * 0.5 + 80 + (100 * _val_position);
};

//—------------------------------------------------------------------------------//
// HSCR_BATTLE_HANDLE_DEATH
// FUNCTION: Resolves this Beast's death once HP reaches 0.
//           Allows Second Life to prevent death before finalizing.
//           Removes the exact Beast instance from the active formation,
//           moves it to the graveyard, closes formation gaps, and cleans
//           attached Minions and Statuses.
//—------------------------------------------------------------------------------//
hscr_battle_handle_death = function(){

	//------------------//
	//CHECK DEATH STATE//
	//------------------//
	if (_val_cur_hp > 0 || _flag_death_handled){
		return false;
	}

	//================//
	//GET INSTANCE REF//
	//================//
	var _ref_dead_beast = id;

	//----------------//
	//TRY SECOND LIFE//
	//----------------//
	if (scr_status_try_second_life(_ref_dead_beast)){
		return false;
	}

	//================//
	//STORE DEATH DATA//
	//================//
	var _val_death_position = _val_pos;

	var _str_beast_name = "UNKNOWN";
	var _val_beast_level = 0;

	if (is_struct(_ref_unit)){

		if (variable_struct_exists(_ref_unit,"_str_beast_name")){
			_str_beast_name = string_upper(_ref_unit._str_beast_name);
		}

		if (variable_struct_exists(_ref_unit,"_val_beast_level")){
			_val_beast_level = _ref_unit._val_beast_level;
		}
	}

	var _ct_minions_removed = 0;

	if (ds_exists(_list_minions,ds_type_list)){
		_ct_minions_removed = ds_list_size(_list_minions);
	}

	//================//
	//FINALIZE DEATH//
	//================//
	_flag_death_handled = true;
	_val_cur_hp = 0;

	//-------------------//
	//TRIGGER DEATH TRAPS//
	//-------------------//
	scr_battle_trigger_death_traps(_ref_dead_beast);

	//----------------//
	//MARK AS DEAD//
	//----------------//
	_str_list = "DEAD";

	//================//
	//DESTROY MINIONS//
	//================//
	if (ds_exists(_list_minions,ds_type_list)){

		for (var _it_minion = ds_list_size(_list_minions) - 1;_it_minion >= 0;_it_minion--){

			var _ref_minion = ds_list_find_value(
				_list_minions,
				_it_minion
			);

			if (instance_exists(_ref_minion)){
				instance_destroy(_ref_minion);
			}
		}
	}

	//================//
	//TRIGGER STATUSES//
	//================//
	if (ds_exists(_list_statuses,ds_type_list)){

		for (var _it_status = ds_list_size(_list_statuses) - 1;_it_status >= 0;_it_status--){

			var _ref_status = ds_list_find_value(
				_list_statuses,
				_it_status
			);

			if (instance_exists(_ref_status)){
				_ref_status._str_status_command = "DEATH";
			}
		}
	}

	//================//
	//GET TEAM LISTS//
	//================//
	var _list_alive = undefined;
	var _list_dead = undefined;

	if (_str_team == "PLAYER"){

		_list_alive = obj_battle_player_controller._list_beasts_alive;
		_list_dead = obj_battle_player_controller._list_beasts_graveyard;
	}
	else{

		_list_alive = obj_battle_enemy_controller._list_beasts_alive;
		_list_dead = obj_battle_enemy_controller._list_beasts_graveyard;
	}

	//================//
	//VALIDATE LISTS//
	//================//
	if (
		!ds_exists(_list_alive,ds_type_list) ||
		!ds_exists(_list_dead,ds_type_list)
	){

		scr_debug_log(
			"BATTLE",
			"DEATH",
			_ref_dead_beast,
			"DEATH LIST UPDATE FAILED" +
			" | BEAST: " + _str_beast_name +
			" | TEAM: " + string_upper(_str_team),
			"ERROR",
			"OBJ_BATTLE_BEAST:HSCR_BATTLE_HANDLE_DEATH"
		);

		return false;
	}

	//===================//
	//REMOVE FROM ACTIVE//
	//===================//
	var _it_alive = ds_list_find_index(
		_list_alive,
		_ref_dead_beast
	);

	if (_it_alive != -1){

		ds_list_delete(
			_list_alive,
			_it_alive
		);
	}
	else{

		scr_debug_log(
			"BATTLE",
			"DEATH",
			_ref_dead_beast,
			"DEAD BEAST WAS NOT FOUND IN ACTIVE LIST" +
			" | BEAST: " + _str_beast_name +
			" | TEAM: " + string_upper(_str_team),
			"ERROR",
			"OBJ_BATTLE_BEAST:HSCR_BATTLE_HANDLE_DEATH"
		);
	}

	//================//
	//ADD TO GRAVEYARD//
	//================//
	if (ds_list_find_index(_list_dead,_ref_dead_beast) == -1){

		ds_list_add(
			_list_dead,
			_ref_dead_beast
		);
	}

	//========================//
	//REFRESH ACTIVE FORMATION//
	//========================//
	scr_battle_refresh_formation(_str_team);

	//=======================//
	//REPOSITION DEAD BEASTS//
	//=======================//
	var _ct_alive = ds_list_size(_list_alive);
	var _ct_dead = ds_list_size(_list_dead);

	for (var _it_beast = 0;_it_beast < _ct_dead;_it_beast++){

		var _ref_grave_beast = ds_list_find_value(
			_list_dead,
			_it_beast
		);

		if (!instance_exists(_ref_grave_beast)){
			continue;
		}

		_ref_grave_beast._val_pos =
			_ct_alive +
			_it_beast;

		_ref_grave_beast.x = _ref_grave_beast.hscr_battle_get_graveyard_x(
			_ref_grave_beast._str_team,
			_ct_alive,
			_it_beast
		);
	}

	//================//
	//DEBUG DEATH//
	//================//
	scr_debug_log(
		"BATTLE",
		"DEATH",
		_ref_dead_beast,
		string_upper(_str_team) + " " +
		_str_beast_name +
		" (LVL " + string(_val_beast_level) + ")" +
		" DIED" +
		" | POSITION: " + string(_val_death_position) +
		" | TEAM ALIVE: " + string(_ct_alive) +
		" | GRAVEYARD: " + string(_ct_dead) +
		" | MINIONS REMOVED: " + string(_ct_minions_removed),
		"BATTLE",
		"OBJ_BATTLE_BEAST:HSCR_BATTLE_HANDLE_DEATH"
	);

	//===================//
	//DEATH PRESENTATION//
	//===================//
	if (!_flag_death_presented){

		_flag_death_presented = true;

		scr_battle_vfx(
			undefined,
			spr_battle_vfx_beast_death,
			x,
			y,
			0,
			0,
			1,
			0,
			_snd_death
		);
	}

	return true;
};

#endregion