//===============================================================================//
//
// DRAW GUI: OBJ_GUI_NPC_PANE
// FUNCTION: Draws and manages the active NPC interaction pane.
//           Displays NPC identity, available menu options, and dialogue.
//           Handles navigation and interaction. Escape closure is owned by
//           OBJ_GUI_CONTROLLER so the key has one GUI-level owner.
//
//===============================================================================//

//================//
//VALIDATE DATA//
//================//
if (!instance_exists(_ref_npc) || _stct_npc == undefined){
    hscr_gui_npc_close();
    exit;
}

//================//
//SETUP//
//================//
var _val_mouse_x = device_mouse_x_to_gui(0);
var _val_mouse_y = device_mouse_y_to_gui(0);

hscr_gui_npc_update_click_cooldown();

//================//
//PANE//
//================//
draw_set_colour(c_black);

draw_rectangle(
    _val_pane_left,
    _val_pane_top,
    _val_pane_left + _val_pane_w,
    _val_pane_top + _val_pane_h,
    false
);

draw_set_colour(global.c_dk_gray);

draw_rectangle(
    _val_pane_left + 4,
    _val_pane_top + 4,
    _val_pane_left + _val_pane_w - 4,
    _val_pane_top + _val_pane_h - 4,
    false
);

//================//
//NPC HEADER//
//================//
draw_set_font(fnt_gui_medium);
draw_set_colour(c_white);

draw_text(
    _val_header_x,
    _val_header_y,
    string(_stct_npc._str_npc_name)
);

draw_set_font(fnt_gui_small);
draw_set_colour(c_ltgray);

draw_text(
    _val_header_x,
    _val_header_y + 34,
    string(_stct_npc._str_npc_title)
);

//================//
//HEADER DIVIDER//
//================//
draw_set_colour(c_black);

draw_line(
    _val_pane_left + 20,
    _val_pane_top + 100,
    _val_pane_left + _val_pane_w - 20,
    _val_pane_top + 100
);

//================//
//ACTIVE MODE//
//================//
switch (_str_npc_gui_mode){

    case "MENU":

        hscr_gui_npc_handle_menu_input();

        hscr_gui_npc_draw_menu(_val_mouse_x,_val_mouse_y);

    break;

    case "DIALOGUE":

        hscr_gui_npc_update_dialogue();
        hscr_gui_npc_handle_dialogue_input();
        hscr_gui_npc_draw_dialogue();

    break;
}

//================//
//FOOTER//
//================//
if (_str_npc_gui_mode == "MENU"){

    draw_set_font(fnt_gui_small);
    draw_set_colour(c_ltgray);

    draw_text(
        _val_pane_left + 24,
        _val_pane_top + _val_pane_h - 34,
        "UP/DOWN: SELECT   E/ENTER: CONFIRM   ESC: CLOSE"
    );
}

//================//
//RESET DRAW STATE//
//================//
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);