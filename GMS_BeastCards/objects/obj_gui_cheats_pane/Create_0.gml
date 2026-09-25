//===============================================================================//
//
// CREATE: OBJ_GUI_CHEATS_PANE
// FUNCTION: Initializes the developer Cheats Menu.
//           Supports overworld and battle cheat layouts.
//           Defines menu, paging, targeting, and cheat-action helpers.
//
//===============================================================================//

//================//
//VARIABLES//
//================//
#region VARIABLES

_str_type = "CHEATS";

_str_mode = (room == rm_battle) ? "BATTLE" : "OVERWORLD";
_str_state = "MENU";

_str_tool = "";
_str_tool_label = "";
_str_tool_target_type = "";

_str_selected_id = "";

_it_tab = 0;
_it_page = 0;

// Separate submenu state from page state.
// 0 = NONE
// 1 = STATUS
// 2 = MINION
_it_submenu = 0;

_flag_authenticated = false;
_flag_password_entry = false;

_str_password = "";
_str_password_correct = "TESTER";

_ct_input_lockout = 8;

_val_gui_width = display_get_gui_width();
_val_gui_height = display_get_gui_height();

//================//
//PANE LAYOUT//
//================//
_val_pane_x1 = 100;
_val_pane_y1 = 100;

_val_pane_x2 =
    _val_gui_width - 100;

_val_pane_y2 =
    _val_gui_height - 100;

_val_pane_w =
    _val_pane_x2 - _val_pane_x1;

_val_pane_h =
    _val_pane_y2 - _val_pane_y1;

//----------------//
//HEADER//
//----------------//
_val_header_h = 38;

//----------------//
//TABS//
//----------------//
_val_tab_h = 38;

_val_tab_y1 =
    _val_pane_y1 +
    _val_header_h;

_val_tab_y2 =
    _val_tab_y1 +
    _val_tab_h;

//----------------//
//FOOTER//
//----------------//
_val_footer_h = 34;

//----------------//
//CONTENT//
//----------------//
_val_content_x1 =
    _val_pane_x1 + 18;

_val_content_x2 =
    _val_pane_x2 - 18;

_val_content_y1 =
    _val_tab_y2 + 16;

_val_content_y2 =
    _val_pane_y2 -
    _val_footer_h -
    10;

_val_content_w =
    _val_content_x2 -
    _val_content_x1;

_val_content_h =
    _val_content_y2 -
    _val_content_y1;

_val_content_y =
    _val_content_y1;

//----------------//
//ROWS//
//----------------//
_val_row_h = 34;
_val_row_gap = 5;

_val_row_step =
    _val_row_h +
    _val_row_gap;

_ct_rows_per_page =
    max(
        1,
        floor(
            (
                _val_content_h -
                60
            ) /
            _val_row_step
        )
    );

_arr_tabs = [];

if (_str_mode == "BATTLE"){
    _arr_tabs = [
        "INTERACT",
        "EVENTS AND WEATHER",
        "HAND",
        "END BATTLE"
    ];
}
else{
    _arr_tabs = [
        "BEASTS",
        "CARDS",
        "ITEMS",
        "MISC"
    ];
}

//================//
//STATUS CATALOG//
//================//
_arr_cheat_dots = [
    "BLEED",
    "BURN",
    "FROSTBITE",
    "FROSTBURN",
    "POISON",
    "STORMSTRUCK",
    "VENOM"
];

_arr_cheat_cc = [
    "BANISH",
    "BLIND",
    "CONFUSED",
    "FROZEN",
    "SLEEP",
    "STUN"
];

_arr_cheat_debuffs = [
    "ANEMIA",
    "ANTIHEAL",
    "ARMORBREAK",
    "BLOODLET",
    "BRITTLE_CONSTITUTION",
    "CHAR",
    "CRIPPLING_VINES",
    "DRAINED",
    "FOCUS",
    "FROZEN_CURSE",
    "HEMOPHILIA",
    "MOLTEN_BRAND",
    "STATIC_RESONANCE",
    "UNSTABLE_COIL",
    "VULNERABLE",
    "WEAKNESS",
    "WHITEOUT",
    "WITHER"
];

// These are normal target-hosted buffs only.
// Global, team-bound, Minion-owned, card-state, and special-context
// statuses are intentionally excluded from direct cheat application.
_arr_cheat_buffs = [
    "ARMOR_OVER_TIME",
    "ARCTIC_FOCUS",
    "BACKDRAFT",
    "BATTLE_FRENZY",
    "BOOST",
    "BURNING_PARRY",
    "CINDERGUARD",
    "DIVINE_PROTECTION",
    "FURNACE_HEART",
    "LAST_STAND",
    "MOLTEN_AEGIS",
    "RAGE",
    "TOXIC_HIDE"
];

_arr_cheat_weather = [
    "FIRESTORM",
    "HEATWAVE",
    "RAIN",
    "SEEDFALL",
    "SNOW",
    "STORMING"
];

_arr_cheat_events = [
    "BLOOD_MOON",
    "BLOODMIST",
    "BLOOMTIDE"
];

_arr_cheat_minions = [
    "ABYSSAL_HARPOON",
    "ANCHOR_STONE",
    "ASH_PHOENIX",
    "BLOOMING_SPRITE",
    "CINDERLING",
    "CORAL_GUARDIAN",
    "DORMANT_SEED",
    "EMBER_TURRET",
    "FLAMEGUARD",
    "FUNGI",
    "GROVE_SPIRIT",
    "ICE_WALL",
    "LIFE_SPIRIT",
    "LIVING_FLAME",
    "MAGMA_CANNON",
    "RIMEFROST_ELEMENTAL",
    "SERPENT",
    "SPORELING",
    "STORM_WISP",
    "TENTACLE",
    "THORNLING",
    "WASP_DRONE"
];

#endregion

//================//
//INIT//
//================//
#region INIT

if (
    variable_instance_exists(id,"_flag_open_authenticated") &&
    _flag_open_authenticated
){
    _flag_authenticated = true;
}
else{
    _flag_password_entry = true;
    keyboard_string = "";
}

global.ref_active_gui = id;

scr_debug_log(
    "GUI",
    "CHEATS",
    self,
    "CHEATS MENU INITIALIZED" +
    " | MODE: " + _str_mode,
    "INFO",
    "OBJ_GUI_CHEATS_PANE:CREATE"
);

#endregion

//================//
//METHODS//
//================//
#region METHODS

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_LOG
//-------------------------------------------------------------------------------//
hscr_cheats_log = function(_str_action,_str_details=""){

    scr_debug_log(
        "GUI",
        "CHEATS",
        self,
        string_upper(_str_action) +
        ((_str_details != "") ? " | " + _str_details : ""),
        "INFO",
        "OBJ_GUI_CHEATS_PANE"
    );
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_ERROR
//-------------------------------------------------------------------------------//
hscr_cheats_error = function(_str_action,_str_details=""){
    audio_play_sound(snd_gui_error,0,false);
    hscr_cheats_log(_str_action,_str_details);
    return false;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_POINT_IN_RECT
//-------------------------------------------------------------------------------//
hscr_cheats_point_in_rect = function(_mx,_my,_x1,_y1,_x2,_y2){

    return
        _mx >= _x1 &&
        _mx <= _x2 &&
        _my >= _y1 &&
        _my <= _y2;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_BUTTON
// FUNCTION: Draws one cheat button and returns true when clicked.
//-------------------------------------------------------------------------------//
hscr_cheats_button = function(_str_text,_x1,_y1,_x2,_y2,_flag_enabled=true){

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    var _flag_hover =
        _flag_enabled &&
        hscr_cheats_point_in_rect(
            _mx,
            _my,
            _x1,
            _y1,
            _x2,
            _y2
        );

    draw_set_colour(
        !_flag_enabled
        ? c_dkgray
        : (_flag_hover ? c_gray : global.c_dk_gray)
    );

    draw_rectangle(
        _x1,
        _y1,
        _x2,
        _y2,
        false
    );

    draw_set_colour(
        _flag_enabled
        ? c_white
        : c_gray
    );

    draw_rectangle(
        _x1,
        _y1,
        _x2,
        _y2,
        true
    );

    draw_set_font(fnt_gui_party_small);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text(
        (_x1 + _x2) * 0.5,
        (_y1 + _y2) * 0.5,
        _str_text
    );

    return
        _flag_hover &&
        mouse_check_button_pressed(mb_left);
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_COLOR
//-------------------------------------------------------------------------------//
hscr_cheats_get_color = function(_str_color){

    switch (string_upper(_str_color)){
        case "VIRIDIAN":  return make_colour_rgb(45,150,70);
        case "VERMILION": return make_colour_rgb(190,55,55);
        case "CERULEAN":   return make_colour_rgb(90,175,235);
        case "UNCOLORED":  return make_colour_rgb(120,120,120);
    }

    return make_colour_rgb(120,120,120);
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_ENTRY_COLOR
// FUNCTION: Supports Logbook entries and raw Beast/Card structs.
//-------------------------------------------------------------------------------//
hscr_cheats_get_entry_color = function(_entry){

    if (!is_struct(_entry)){
        return "UNCOLORED";
    }

    if (
        variable_struct_exists(_entry,"_str_color_group") &&
        _entry._str_color_group != undefined
    ){
        return string_upper(_entry._str_color_group);
    }

    if (
        variable_struct_exists(_entry,"_stct_beast_info") &&
        is_struct(_entry._stct_beast_info)
    ){
        var _stct_beast = _entry._stct_beast_info;
        if (
            variable_struct_exists(_stct_beast,"_arr_beast_colors") &&
            is_array(_stct_beast._arr_beast_colors) &&
            array_length(_stct_beast._arr_beast_colors) > 0 &&
            _stct_beast._arr_beast_colors[0] != undefined
        ){
            return string_upper(_stct_beast._arr_beast_colors[0]);
        }
    }

    if (
        variable_struct_exists(_entry,"_stct_card_info") &&
        is_struct(_entry._stct_card_info)
    ){
        var _stct_card = _entry._stct_card_info;
        if (
            variable_struct_exists(_stct_card,"_arr_card_colors") &&
            is_array(_stct_card._arr_card_colors) &&
            array_length(_stct_card._arr_card_colors) > 0 &&
            _stct_card._arr_card_colors[0] != undefined
        ){
            return string_upper(_stct_card._arr_card_colors[0]);
        }
    }

    if (
        variable_struct_exists(_entry,"_arr_beast_colors") &&
        is_array(_entry._arr_beast_colors) &&
        array_length(_entry._arr_beast_colors) > 0 &&
        _entry._arr_beast_colors[0] != undefined
    ){
        return string_upper(_entry._arr_beast_colors[0]);
    }

    if (
        variable_struct_exists(_entry,"_arr_card_colors") &&
        is_array(_entry._arr_card_colors) &&
        array_length(_entry._arr_card_colors) > 0 &&
        _entry._arr_card_colors[0] != undefined
    ){
        return string_upper(_entry._arr_card_colors[0]);
    }

    return "UNCOLORED";
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_ITEM_COLOR
//-------------------------------------------------------------------------------//
hscr_cheats_get_item_color = function(_str_item_type){
    switch (string_upper(_str_item_type)){
        case "QUEST": return c_yellow;
        case "CONSUMABLE": return c_green;
        case "PRISM": return c_aqua;
        case "HELD": return make_colour_rgb(255,140,0);
        case "EGG": return make_colour_rgb(180,100,255);
    }
    return global.c_dk_gray;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_MAX_PAGE
//-------------------------------------------------------------------------------//
hscr_cheats_get_max_page = function(_ct_entries,_ct_rows){
    if (_ct_rows <= 0){
        return 0;
    }
    return max(0,ceil(_ct_entries / _ct_rows) - 1);
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_SET_PAGE
// FUNCTION: Changes the current Cheats page within the supplied page bounds.
//           Reaching the first/last page is intentionally silent.
//-------------------------------------------------------------------------------//
hscr_cheats_set_page = function(
    _it_new_page,
    _it_max_page
){

    var _it_old_page =
        _it_page;

    _it_page =
        clamp(
            _it_new_page,
            0,
            max(
                0,
                _it_max_page
            )
        );

    if (
        _it_page !=
        _it_old_page
    ){

        hscr_cheats_log(
            "PAGE CHANGED",
            "PAGE: " +
            string(
                _it_page + 1
            ) +
            "/" +
            string(
                _it_max_page + 1
            )
        );

        return true;
    }

//================//
//PAGE LIMIT//
//================//
// Intentionally silent.
// W/S, arrows, and mouse wheel can continue being used
// against the first/last page without playing an error.
    return false;
};
//-------------------------------------------------------------------------------//
// HSCR_CHEATS_CHANGE_TAB
//-------------------------------------------------------------------------------//
hscr_cheats_change_tab = function(_val_direction){

    if (!_flag_authenticated || _str_state != "MENU"){
        return false;
    }

    _it_tab += _val_direction;

    if (_it_tab < 0){
        _it_tab = array_length(_arr_tabs) - 1;
    }

    if (_it_tab >= array_length(_arr_tabs)){
        _it_tab = 0;
    }

    _it_page = 0;
    _it_submenu = 0;

    audio_play_sound(snd_gui_press,0,false);

    hscr_cheats_log(
        "TAB CHANGED",
        "TAB: " + _arr_tabs[_it_tab]
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_START_TOOL
//-------------------------------------------------------------------------------//
hscr_cheats_start_tool = function(
    _str_new_tool,
    _str_new_label,
    _str_new_target_type,
    _str_id=""
){

    _str_state = "TOOL";

    _str_tool = _str_new_tool;
    _str_tool_label = _str_new_label;
    _str_tool_target_type = _str_new_target_type;

    _str_selected_id = _str_id;

    hscr_cheats_log(
        "TOOL START",
        "TOOL: " + string_upper(_str_tool) +
        " | TARGET: " + string_upper(_str_tool_target_type) +
        ((_str_selected_id != "")
            ? " | ID: " + string_upper(_str_selected_id)
            : "")
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_CANCEL_TOOL
//-------------------------------------------------------------------------------//
hscr_cheats_cancel_tool = function(){

    if (_str_state != "TOOL"){
        return false;
    }

    var _str_old_tool = _str_tool;

    _str_state = "MENU";
    _str_tool = "";
    _str_tool_label = "";
    _str_tool_target_type = "";
    _str_selected_id = "";

    audio_play_sound(snd_gui_close,0,false);

    hscr_cheats_log(
        "TOOL CANCEL",
        "TOOL: " + string_upper(_str_old_tool)
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_SUBMIT_PASSWORD
//-------------------------------------------------------------------------------//
hscr_cheats_submit_password = function(){

    _str_password = keyboard_string;

    if (string_upper(_str_password) == _str_password_correct){

        _flag_authenticated = true;
        _flag_password_entry = false;

        keyboard_string = "";

        audio_play_sound(snd_gui_press,0,false);

        hscr_cheats_log("AUTHENTICATION SUCCESS");

        return true;
    }

    audio_play_sound(snd_gui_error,0,false);

    keyboard_string = "";
    _str_password = "";

    hscr_cheats_log("AUTHENTICATION FAILED");

    return false;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_ADD_BEAST
// FUNCTION: Creates a fully initialized Beast and adds it to Party or Ranch.
//           PARTY automatically routes to Ranch if the Party is full.
//-------------------------------------------------------------------------------//
hscr_cheats_add_beast = function(
    _str_beast_id,
    _str_destination
){

//================//
//INITIALIZE BEAST//
//================//
    var _stct_beast =
        scr_beast_init_random(
            _str_beast_id
        );

    if (!is_struct(_stct_beast)){

        audio_play_sound(
            snd_gui_error,
            0,
            false
        );

        hscr_cheats_log(
            "BEAST ADD FAILED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REASON: INITIALIZATION FAILED"
        );

        return false;
    }

//================//
//PARTY//
//================//
    if (_str_destination == "PARTY"){

        var _flag_added =
            scr_party_add_beast(
                _stct_beast
            );

        if (!_flag_added){

            audio_play_sound(
                snd_gui_error,
                0,
                false
            );

            hscr_cheats_log(
                "BEAST ADD FAILED",
                "BEAST: " +
                string_upper(
                    _str_beast_id
                ) +
                " | REQUESTED: PARTY"
            );

            return false;
        }

//----------------//
//RANCH DUMMY//
//----------------//
        if (
            room == rm_ow_ranch &&
            instance_exists(
                obj_ranch_interactable
            ) &&
            ds_exists(
                global.list_player_ranch,
                ds_type_list
            ) &&
            ds_list_find_index(
                global.list_player_ranch,
                _stct_beast
            ) != -1
        ){

            obj_ranch_interactable
                .hscr_ranch_spawn_beast_dummy(
                    _stct_beast
                );
        }

//----------------//
//SOUND//
//----------------//
        audio_play_sound(
            snd_gui_press,
            0,
            false
        );

//----------------//
//DEBUG//
//----------------//
        var _str_actual_destination =
            (
                ds_exists(
                    global.list_player_party,
                    ds_type_list
                ) &&
                ds_list_find_index(
                    global.list_player_party,
                    _stct_beast
                ) != -1
            )
            ? "PARTY"
            : "RANCH";

        hscr_cheats_log(
            "BEAST ADDED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REQUESTED: PARTY" +
            " | DESTINATION: " +
            _str_actual_destination +
            " | TYPE: " +
            string_upper(
                _stct_beast
                    ._str_beast_color_type
            ) +
            " | LEVEL: " +
            string(
                _stct_beast
                    ._val_beast_level
            ) +
            " | UID: " +
            string(
                _stct_beast
                    ._uid_beast
            )
        );

        return true;
    }

//================//
//RANCH//
//================//
    if (_str_destination == "RANCH"){

        if (
            !variable_global_exists(
                "list_player_ranch"
            ) ||
            !ds_exists(
                global.list_player_ranch,
                ds_type_list
            )
        ){

            audio_play_sound(
                snd_gui_error,
                0,
                false
            );

            hscr_cheats_log(
                "BEAST ADD FAILED",
                "BEAST: " +
                string_upper(
                    _str_beast_id
                ) +
                " | DESTINATION: RANCH" +
                " | REASON: RANCH LIST INVALID"
            );

            return false;
        }

//----------------//
//ADD TO RANCH//
//----------------//
        ds_list_add(
            global.list_player_ranch,
            _stct_beast
        );

//----------------//
//LOGBOOK//
//----------------//
        if (
            variable_global_exists(
                "map_logbook_beasts"
            ) &&
            ds_exists(
                global.map_logbook_beasts,
                ds_type_map
            )
        ){

            scr_logbook_mark_beast_captured(
                _stct_beast
                    ._str_beast_name
            );
        }

//----------------//
//RANCH DUMMY//
//----------------//
        if (
            room == rm_ow_ranch &&
            instance_exists(
                obj_ranch_interactable
            )
        ){

            obj_ranch_interactable
                .hscr_ranch_spawn_beast_dummy(
                    _stct_beast
                );
        }

//----------------//
//SOUND//
//----------------//
        audio_play_sound(
            snd_gui_press,
            0,
            false
        );

//----------------//
//DEBUG//
//----------------//
        hscr_cheats_log(
            "BEAST ADDED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | DESTINATION: RANCH" +
            " | TYPE: " +
            string_upper(
                _stct_beast
                    ._str_beast_color_type
            ) +
            " | LEVEL: " +
            string(
                _stct_beast
                    ._val_beast_level
            ) +
            " | UID: " +
            string(
                _stct_beast
                    ._uid_beast
            )
        );

        return true;
    }

//================//
//INVALID DESTINATION//
//================//
    audio_play_sound(
        snd_gui_error,
        0,
        false
    );

    hscr_cheats_log(
        "BEAST ADD FAILED",
        "BEAST: " +
        string_upper(
            _str_beast_id
        ) +
        " | INVALID DESTINATION: " +
        string_upper(
            _str_destination
        )
    );

    return false;
};
//-------------------------------------------------------------------------------//
// HSCR_CHEATS_ADD_CARD
//-------------------------------------------------------------------------------//
hscr_cheats_add_card = function(_str_card_id,_str_destination){

    var _stct_card = scr_card_get_info(_str_card_id);

    if (
        !is_struct(_stct_card) ||
        _stct_card._str_card_name == "DEFAULT"
    ){
        return false;
    }

    if (_str_destination == "DECK"){

        if (ds_list_size(global.list_player_deck) >= 30){
            audio_play_sound(snd_gui_error,0,false);
            return false;
        }

        ds_list_add(
            global.list_player_deck,
            _stct_card
        );
    }
    else{

        ds_list_add(
            global.list_player_library,
            _stct_card
        );
    }

    if (
        variable_global_exists("map_logbook_cards") &&
        ds_exists(global.map_logbook_cards,ds_type_map)
    ){
        scr_logbook_mark_card_obtained(_str_card_id);
    }

    audio_play_sound(snd_battle_card_move,0,false);

    hscr_cheats_log(
        "CARD ADDED",
        "CARD: " + _str_card_id +
        " | DESTINATION: " + _str_destination
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_ADD_ITEM
//-------------------------------------------------------------------------------//
hscr_cheats_add_item = function(_str_item_id){

    var _stct_item =
        scr_inventory_get_item_info(_str_item_id);

    if (_stct_item == undefined){
        return false;
    }

    scr_inventory_add_item(
        _str_item_id,
        1
    );

    audio_play_sound(snd_gui_press,0,false);

    hscr_cheats_log(
        "ITEM ADDED",
        "ITEM: " + _str_item_id
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_PARTY_LEVEL
//-------------------------------------------------------------------------------//
hscr_cheats_party_level = function(_stct_beast,_val_change){

    if (!is_struct(_stct_beast)){
        return hscr_cheats_error("PARTY LEVEL FAILED","INVALID BEAST");
    }

    var _val_old = _stct_beast._val_beast_level;
    var _val_new = clamp(_val_old + _val_change,1,30);

    if (_val_new == _val_old){
        return hscr_cheats_error(
            "PARTY LEVEL CAPPED",
            "BEAST: " + string_upper(_stct_beast._str_beast_name) +
            " | LEVEL: " + string(_val_old)
        );
    }

    scr_beast_set_level(_stct_beast,_val_new,false);
    audio_play_sound(snd_gui_press,0,false);

    hscr_cheats_log(
        "PARTY LEVEL CHANGED",
        "BEAST: " + string_upper(_stct_beast._str_beast_name) +
        " | LEVEL: " + string(_val_old) + " -> " + string(_val_new)
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_PARTY_HEAL
//-------------------------------------------------------------------------------//
hscr_cheats_party_heal = function(_stct_beast){

    if (!is_struct(_stct_beast)){
        return hscr_cheats_error("PARTY HEAL FAILED","INVALID BEAST");
    }

    if (_stct_beast._val_beast_hp_cur >= _stct_beast._val_beast_hp_max){
        return hscr_cheats_error(
            "PARTY HEAL CAPPED",
            "BEAST: " + string_upper(_stct_beast._str_beast_name) + " | HP ALREADY FULL"
        );
    }

    _stct_beast._val_beast_hp_cur = _stct_beast._val_beast_hp_max;
    audio_play_sound(snd_battle_heal,0,false);

    hscr_cheats_log("PARTY HEALED","BEAST: " + string_upper(_stct_beast._str_beast_name));
    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_BATTLE_TARGET
// FUNCTION: Returns Beast or Minion under mouse.
//-------------------------------------------------------------------------------//
hscr_cheats_get_battle_target = function(_flag_allow_dead=true){

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    var _ref_minion =
        instance_position(
            _mx,
            _my,
            obj_battle_minion
        );

    if (instance_exists(_ref_minion)){
        return _ref_minion;
    }

    var _ref_beast =
        instance_position(
            _mx,
            _my,
            obj_battle_beast
        );

    if (!instance_exists(_ref_beast)){
        return undefined;
    }

    if (
        !_flag_allow_dead &&
        _ref_beast._val_cur_hp <= 0
    ){
        return undefined;
    }

    return _ref_beast;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_BATTLE_HEAL
//-------------------------------------------------------------------------------//
hscr_cheats_battle_heal = function(_ref_target,_val_amount){

    if (!instance_exists(_ref_target)){
        return hscr_cheats_error("TARGET HEAL FAILED","INVALID TARGET");
    }

    if (_ref_target._val_cur_hp <= 0){
        return hscr_cheats_error("TARGET HEAL FAILED","TARGET IS DEAD");
    }

    if (_ref_target._val_cur_hp >= _ref_target._val_max_hp){
        return hscr_cheats_error("TARGET HEAL CAPPED","HP ALREADY FULL");
    }

    var _val_before = _ref_target._val_cur_hp;

    if (_val_amount == -1){
        _ref_target._val_cur_hp = _ref_target._val_max_hp;
    }
    else{
        _ref_target._val_cur_hp = min(_ref_target._val_max_hp,_ref_target._val_cur_hp + _val_amount);
    }

    audio_play_sound(snd_battle_heal,0,false);
    hscr_cheats_log("TARGET HEALED","HP: " + string(_val_before) + " -> " + string(_ref_target._val_cur_hp));
    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_BATTLE_DAMAGE
//-------------------------------------------------------------------------------//
hscr_cheats_battle_damage = function(_ref_target,_val_amount){

    if (!instance_exists(_ref_target)){
        return hscr_cheats_error("TARGET DAMAGE FAILED","INVALID TARGET");
    }

    if (_ref_target._val_cur_hp <= 0){
        return hscr_cheats_error("TARGET DAMAGE CAPPED","TARGET IS ALREADY DEAD");
    }

    var _val_before = _ref_target._val_cur_hp;

    if (_val_amount == -1){
        _ref_target._val_cur_hp = 0;
    }
    else{
        _ref_target._val_cur_hp = max(0,_ref_target._val_cur_hp - _val_amount);
    }

    audio_play_sound(snd_battle_hit_neu,0,false);
    hscr_cheats_log("TARGET DAMAGED","HP: " + string(_val_before) + " -> " + string(_ref_target._val_cur_hp));
    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_RESURRECT
//-------------------------------------------------------------------------------//
hscr_cheats_resurrect = function(_ref_target){

    if (!instance_exists(_ref_target)){
        return hscr_cheats_error("RESURRECT FAILED","INVALID TARGET");
    }

    if (!variable_instance_exists(_ref_target,"_str_list")){
        return hscr_cheats_error("RESURRECT FAILED","TARGET CANNOT BE RESURRECTED");
    }

    if (_ref_target._str_list != "DEAD" || _ref_target._val_cur_hp > 0){
        return hscr_cheats_error("RESURRECT CAPPED","TARGET IS ALREADY ALIVE");
    }

    var _ref_controller = (_ref_target._str_team == "PLAYER") ? obj_battle_player_controller : obj_battle_enemy_controller;
    if (!instance_exists(_ref_controller)){
        return hscr_cheats_error("RESURRECT FAILED","MISSING TEAM CONTROLLER");
    }

    var _it_dead = ds_list_find_index(_ref_controller._list_beasts_graveyard,_ref_target);
    if (_it_dead != -1){
        ds_list_delete(_ref_controller._list_beasts_graveyard,_it_dead);
    }

    if (ds_list_find_index(_ref_controller._list_beasts_alive,_ref_target) == -1){
        ds_list_add(_ref_controller._list_beasts_alive,_ref_target);
    }

    _ref_target._val_cur_hp = max(1,ceil(_ref_target._val_max_hp * 0.25));
    _ref_target._str_list = "ALIVE";
    _ref_target._flag_death_handled = false;
    _ref_target._flag_corpse_consumed = false;

    scr_battle_refresh_formation(_ref_target._str_team);
    audio_play_sound(snd_battle_heal,0,false);

    hscr_cheats_log("TARGET RESURRECTED","TEAM: " + _ref_target._str_team);
    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_BATTLE_LEVEL
//-------------------------------------------------------------------------------//
hscr_cheats_battle_level = function(_ref_target,_val_change){

    if (!instance_exists(_ref_target)){
        return hscr_cheats_error("TARGET LEVEL FAILED","INVALID TARGET");
    }

    if (!is_struct(_ref_target._ref_unit)){
        return hscr_cheats_error("TARGET LEVEL FAILED","TARGET HAS NO BEAST STRUCT");
    }

    var _val_old_level = _ref_target._ref_unit._val_beast_level;
    var _val_new_level = clamp(_val_old_level + _val_change,1,30);

    if (_val_new_level == _val_old_level){
        return hscr_cheats_error("TARGET LEVEL CAPPED","LEVEL: " + string(_val_old_level));
    }

    var _val_ratio = clamp(_ref_target._val_cur_hp / max(1,_ref_target._val_max_hp),0,1);
    scr_beast_set_level(_ref_target._ref_unit,_val_new_level,false);

    _ref_target._val_max_hp = _ref_target._ref_unit._val_beast_hp_max;
    _ref_target._val_cur_hp = clamp(ceil(_ref_target._val_max_hp * _val_ratio),0,_ref_target._val_max_hp);
    _ref_target._ref_unit._val_beast_hp_cur = _ref_target._val_cur_hp;

    audio_play_sound(snd_gui_press,0,false);
    hscr_cheats_log("TARGET LEVEL CHANGED","LEVEL: " + string(_val_old_level) + " -> " + string(_val_new_level));
    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_APPLY_STATUS
//-------------------------------------------------------------------------------//
hscr_cheats_apply_status = function(
    _ref_target,
    _str_category,
    _str_status
){

    if (!instance_exists(_ref_target)){
        return false;
    }

    if (!is_struct(_ref_target._ref_unit)){
        return false;
    }

    var _ref_status = undefined;

    switch (_str_category){

        case "DOT":
            _ref_status =
                scr_status_apply_dot(
                    _str_status,
                    _ref_target
                );
        break;

        case "CC":
            _ref_status =
                scr_status_apply_cc(
                    _str_status,
                    _ref_target,
                    undefined,
                    true
                );
        break;

        case "DEBUFF":
            _ref_status =
                scr_status_apply_debuff(
                    _str_status,
                    _ref_target,
                    undefined,
                    undefined,
                    true
                );
        break;

        case "BUFF":
            _ref_status =
                scr_status_apply_buff(
                    _str_status,
                    _ref_target
                );
        break;
    }

    if (instance_exists(_ref_status)){

        audio_play_sound(snd_gui_press,0,false);

        hscr_cheats_log(
            "STATUS APPLIED",
            "STATUS: " + _str_status
        );

        return true;
    }

    return hscr_cheats_error("STATUS APPLY FAILED","STATUS: " + _str_status);
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_CLEANSE
//-------------------------------------------------------------------------------//
hscr_cheats_cleanse = function(
    _ref_target,
    _str_filter,
    _str_mode,
    _var_amount
){

    if (!instance_exists(_ref_target)){
        return false;
    }

    if (!variable_instance_exists(_ref_target,"_list_statuses")){
        return false;
    }

    var _stct_result =
        scr_status_cleanse(
            _ref_target,
            _str_filter,
            _var_amount,
            {
                _str_mode: _str_mode,
                _flag_ignore_uncleansable: false,
                _flag_show_popups: true,
                _flag_force_vfx: true
            }
        );

    if (
        _stct_result._ct_statuses_removed <= 0 &&
        _stct_result._ct_stacks_removed <= 0
    ){
        return hscr_cheats_error("TARGET CLEANSE CAPPED","NOTHING MATCHING TO CLEANSE");
    }

    audio_play_sound(snd_battle_heal,0,false);

    hscr_cheats_log(
        "TARGET CLEANSED",
        "FILTER: " + _str_filter +
        " | STATUSES: " +
        string(_stct_result._ct_statuses_removed) +
        " | STACKS: " +
        string(_stct_result._ct_stacks_removed)
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_SPAWN_MINION
//-------------------------------------------------------------------------------//
hscr_cheats_spawn_minion = function(
    _ref_target,
    _str_minion
){

    if (!instance_exists(_ref_target)){
        return false;
    }

    if (!is_struct(_ref_target._ref_unit)){
        return false;
    }

    var _ref_minion =
        scr_minion_init(
            _str_minion,
            undefined,
            undefined,
            _ref_target
        );

    if (!instance_exists(_ref_minion)){
        return hscr_cheats_error("MINION SPAWN FAILED","MINION: " + _str_minion);
    }

    audio_play_sound(snd_battle_minion_spawn,0,false);

    hscr_cheats_log(
        "MINION SPAWNED",
        "MINION: " + _str_minion
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_MOVE_HAND_CARD
// FUNCTION: Moves one selected player Hand Card directly to Discard or Exhaust
//           using the normal shared battle Card-flow implementation.
//-------------------------------------------------------------------------------//
hscr_cheats_move_hand_card = function(
    _ref_card,
    _str_destination
){

//================//
//VALIDATE CARD//
//================//
    if (
        !instance_exists(
            _ref_card
        )
    ){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "INVALID CARD"
        );
    }

    if (
        !is_struct(
            _ref_card._ref_card
        )
    ){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "CARD HAS NO CARD STRUCT"
        );
    }

//================//
//VALIDATE HAND CARD//
//================//
    if (
        _ref_card._str_team != "PLAYER" ||
        _ref_card._str_location != "HAND"
    ){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "TARGET IS NOT A PLAYER HAND CARD"
        );
    }

//================//
//VALIDATE CONTROLLER//
//================//
    if (
        !instance_exists(
            obj_battle_player_controller
        )
    ){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "PLAYER BATTLE CONTROLLER MISSING"
        );
    }

    if (
        !ds_exists(
            obj_battle_player_controller
                ._list_battle_hand,
            ds_type_list
        )
    ){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "PLAYER HAND INVALID"
        );
    }

    if (
        ds_list_find_index(
            obj_battle_player_controller
                ._list_battle_hand,
            _ref_card
        ) == -1
    ){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "CARD NOT FOUND IN PLAYER HAND"
        );
    }

//================//
//CARD NAME//
//================//
    var _str_card_name =
        string_upper(
            _ref_card
                ._ref_card
                ._str_card_name
        );

//================//
//MOVE CARD//
//================//
    var _flag_moved =
        false;

    switch (
        string_upper(
            _str_destination
        )
    ){

//----------------//
//DISCARD//
//----------------//
        case "DISCARD":

            _flag_moved =
                scr_battle_discard_card(
                    _ref_card
                );

        break;

//----------------//
//EXHAUST//
//----------------//
        case "EXHAUST":

            _flag_moved =
                scr_battle_exhaust_card(
                    _ref_card
                );

        break;

//----------------//
//INVALID//
//----------------//
        default:

            return hscr_cheats_error(
                "CARD MOVE FAILED",
                "INVALID DESTINATION: " +
                string_upper(
                    _str_destination
                )
            );
    }

//================//
//VALIDATE MOVE//
//================//
    if (!_flag_moved){

        return hscr_cheats_error(
            "CARD MOVE FAILED",
            "CARD: " +
            _str_card_name +
            " | DESTINATION: " +
            string_upper(
                _str_destination
            )
        );
    }

//================//
//SOUND//
//================//
    audio_play_sound(
        snd_battle_card_move,
        0,
        false
    );

//================//
//DEBUG//
//================//
    hscr_cheats_log(
        "HAND CARD MOVED",
        "CARD: " +
        _str_card_name +
        " | DESTINATION: " +
        string_upper(
            _str_destination
        )
    );

    return true;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_SPAWN_WILD
// FUNCTION: Spawns a fully initialized visible wild Beast at the selected
//           world-space mouse position.
//
//           Encounter pool priority:
//           1. Closest overworld encounter zone.
//           2. Every valid Beast in the Logbook as a random fallback.
//
//           The selected cheat Beast remains the forced slot-0 enemy.
//           Its encounter pool supplies the remaining enemy slots.
//-------------------------------------------------------------------------------//
hscr_cheats_spawn_wild = function(
    _str_beast_id
){

//================//
//VALIDATE ROOM//
//================//
    if (room == rm_battle){

        audio_play_sound(
            snd_gui_error,
            0,
            false
        );

        hscr_cheats_log(
            "WILD BEAST SPAWN FAILED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REASON: BATTLE ROOM"
        );

        return false;
    }

//================//
//VALIDATE PLAYER//
//================//
    if (
        !instance_exists(
            obj_player
        )
    ){

        audio_play_sound(
            snd_gui_error,
            0,
            false
        );

        hscr_cheats_log(
            "WILD BEAST SPAWN FAILED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REASON: PLAYER MISSING"
        );

        return false;
    }

//================//
//GUI MOUSE POSITION//
//================//
    var _val_mouse_gui_x =
        device_mouse_x_to_gui(0);

    var _val_mouse_gui_y =
        device_mouse_y_to_gui(0);

//================//
//WORLD POSITION//
//================//
    var _val_spawn_x =
        _val_mouse_gui_x;

    var _val_spawn_y =
        _val_mouse_gui_y;

//----------------//
//CONVERT THROUGH CAMERA//
//----------------//
    if (
        global.ref_camera != undefined
    ){

        var _val_camera_x =
            camera_get_view_x(
                global.ref_camera
            );

        var _val_camera_y =
            camera_get_view_y(
                global.ref_camera
            );

        var _val_camera_w =
            camera_get_view_width(
                global.ref_camera
            );

        var _val_camera_h =
            camera_get_view_height(
                global.ref_camera
            );

        var _val_gui_w =
            max(
                1,
                display_get_gui_width()
            );

        var _val_gui_h =
            max(
                1,
                display_get_gui_height()
            );

        _val_spawn_x =
            _val_camera_x +
            (
                _val_mouse_gui_x /
                _val_gui_w
            ) *
            _val_camera_w;

        _val_spawn_y =
            _val_camera_y +
            (
                _val_mouse_gui_y /
                _val_gui_h
            ) *
            _val_camera_h;
    }

//================//
//CLAMP TO ROOM//
//================//
    _val_spawn_x =
        clamp(
            _val_spawn_x,
            0,
            room_width
        );

    _val_spawn_y =
        clamp(
            _val_spawn_y,
            0,
            room_height
        );

//================//
//PLAYER DISTANCE//
//================//
    if (
        point_distance(
            _val_spawn_x,
            _val_spawn_y,
            obj_player.x,
            obj_player.y
        ) < 50
    ){

        audio_play_sound(
            snd_gui_error,
            0,
            false
        );

        hscr_cheats_log(
            "WILD BEAST SPAWN FAILED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REASON: TOO CLOSE TO PLAYER"
        );

        return false;
    }

//================//
//INITIALIZE BEAST//
//================//
    var _stct_unit =
        scr_beast_init_random(
            _str_beast_id
        );

    if (!is_struct(_stct_unit)){

        audio_play_sound(
            snd_gui_error,
            0,
            false
        );

        hscr_cheats_log(
            "WILD BEAST SPAWN FAILED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REASON: BEAST INITIALIZATION FAILED"
        );

        return false;
    }

//===============================================================================//
// ENCOUNTER POOL
//===============================================================================//

    var _arr_encounter_pool = [];

    var _str_pool_source =
        "RANDOM ALL";

    var _ref_nearest_zone =
        noone;

//================//
//FIND CLOSEST ZONE//
//================//
    if (
        instance_exists(
            obj_overworld_encounter_zone
        )
    ){

        _ref_nearest_zone =
            instance_nearest(
                _val_spawn_x,
                _val_spawn_y,
                obj_overworld_encounter_zone
            );
    }

//================//
//USE ZONE POOL//
//================//
    if (
        instance_exists(
            _ref_nearest_zone
        ) &&
        variable_instance_exists(
            _ref_nearest_zone,
            "_arr_encounter_beasts"
        ) &&
        is_array(
            _ref_nearest_zone
                ._arr_encounter_beasts
        ) &&
        array_length(
            _ref_nearest_zone
                ._arr_encounter_beasts
        ) > 0
    ){

        _arr_encounter_pool =
            _ref_nearest_zone
                ._arr_encounter_beasts;

        _str_pool_source =
            "CLOSEST ZONE";
    }

//================//
//RANDOM ALL FALLBACK//
//================//
    else{

        if (
            variable_global_exists(
                "list_logbook_beasts"
            ) &&
            ds_exists(
                global.list_logbook_beasts,
                ds_type_list
            )
        ){

            for (
                var _it_beast = 0;
                _it_beast <
                ds_list_size(
                    global.list_logbook_beasts
                );
                _it_beast++
            ){

                var _stct_entry =
                    ds_list_find_value(
                        global.list_logbook_beasts,
                        _it_beast
                    );

                if (
                    !is_struct(
                        _stct_entry
                    )
                ){
                    continue;
                }

                if (
                    !variable_struct_exists(
                        _stct_entry,
                        "_str_beast_id"
                    )
                ){
                    continue;
                }

                var _str_pool_beast =
                    _stct_entry
                        ._str_beast_id;

                if (
                    !is_string(
                        _str_pool_beast
                    ) ||
                    _str_pool_beast == ""
                ){
                    continue;
                }

                array_push(
                    _arr_encounter_pool,
                    _str_pool_beast
                );
            }
        }
    }

//================//
//FINAL FALLBACK//
//================//
    if (
        array_length(
            _arr_encounter_pool
        ) <= 0
    ){

        _arr_encounter_pool = [
            _str_beast_id
        ];

        _str_pool_source =
            "SELF FALLBACK";
    }

//===============================================================================//
// CREATE WILD BEAST
//===============================================================================//

    var _ref_beast =
        instance_create_layer(
            _val_spawn_x,
            _val_spawn_y,
            "ily_npcs",
            obj_overworld_beast
        );

    if (
        !instance_exists(
            _ref_beast
        )
    ){

        audio_play_sound(
            snd_gui_error,
            0,
            false
        );

        hscr_cheats_log(
            "WILD BEAST SPAWN FAILED",
            "BEAST: " +
            string_upper(
                _str_beast_id
            ) +
            " | REASON: INSTANCE CREATION FAILED"
        );

        return false;
    }

//================//
//ASSIGN BEAST DATA//
//================//
    _ref_beast._str_team =
        "WILD";

    _ref_beast._stct_unit =
        _stct_unit;

//================//
//ASSIGN POOL//
//================//
    _ref_beast._arr_encounter_pool =
        _arr_encounter_pool;

//================//
//HOME POSITION//
//================//
    _ref_beast._ref_home =
        noone;

    _ref_beast._val_home_x =
        _val_spawn_x;

    _ref_beast._val_home_y =
        _val_spawn_y;

//================//
//ASSIGN VISUALS//
//================//
    _ref_beast._spr_beast =
        _stct_unit._spr_beast;

    _ref_beast._spr_shadow =
        scr_beast_get_type_shadow(
            _stct_unit
                ._str_beast_color_type
        );

//================//
//SOUND//
//================//
    audio_play_sound(
        snd_battle_minion_spawn,
        0,
        false
    );

//================//
//DEBUG//
//================//
    var _str_zone_details = "";

    if (
        instance_exists(
            _ref_nearest_zone
        ) &&
        _str_pool_source ==
        "CLOSEST ZONE"
    ){

        _str_zone_details =
            " | ZONE DISTANCE: " +
            string(
                round(
                    point_distance(
                        _val_spawn_x,
                        _val_spawn_y,
                        _ref_nearest_zone.x,
                        _ref_nearest_zone.y
                    )
                )
            );
    }

    hscr_cheats_log(
        "WILD BEAST SPAWNED",
        "BEAST: " +
        string_upper(
            _str_beast_id
        ) +
        " | TYPE: " +
        string_upper(
            _stct_unit
                ._str_beast_color_type
        ) +
        " | LEVEL: " +
        string(
            _stct_unit
                ._val_beast_level
        ) +
        " | UID: " +
        string(
            _stct_unit
                ._uid_beast
        ) +
        " | POSITION: (" +
        string(
            round(
                _val_spawn_x
            )
        ) +
        "," +
        string(
            round(
                _val_spawn_y
            )
        ) +
        ")" +
        " | POOL SOURCE: " +
        _str_pool_source +
        " | POOL SIZE: " +
        string(
            array_length(
                _arr_encounter_pool
            )
        ) +
        _str_zone_details
    );

    return true;
};
//-------------------------------------------------------------------------------//
// HSCR_CHEATS_END_BATTLE
//-------------------------------------------------------------------------------//
hscr_cheats_end_battle = function(_str_result){

    if (
        room != rm_battle ||
        !instance_exists(obj_battle_turn_controller)
    ){
        return false;
    }

    if (instance_exists(obj_gui_end_battle_pane)){
        return false;
    }

    obj_battle_turn_controller._flag_battle_ended = true;

    obj_battle_player_controller._state_player =
        ENUM_PLAYER_STATE.WAIT;

    obj_battle_enemy_controller._state_enemy =
        ENUM_ENEMY_STATE.WAIT;

    var _ref_end =
        instance_create_layer(
            room_width * 0.5,
            room_height * 0.5,
            "ily_fx",
            obj_gui_end_battle_pane
        );

    _ref_end._str_condition = _str_result;

    hscr_cheats_log(
        "BATTLE FORCE ENDED",
        "RESULT: " + _str_result
    );

    obj_gui_controller.hscr_gui_destroy_active(
        "CHEAT BATTLE END"
    );

    obj_gui_controller.hscr_gui_set_pause(
        false,
        "CHEAT BATTLE END"
    );

    return true;
};

#endregion

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_COLOR
// FUNCTION: Returns the display color used for Beast/Card color groups.
//-------------------------------------------------------------------------------//
hscr_cheats_get_color = function(_str_color){

    switch (string_upper(_str_color)){

        case "VERMILION":
            return c_red;

        case "CERULEAN":
            return c_blue;

        case "VIRIDIAN":
            return c_green;

        case "UNCOLORED":
            return c_gray;
    }

    return c_gray;
};

//-------------------------------------------------------------------------------//
// HSCR_CHEATS_GET_ITEM_COLOR
// FUNCTION: Mirrors the inventory GUI item-type color scheme.
//-------------------------------------------------------------------------------//
hscr_cheats_get_item_color = function(_str_item_type){

    switch (string_upper(_str_item_type)){

        case "QUEST":
            return c_yellow;

        case "CONSUMABLE":
            return c_green;

        case "PRISM":
            return c_aqua;

        case "HELD":
            return make_colour_rgb(
                255,
                140,
                0
            );

        case "EGG":
            return make_colour_rgb(
                180,
                100,
                255
            );
    }

    return global.c_dk_gray;
};