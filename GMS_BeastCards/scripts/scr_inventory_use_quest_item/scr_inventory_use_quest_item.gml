//===============================================================================//
// SCRIPT: SCR_INVENTORY_USE_QUEST_ITEM
// FUNCTION: Calls each Quest Item's dedicated Inventory callback.
//           Non-notebook Quest callbacks only display the item description.
//           The Important Notebook retains its original room-specific reward.
// ARGUMENTS: _stct_item - selected Quest Item struct.
//            _ref_inventory_pane - owning Inventory pane instance.
// RETURNS: callback result or false when nothing executes.
//===============================================================================//
function scr_inventory_use_quest_item(_stct_item,_ref_inventory_pane){

    //================//
    //VALIDATE ITEM//
    //================//
    if (!is_struct(_stct_item)){
        scr_inventory_cancel_item_use(_ref_inventory_pane);
        return false;
    }

    if (_stct_item._str_item_type != "QUEST"){
        scr_inventory_cancel_item_use(_ref_inventory_pane);
        return false;
    }

    //================//
    //CALL QUEST ITEM//
    //================//
    if (_stct_item._scr_item == undefined){
        var _ref_textbox = instance_create_layer(
            display_get_gui_width() * 0.5,
            display_get_gui_height() * 0.5,
            "ily_fx",
            obj_gui_scrolling_textbox
        );

        if (instance_exists(_ref_textbox)){
            _ref_textbox._ref_parent_gui = _ref_inventory_pane;
            _ref_textbox._str_text = _stct_item._str_item_desc;
        }
        audio_play_sound(snd_inventory_use_item,0,false);
        return false;
    }

    var _flag_success = _stct_item._scr_item(_stct_item,_ref_inventory_pane);

    //================//
    //LOG RESULT//
    //================//
    scr_debug_log(
        "INVENTORY",
        "QUEST",
        undefined,
        "QUEST ITEM USED" +
        " | ITEM: " + string_upper(_stct_item._str_item_name) +
        " | ID: " + string_upper(_stct_item._str_item_id) +
        " | RESULT: " + (_flag_success ? "SUCCESS" : "DESCRIPTION ONLY") +
        " | ROOM: " + room_get_name(room),
        "INFO",
        "SCR_INVENTORY_USE_QUEST_ITEM"
    );

    return _flag_success;
}
