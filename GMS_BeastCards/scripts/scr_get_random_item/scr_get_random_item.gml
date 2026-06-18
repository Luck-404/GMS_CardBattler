//
//
// SCRIPT: ROLL_RANDOM_BEAST | GETS ALL THE BEASTS FROM THE GIVEN POOL AND ROLLS ONE | RETURNS A DSMAP OF A BEAST
//
//
function scr_get_random_item(_pool){
    var _weights = {
        "QUEST_IMPORTANT_NOTEBOOK"		: 5,   // R3
        "HELD_POWERFUL_STONE"			: 10,  // R2
        "CONSUMABLE_HEALING_SALVE"		: 50,  // R1
        "PRISM_BASIC_PRISM"				: 50,  // R1
        "EGG_ARBRAWN"					: 20   // R2
    };

    var _total_weight = 0;

    // Sum weights for beasts in pool
    for (var _i = 0; _i < ds_list_size(_pool); _i++)
    {
        var _name = ds_list_find_value(_pool,_i);

        if (variable_struct_exists(_weights, _name))
        {
            _total_weight += variable_struct_get(_weights, _name);
        }
    }

    // Roll
    var _roll = irandom_range(1, _total_weight);

    // Resolve roll
    var _running = 0;
    var _item_name = "";

    for (var _i = 0; _i < ds_list_size(_pool); _i++)
    {
        var _name = ds_list_find_value(_pool,_i);

        if (variable_struct_exists(_weights, _name))
        {
            _running += variable_struct_get(_weights, _name);

            if (_roll <= _running)
            {
                _item_name = _name;
                break;
            }
        }
    }

	//MAKE NEW UNIT OF THE ROLLED TYPE
	return _item_name;
	
}