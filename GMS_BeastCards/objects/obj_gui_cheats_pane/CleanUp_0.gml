//===============================================================================//
//
// CLEAN UP: OBJ_GUI_CHEATS_PANE
// FUNCTION: Clears Cheats Menu input and stale active-GUI state.
//
//===============================================================================//

//================//
//CLEAR TEXT INPUT//
//================//
keyboard_string = "";

//================//
//CLEAR TOOL STATE//
//================//
_str_state = "MENU";

_str_tool = "";
_str_tool_label = "";
_str_tool_target_type = "";

_str_selected_id = "";

//================//
//CLEAR MENU STATE//
//================//
_it_page = 0;
_it_submenu = 0;

//================//
//CLEAR PASSWORD STATE//
//================//
_str_password = "";

_flag_password_entry = false;
_flag_authenticated = false;

//================//
//CLEAR ACTIVE GUI//
//================//
if (
    variable_global_exists(
        "ref_active_gui"
    ) &&
    global.ref_active_gui == id
){
    global.ref_active_gui =
        undefined;
}

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);