//===============================================================================//
//
// SCR_ADD_ITEM_TO_INVENTORY
// FUNCTION: Adds item maps into inventory with count support.
//           Handles stacking + overflow into new stacks.
//
//===============================================================================//

function scr_add_item_to_inventory(_new_item_name, _count)
{
    var _inv = global.player_inventory;

    var _base_item = scr_get_item_info(_new_item_name);

    var _stackable = _base_item[?"item_stackable"];
    var _name = _base_item[?"item_name"];
    //--------------------------------------------------
    // NON-STACKABLE ITEMS
    //--------------------------------------------------
    if (!_stackable)
    {
        for (var _i = 0; _i < _count; _i++)
        {
            ds_list_add(_inv, _base_item);
        }
        return;
    }

    //--------------------------------------------------
    // STACKABLE ITEMS
    //--------------------------------------------------
    var _remaining = _count;

    // STEP 1: FILL EXISTING STACKS
    for (var _i = 0; _i < ds_list_size(_inv); _i++)
    {
        if (_remaining <= 0) break;

        var _item = ds_list_find_value(_inv, _i);
        if (_item == undefined) continue;

        if (_item[?"item_name"] == _name)
        {
            var _cur = _item[?"item_amount"];
            var _max = _item[?"item_max_amount"];

            if (_cur < _max)
            {
                var _space = _max - _cur;
                var _add = min(_space, _remaining);

                _item[?"item_amount"] = _cur + _add;
                _remaining -= _add;

                ds_list_replace(_inv, _i, _item);
            }
        }
    }

    // STEP 2: CREATE NEW STACKS IF NEEDED
    while (_remaining > 0)
    {
        var _new_stack = scr_get_item_info(_new_item_name);
        var _max = _new_stack[?"item_max_amount"];

        var _add = min(_max, _remaining);

        _new_stack[?"item_amount"] = _add;
        _remaining -= _add;

        ds_list_add(_inv, _new_stack);
    }
}