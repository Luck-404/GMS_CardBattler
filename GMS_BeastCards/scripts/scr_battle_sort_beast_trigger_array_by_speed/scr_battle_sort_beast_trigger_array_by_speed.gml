//===============================================================================//
//
// SCRIPT: SCR_BATTLE_SORT_BEAST_TRIGGER_ARRAY_BY_SPEED
// FUNCTION: Sorts an array of Beast-owned scheduled triggers by current host
//           Speed using SCR_BATTLE_SORT_BEAST_TRIGGER_QUEUE_BY_SPEED.
//
//           Higher-Speed hosts resolve first. Exact Speed ties use the existing
//           randomized Beast tie roll. Multiple triggers belonging to the same
//           Beast preserve their original relative order. Trigger structs that do
//           not contain a valid _ref_beast are preserved at the end.
//
//           This helper is source-agnostic: Item, Ability, or other scheduled
//           trigger structs can share it as long as they expose _ref_beast.
//
// ARGUMENTS: _arr_triggers - Trigger struct array to sort.
// RETURNS: Sorted trigger array. Invalid input returns an empty array.
//
//===============================================================================//

function scr_battle_sort_beast_trigger_array_by_speed(_arr_triggers){

    #region VALIDATION

    if (!is_array(_arr_triggers)){
        return [];
    }

    if (array_length(_arr_triggers) <= 1){
        return _arr_triggers;
    }

    #endregion

    #region BUILD TEMPORARY LIST

    var _list_triggers = ds_list_create();

    for (
        var _it_trigger = 0;
        _it_trigger < array_length(_arr_triggers);
        _it_trigger++
    ){

        ds_list_add(
            _list_triggers,
            _arr_triggers[_it_trigger]
        );
    }

    #endregion

    #region SORT

    scr_battle_sort_beast_trigger_queue_by_speed(
        _list_triggers
    );

    #endregion

    #region REBUILD ARRAY

    var _arr_sorted = [];

    for (
        var _it_trigger = 0;
        _it_trigger < ds_list_size(_list_triggers);
        _it_trigger++
    ){

        array_push(
            _arr_sorted,
            ds_list_find_value(
                _list_triggers,
                _it_trigger
            )
        );
    }

    ds_list_destroy(_list_triggers);

    #endregion

    return _arr_sorted;
}
