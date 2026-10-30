//===============================================================================//
// SCRIPT: SCR_INVENTORY_ITEM_QUEST_VIRIDIAN_RUNESTONE
// FUNCTION: Displays the VIRIDIAN RUNESTONE description when used from Inventory.
//           Informational only: no consumption, quest progress, or world effect.
// ARGUMENTS: _stct_item - inventory Quest Item struct.
//            _ref_inventory_pane - owning Inventory pane instance.
// RETURNS: false (no gameplay effect; item remains in Inventory).
//===============================================================================//
function scr_inventory_item_quest_viridian_runestone(_stct_item,_ref_inventory_pane){

    //================//
    //VALIDATE ITEM//
    //================//
    if (!is_struct(_stct_item)){
        return false;
    }

    if (_stct_item._str_item_type != "QUEST" || _stct_item._str_item_id != "QUEST_VIRIDIAN_RUNESTONE"){
        return false;
    }

    //================//
    //DISPLAY DESCRIPTION//
    //================//
    var _str_text = _stct_item._str_item_desc;
    if (!is_string(_str_text) || _str_text == ""){
        _str_text = "VIRIDIAN RUNESTONE.";
    }

    var _ref_textbox = instance_create_layer(
        display_get_gui_width() * 0.5,
        display_get_gui_height() * 0.5,
        "ily_fx",
        obj_gui_scrolling_textbox
    );

    if (instance_exists(_ref_textbox)){
        _ref_textbox._ref_parent_gui = _ref_inventory_pane;
        _ref_textbox._str_text = _str_text;
    }

    audio_play_sound(snd_inventory_use_item,0,false);

    //================//
    //NO CONSUMPTION//
    //================//
    return false;
}
