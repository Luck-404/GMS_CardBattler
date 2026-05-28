//
//
// CREATE: OBJ_GUI_PARTY_RANCH
//
//

//VARIABLES
depth = 1;
_flag_spawned = false;
_flag_triggered = false;
_cooldown = 10;
_dummy_list = ds_list_create();

//INIT

//METHODS

//
// SCR_SPAWN_RANCH_UNIT | SPAWNS A NEW DUMMY BEAST WITHIN THE BOUNDS OF THE RANCH
//
#region SPAWN RANCH DUMMY
function scr_spawn_ranch_unit(_unit){
	//GET RANDOM SPOT TO PLACE UNIT IN
	_rand_x = irandom_range(-200,200);
	_rand_y = irandom_range(-200,200);
	
	//SPAWN NEW UNIT
	_new_unit = instance_create_layer(room_width/2+_rand_x,room_height/2+_rand_y,"ily_player",obj_ranch_beast_dummy);	
	
	//ESTABLISH THE UNIT'S VISUALS AND PASS IT THE REFERENCE UID
	_new_unit.sprite_index = _unit[?"beast_sprite"];
	_new_unit._shadow = scr_get_beast_type_shadow(_unit[?"beast_color_type"]);
	_new_unit._uid = _unit[?"beast_uid"];
	
	//ADD UNIT TO THE TRACKER LIST
	ds_list_add(_dummy_list,_new_unit);
}
#endregion

//
// SCR_DESTROY_RANCH_UNIT | REMOVES A RANCH DUMMY UNIT FROM THE PADDOCK, DELETING IT FROM THE LIST AS WELL
//
#region REMOVE RANCH DUMMY
function scr_destroy_ranch_unit(_uid){
	//FIND THE DUMMY UNIT TO BE REMOVED (THROUGH RELEASING A UNIT VIA DELETE OR MOVING FROM RANCH TO PARTY)
    for (var _i = 0; _i < ds_list_size(_dummy_list); _i++) {
        var _u = ds_list_find_value(_dummy_list, _i);

		//CHECK THE UID OF THE DUMMY VS THE UID OF THE TARGET
        if (_u._uid == _uid) {
			//DELETE THE FOUND UNIT
            ds_list_delete(_dummy_list, _i);
            instance_destroy(_u);
            break;
        }
    }
}
#endregion