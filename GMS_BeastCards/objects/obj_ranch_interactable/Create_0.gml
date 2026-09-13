//===============================================================================//
//
// CREATE: OBJ_RANCH_INTERACTABLE
// FUNCTION: Initializes the Ranch interactable.
//           Stores Ranch Beast dummy references and interaction state.
//           Defines helpers for spawning and destroying Ranch Beast dummies.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
depth = 1;

_flag_spawned = false;
_flag_triggered = false;
_ct_cooldown = 10;

_list_ranch_dummies = ds_list_create();

//================//
//INIT//
//================//

//================//
//METHODS//
//================//

//-------------------------------------------------------------------------------//
// HSCR_RANCH_SPAWN_BEAST_DUMMY
// FUNCTION: Spawns a Ranch Beast dummy within the Ranch bounds.
//           Applies Beast sprite, shadow, sounds, UID, and resting state.
//
// ARGUMENTS: _stct_unit is the Beast struct represented by the dummy.
// RETURNS: The created Ranch Beast dummy instance, or undefined on failure.
//-------------------------------------------------------------------------------//
function hscr_ranch_spawn_beast_dummy(_stct_unit){

	if (!is_struct(_stct_unit)){
		return undefined;
	}

	if (!ds_exists(_list_ranch_dummies,ds_type_list)){
		return undefined;
	}

	var _val_rand_x = irandom_range(-200,200);
	var _val_rand_y = irandom_range(-200,200);

	var _ref_new_unit = instance_create_layer(
		(room_width * 0.5) + _val_rand_x,
		(room_height * 0.5) + _val_rand_y,
		"ily_player",
		obj_ranch_beast_dummy
	);

	//----------------//
	//SET BEAST DATA//
	//----------------//
	_ref_new_unit.sprite_index = _stct_unit._spr_beast;
	_ref_new_unit._spr_shadow = scr_beast_get_type_shadow(_stct_unit._str_beast_color_type);

	_ref_new_unit._snd_death = _stct_unit._snd_beast_death;
	_ref_new_unit._snd_cry = _stct_unit._snd_beast_cry;

	_ref_new_unit._uid_beast = _stct_unit._uid_beast;

	//----------------//
	//SET DEAD STATE//
	//----------------//
	if (_stct_unit._val_cur_hp <= 0){
		_ref_new_unit._state_dummy = ENUM_RANCH_BEAST_DUMMY_STATE.REST;
	}

	ds_list_add(_list_ranch_dummies,_ref_new_unit);

	return _ref_new_unit;
}

//-------------------------------------------------------------------------------//
// HSCR_RANCH_DESTROY_BEAST_DUMMY
// FUNCTION: Destroys the Ranch Beast dummy matching a supplied Beast UID.
//           Removes the dummy reference from the local dummy list.
//
// ARGUMENTS: _uid_beast is the UID of the Beast represented by the dummy.
// RETURNS: True if a matching dummy was destroyed; otherwise false.
//-------------------------------------------------------------------------------//
function hscr_ranch_destroy_beast_dummy(_uid_beast){

	if (!ds_exists(_list_ranch_dummies,ds_type_list)){
		return false;
	}

	for (var _it_dummy = 0;_it_dummy < ds_list_size(_list_ranch_dummies);_it_dummy++){

		var _ref_dummy = ds_list_find_value(_list_ranch_dummies,_it_dummy);

		if (!instance_exists(_ref_dummy)){
			ds_list_delete(_list_ranch_dummies,_it_dummy);
			_it_dummy--;
			continue;
		}

		if (_ref_dummy._uid_beast != _uid_beast){
			continue;
		}

		ds_list_delete(_list_ranch_dummies,_it_dummy);
		instance_destroy(_ref_dummy);

		return true;
	}

	return false;
}