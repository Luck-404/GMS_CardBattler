//===============================================================================//
//
// SCRIPT: SCR_GUI_SPAWN_POPUP_TRIGGER_BANNER
// FUNCTION: Creates a GUI trigger banner and supplies its display text.
//
// ARGUMENTS: _str_text - Text displayed inside the banner.
// RETURNS: Created banner instance.
//
//===============================================================================//

function scr_gui_spawn_popup_trigger_banner(_str_text){

    //================//
    //CREATE BANNER//
    //================//
    var _ref_banner = instance_create_layer(
        0,
        0,
        "ily_fx",
        obj_gui_popup_trigger_banner
    );

    //================//
    //ASSIGN TEXT//
    //================//
    _ref_banner._str_text = _str_text;

    return _ref_banner;
}