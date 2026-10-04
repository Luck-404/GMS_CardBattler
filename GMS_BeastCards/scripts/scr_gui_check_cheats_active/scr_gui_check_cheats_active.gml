//===============================================================================//
//
// SCRIPT: SCR_GUI_CHECK_CHEATS_ACTIVE
// FUNCTION: Returns whether the Cheats GUI currently owns the active GUI slot.
//           Used to suppress normal Ctrl inspection while Cheats is active.
//
// RETURNS: True while OBJ_GUI_CHEATS_PANE is the active GUI.
//
//===============================================================================//

function scr_gui_check_cheats_active(){

    if (
        !variable_global_exists(
            "ref_active_gui"
        )
    ){
        return false;
    }

    if (
        !instance_exists(
            global.ref_active_gui
        )
    ){
        return false;
    }

    if (
        !variable_instance_exists(
            global.ref_active_gui,
            "_str_type"
        )
    ){
        return false;
    }

    return
        global.ref_active_gui._str_type ==
        "CHEATS";
}