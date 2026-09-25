//===============================================================================//
//
// STEP: OBJ_GUI_CHEATS_PANE
// FUNCTION: Handles Cheats Menu input.
//           Supports authentication, tab navigation, pagination,
//           mouse-wheel pagination, and active targeting tools.
//
//===============================================================================//

//================//
//INPUT LOCKOUT//
//================//
if (_ct_input_lockout > 0){

    _ct_input_lockout--;

    exit;
}

//===============================================================================//
// PASSWORD
//===============================================================================//
#region PASSWORD

if (_flag_password_entry){

//----------------//
//ENTER//
//----------------//
    if (
        keyboard_check_pressed(
            vk_enter
        )
    ){

        hscr_cheats_submit_password();

        exit;
    }

    exit;
}

#endregion

//===============================================================================//
// VALIDATE AUTHENTICATION
//===============================================================================//

if (!_flag_authenticated){
    exit;
}

//===============================================================================//
// TOOL MODE
//===============================================================================//
#region TOOL MODE

if (_str_state == "TOOL"){

//================//
//CANCEL TOOL//
//================//
    if (
        mouse_check_button_pressed(
            mb_right
        )
    ){

        hscr_cheats_cancel_tool();

        exit;
    }

//================//
//WORLD POSITION//
//================//
// World-position tools intentionally do NOT consume
// navigation/scroll input here.
//
// This allows the player to move/scroll the camera while
// positioning a world-space cheat such as SPAWN WILD BEAST.
    if (
        _str_tool_target_type ==
        "WORLD_POSITION"
    ){

        if (
            mouse_check_button_pressed(
                mb_left
            )
        ){

            switch (_str_tool){

//----------------//
//SPAWN WILD//
//----------------//
                case "SPAWN_WILD":

                    hscr_cheats_spawn_wild(
                        _str_selected_id
                    );

                break;
            }
        }

        exit;
    }

//================//
//BATTLE UNIT//
//================//
    if (
        _str_tool_target_type ==
        "BATTLE_UNIT"
    ){

        if (
            mouse_check_button_pressed(
                mb_left
            )
        ){

            var _ref_target =
                hscr_cheats_get_battle_target(
                    true
                );

            if (
                !instance_exists(
                    _ref_target
                )
            ){

                audio_play_sound(
                    snd_gui_error,
                    0,
                    false
                );

                exit;
            }

            switch (_str_tool){

//----------------//
//HEAL +1//
//----------------//
                case "HEAL_1":

                    hscr_cheats_battle_heal(
                        _ref_target,
                        1
                    );

                break;

//----------------//
//HEAL +10//
//----------------//
                case "HEAL_10":

                    hscr_cheats_battle_heal(
                        _ref_target,
                        10
                    );

                break;

//----------------//
//HEAL FULL//
//----------------//
                case "HEAL_FULL":

                    hscr_cheats_battle_heal(
                        _ref_target,
                        -1
                    );

                break;

//----------------//
//DAMAGE -1//
//----------------//
                case "DAMAGE_1":

                    hscr_cheats_battle_damage(
                        _ref_target,
                        1
                    );

                break;

//----------------//
//DAMAGE -10//
//----------------//
                case "DAMAGE_10":

                    hscr_cheats_battle_damage(
                        _ref_target,
                        10
                    );

                break;

//----------------//
//KILL//
//----------------//
                case "KILL":

                    hscr_cheats_battle_damage(
                        _ref_target,
                        -1
                    );

                break;

//----------------//
//RESURRECT//
//----------------//
                case "RESURRECT":

                    hscr_cheats_resurrect(
                        _ref_target
                    );

                break;

//----------------//
//LEVEL +1//
//----------------//
                case "LEVEL_1":

                    hscr_cheats_battle_level(
                        _ref_target,
                        1
                    );

                break;

//----------------//
//LEVEL +5//
//----------------//
                case "LEVEL_5":

                    hscr_cheats_battle_level(
                        _ref_target,
                        5
                    );

                break;

//----------------//
//LEVEL -1//
//----------------//
                case "LEVEL_MINUS_1":

                    hscr_cheats_battle_level(
                        _ref_target,
                        -1
                    );

                break;

//----------------//
//LEVEL -5//
//----------------//
                case "LEVEL_MINUS_5":

                    hscr_cheats_battle_level(
                        _ref_target,
                        -5
                    );

                break;

//----------------//
//STATUS//
//----------------//
                case "STATUS":

                    var _it_separator =
                        string_pos(
                            "|",
                            _str_selected_id
                        );

                    if (_it_separator > 0){

                        var _str_category =
                            string_copy(
                                _str_selected_id,
                                1,
                                _it_separator - 1
                            );

                        var _str_status =
                            string_copy(
                                _str_selected_id,
                                _it_separator + 1,
                                string_length(
                                    _str_selected_id
                                )
                            );

                        hscr_cheats_apply_status(
                            _ref_target,
                            _str_category,
                            _str_status
                        );
                    }

                break;

				//----------------//
				//CLEANSE//
				//----------------//
				case "CLEANSE":

				    var _it_separator_1 =
				        string_pos(
				            "|",
				            _str_selected_id
				        );

				    if (_it_separator_1 > 0){

				        var _str_remainder =
				            string_copy(
				                _str_selected_id,
				                _it_separator_1 + 1,
				                string_length(
				                    _str_selected_id
				                )
				            );

				        var _it_separator_2 =
				            string_pos(
				                "|",
				                _str_remainder
				            );

				        if (_it_separator_2 > 0){

				            var _str_cleanse_filter =
				                string_copy(
				                    _str_selected_id,
				                    1,
				                    _it_separator_1 - 1
				                );

				            var _str_cleanse_mode =
				                string_copy(
				                    _str_remainder,
				                    1,
				                    _it_separator_2 - 1
				                );

				            var _str_cleanse_amount =
				                string_copy(
				                    _str_remainder,
				                    _it_separator_2 + 1,
				                    string_length(
				                        _str_remainder
				                    )
				                );

				            var _var_cleanse_amount =
				                (_str_cleanse_amount == "ALL")
				                ? "ALL"
				                : real(
				                    _str_cleanse_amount
				                );

				            hscr_cheats_cleanse(
				                _ref_target,
				                _str_cleanse_filter,
				                _str_cleanse_mode,
				                _var_cleanse_amount
				            );
				        }
				    }

				break;

//----------------//
//SPAWN MINION//
//----------------//
                case "SPAWN_MINION":

                    hscr_cheats_spawn_minion(
                        _ref_target,
                        _str_selected_id
                    );

                break;
            }
        }

        exit;
    }

//================//
//BATTLE CARD//
//================//
    if (
        _str_tool_target_type ==
        "BATTLE_CARD"
    ){

//================//
//LEFT CLICK//
//================//
        if (
            mouse_check_button_pressed(
                mb_left
            )
        ){

//----------------//
//GET HOVERED CARD//
//----------------//
            var _ref_card =
                scr_battle_get_hovered_hand_card();

//----------------//
//INVALID TARGET//
//----------------//
            if (
                !instance_exists(
                    _ref_card
                )
            ){

                hscr_cheats_error(
                    "CARD TARGET FAILED",
                    "NO PLAYER HAND CARD UNDER MOUSE"
                );

                exit;
            }

//================//
//RESOLVE TOOL//
//================//
            switch (_str_tool){

//----------------//
//DISCARD CARD//
//----------------//
                case "DISCARD_CARD":

                    hscr_cheats_move_hand_card(
                        _ref_card,
                        "DISCARD"
                    );

                break;

//----------------//
//EXHAUST CARD//
//----------------//
                case "EXHAUST_CARD":

                    hscr_cheats_move_hand_card(
                        _ref_card,
                        "EXHAUST"
                    );

                break;

//----------------//
//INVALID TOOL//
//----------------//
                default:

                    hscr_cheats_error(
                        "CARD TOOL FAILED",
                        "UNKNOWN TOOL: " +
                        string_upper(
                            _str_tool
                        )
                    );

                break;
            }
        }

        exit;
    }

    exit;
}

#endregion

//===============================================================================//
// MENU NAVIGATION
//===============================================================================//
#region MENU NAVIGATION

//================//
//TAB NAVIGATION//
//================//

//----------------//
//LEFT TAB//
// LEFT ARROW / A
//----------------//
if (
    keyboard_check_pressed(vk_left) ||
    keyboard_check_pressed(ord("A"))
){

    hscr_cheats_change_tab(
        -1
    );

    exit;
}

//----------------//
//RIGHT TAB//
// RIGHT ARROW / D
//----------------//
if (
    keyboard_check_pressed(vk_right) ||
    keyboard_check_pressed(ord("D"))
){

    hscr_cheats_change_tab(
        1
    );

    exit;
}

//===============================================================================//
// DETERMINE PAGE COUNT
//===============================================================================//

var _ct_page_entries = 0;
var _ct_page_rows = _ct_rows_per_page;

//================//
//OVERWORLD//
//================//
if (_str_mode == "OVERWORLD"){

    switch (_it_tab){

//----------------//
//BEASTS//
//----------------//
        case 0:

            if (
                ds_exists(
                    global.list_logbook_beasts,
                    ds_type_list
                )
            ){

                _ct_page_entries =
                    ds_list_size(
                        global.list_logbook_beasts
                    );
            }

        break;

//----------------//
//CARDS//
//----------------//
        case 1:

            if (
                ds_exists(
                    global.list_logbook_cards,
                    ds_type_list
                )
            ){

                _ct_page_entries =
                    ds_list_size(
                        global.list_logbook_cards
                    );
            }

        break;

//----------------//
//ITEMS//
//----------------//
        case 2:

            if (
                ds_exists(
                    global.list_pool_items,
                    ds_type_list
                )
            ){

                _ct_page_entries =
                    ds_list_size(
                        global.list_pool_items
                    );
            }

        break;

//----------------//
//MISC//
//----------------//
        case 3:

            // The wild-Beast catalog is the paginated portion
            // of the Misc tab.
            if (
                ds_exists(
                    global.list_logbook_beasts,
                    ds_type_list
                )
            ){

                _ct_page_entries =
                    ds_list_size(
                        global.list_logbook_beasts
                    );
            }

        break;
    }
}

//================//
//BATTLE//
//================//
else{

    switch (_it_tab){

//----------------//
//INTERACT//
//----------------//
        case 0:

// STATUS SUBMENU
            if (_it_submenu == 1){

                _ct_page_entries =
                    array_length(
                        _arr_cheat_dots
                    ) +
                    array_length(
                        _arr_cheat_cc
                    ) +
                    array_length(
                        _arr_cheat_debuffs
                    ) +
                    array_length(
                        _arr_cheat_buffs
                    );

                // Status buttons are normally drawn in a grid.
                // Draw GUI should use this same count per page.
                _ct_page_rows = 12;
            }

// MINION SUBMENU
            else if (_it_submenu == 2){

                _ct_page_entries =
                    array_length(
                        _arr_cheat_minions
                    );

                _ct_page_rows = 12;
            }

// MAIN INTERACT PAGE
            else{

                _ct_page_entries = 1;
                _ct_page_rows = 1;
            }

        break;

//----------------//
//EVENTS / WEATHER//
//----------------//
        case 1:

            _ct_page_entries =
                array_length(
                    _arr_cheat_weather
                ) +
                array_length(
                    _arr_cheat_events
                );

            _ct_page_rows =
                _ct_rows_per_page;

        break;

//----------------//
//HAND//
//----------------//
        case 2:

            _ct_page_entries = 1;
            _ct_page_rows = 1;

        break;

//----------------//
//END BATTLE//
//----------------//
        case 3:

            _ct_page_entries = 1;
            _ct_page_rows = 1;

        break;
    }
}

//================//
//MAX PAGE//
//================//
var _it_max_page =
    hscr_cheats_get_max_page(
        _ct_page_entries,
        _ct_page_rows
    );

// Keep current page legal if the catalog changed
// while the menu was open.
_it_page =
    clamp(
        _it_page,
        0,
        _it_max_page
    );

//===============================================================================//
// PAGE INPUT
//===============================================================================//

var _flag_page_previous = false;
var _flag_page_next = false;

//================//
//================//
//KEYBOARD//
//================//

//----------------//
//PREVIOUS PAGE//
// UP ARROW / W
//----------------//
if (
    keyboard_check_pressed(vk_up) ||
    keyboard_check_pressed(ord("W"))
){

    _flag_page_previous = true;
}

//----------------//
//NEXT PAGE//
// DOWN ARROW / S
//----------------//
if (
    keyboard_check_pressed(vk_down) ||
    keyboard_check_pressed(ord("S"))
){

    _flag_page_next = true;
}

//================//
//MOUSE WHEEL//
//================//
if (
    mouse_wheel_up()
){

    _flag_page_previous = true;
}

if (
    mouse_wheel_down()
){

    _flag_page_next = true;
}

//================//
//PREVIOUS PAGE//
//================//
if (_flag_page_previous){

    if (
        hscr_cheats_set_page(
            _it_page - 1,
            _it_max_page
        )
    ){

        audio_play_sound(
            snd_gui_press,
            0,
            false
        );
    }

    exit;
}

//================//
//NEXT PAGE//
//================//
if (_flag_page_next){

    if (
        hscr_cheats_set_page(
            _it_page + 1,
            _it_max_page
        )
    ){

        audio_play_sound(
            snd_gui_press,
            0,
            false
        );
    }

    exit;
}

#endregion