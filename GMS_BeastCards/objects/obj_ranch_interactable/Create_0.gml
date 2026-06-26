//===============================================================================//
//
// CREATE: OBJ_RANCH_INTERACTABLE
// FUNCTION: Initializes the ranch interactable.
//           Stores ranch dummy references and interaction cooldown state.
//           Defines helper scripts for spawning and destroying ranch dummy beasts.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
depth = 1;

_flag_spawned = false;
_flag_triggered = false;
_val_cooldown = 10;

_list_dummy = ds_list_create();

//----//
//INIT//
//----//

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// hscr_spawn_ranch_unit
// FUNCTION: Spawns a ranch dummy beast within the ranch bounds.
//           Applies sprite, shadow, UID, and resting state from beast struct.
//—------------------------------------------------------------------------------//
function hscr_spawn_ranch_unit(_stct_unit){

	var _val_rand_x = irandom_range(-200,200);
	var _val_rand_y = irandom_range(-200,200);

	var _ref_new_unit = instance_create_layer(room_width * 0.5 + _val_rand_x,room_height * 0.5 + _val_rand_y,"ily_player",obj_ranch_beast_dummy);

	_ref_new_unit.sprite_index = _stct_unit._spr_beast;
	_ref_new_unit._shadow = scr_get_beast_type_shadow(_stct_unit._str_beast_color_type);
	_ref_new_unit._uid = _stct_unit.beast_uid;

	if (_stct_unit._val_beast_hp_cur <= 0){
		_ref_new_unit._beast_state = BEAST_STATE.REST;
	}

	ds_list_add(_list_dummy,_ref_new_unit);
}

//—------------------------------------------------------------------------------//
// hscr_destroy_ranch_unit
// FUNCTION: Destroys a ranch dummy beast matching the supplied beast UID.
//           Removes the dummy reference from the local dummy list.
//—------------------------------------------------------------------------------//
function hscr_destroy_ranch_unit(_uid_beast){

	for (var _it_dummy = 0; _it_dummy < ds_list_size(_list_dummy); _it_dummy++){

		var _ref_dummy = ds_list_find_value(_list_dummy,_it_dummy);

		if (_ref_dummy == undefined){
			continue;
		}

		if (_ref_dummy._uid == _uid_beast){
			ds_list_delete(_list_dummy,_it_dummy);
			instance_destroy(_ref_dummy);
			break;
		}
	}
}

#endregion