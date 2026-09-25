//===============================================================================//
//
// DRAW GUI: OBJ_GUI_CHEATS_PANE
// FUNCTION: Draws the complete developer Cheats Menu using pane-relative
//           coordinates sized for the reduced 100 px inset window.
//
//===============================================================================//

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

//================//
//LOCAL LAYOUT//
//================//
var _val_left =
    _val_content_x1;

var _val_right =
    _val_content_x2;

var _val_top =
    _val_content_y1;

var _val_bottom =
    _val_content_y2;

var _val_footer_y =
    _val_pane_y2 -
    _val_footer_h +
    7;

var _c_party_background =
    make_colour_rgb(
        18,
        32,
        58
    );

//===============================================================================//
// TOOL MODE
//===============================================================================//
if (_str_state == "TOOL"){

    var _mx =
        device_mouse_x_to_gui(0);

    var _my =
        device_mouse_y_to_gui(0);

    draw_set_font(
        fnt_gui_party_small
    );

    var _val_tool_w =
        string_width(
            _str_tool_label
        ) + 20;

    draw_set_colour(c_black);

    draw_rectangle(
        _mx + 12,
        _my + 12,
        _mx + 12 + _val_tool_w,
        _my + 40,
        false
    );

    draw_set_colour(c_white);

    draw_rectangle(
        _mx + 12,
        _my + 12,
        _mx + 12 + _val_tool_w,
        _my + 40,
        true
    );

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    draw_text(
        _mx + 20,
        _my + 19,
        _str_tool_label
    );

    draw_set_colour(c_ltgray);

    draw_text(
        _mx + 20,
        _my + 45,
        "LMB: APPLY   RMB: RETURN"
    );

    draw_set_colour(c_white);

    exit;
}

//===============================================================================//
// PANE
//===============================================================================//

//================//
//BACKGROUND//
//================//
draw_set_colour(c_black);

draw_rectangle(
    _val_pane_x1,
    _val_pane_y1,
    _val_pane_x2,
    _val_pane_y2,
    false
);

draw_set_colour(c_white);

draw_rectangle(
    _val_pane_x1,
    _val_pane_y1,
    _val_pane_x2,
    _val_pane_y2,
    true
);

//================//
//HEADER//
//================//
draw_set_font(fnt_gui_medium);
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(
    _val_pane_x1 +
    (_val_pane_w * 0.5),
    _val_pane_y1 +
    (_val_header_h * 0.5),
    "CHEATS - " +
    _str_mode
);

//===============================================================================//
// PASSWORD
//===============================================================================//
if (_flag_password_entry){

    var _str_hidden = "";

    for (
        var _i = 0;
        _i < string_length(
            _str_password
        );
        _i++
    ){
        _str_hidden += "*";
    }

    var _val_password_x =
        _val_pane_x1 +
        (_val_pane_w * 0.5);

    var _val_password_y =
        _val_pane_y1 +
        (_val_pane_h * 0.5);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_font(fnt_gui_medium);
    draw_set_colour(c_white);

    draw_text(
        _val_password_x,
        _val_password_y - 55,
        "TESTER PASSWORD"
    );

    draw_set_colour(
        global.c_dk_gray
    );

    draw_rectangle(
        _val_password_x - 145,
        _val_password_y - 18,
        _val_password_x + 145,
        _val_password_y + 20,
        false
    );

    draw_set_colour(c_white);

    draw_rectangle(
        _val_password_x - 145,
        _val_password_y - 18,
        _val_password_x + 145,
        _val_password_y + 20,
        true
    );

    draw_text(
        _val_password_x,
        _val_password_y + 1,
        _str_hidden
    );

    draw_set_font(
        fnt_gui_party_small
    );

    draw_text(
        _val_password_x,
        _val_password_y + 48,
        "ENTER TO CONFIRM"
    );

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    exit;
}

//===============================================================================//
// TABS
//===============================================================================//

var _ct_tabs =
    array_length(
        _arr_tabs
    );

var _val_tab_w =
    _val_pane_w /
    _ct_tabs;

var _val_tab_mouse_x =
    device_mouse_x_to_gui(0);

var _val_tab_mouse_y =
    device_mouse_y_to_gui(0);

for (
    var _t = 0;
    _t < _ct_tabs;
    _t++
){

    var _x1 =
        _val_pane_x1 +
        (_t * _val_tab_w);

    var _x2 =
        _x1 +
        _val_tab_w;

//================//
//HOVER//
//================//
    var _flag_tab_hover =
        hscr_cheats_point_in_rect(
            _val_tab_mouse_x,
            _val_tab_mouse_y,
            _x1,
            _val_tab_y1,
            _x2,
            _val_tab_y2
        );

//================//
//LEFT CLICK TAB//
//================//
    if (
        _flag_tab_hover &&
        _t != _it_tab &&
        mouse_check_button_pressed(
            mb_left
        )
    ){

        hscr_cheats_change_tab(
            _t - _it_tab
        );
    }

//================//
//TAB BACKGROUND//
//================//
    if (_t == _it_tab){

        draw_set_colour(
            c_gray
        );
    }
    else if (_flag_tab_hover){

        draw_set_colour(
            c_ltgray
        );
    }
    else{

        draw_set_colour(
            global.c_dk_gray
        );
    }

    draw_rectangle(
        _x1,
        _val_tab_y1,
        _x2,
        _val_tab_y2,
        false
    );

//================//
//TAB BORDER//
//================//
    draw_set_colour(c_white);

    draw_rectangle(
        _x1,
        _val_tab_y1,
        _x2,
        _val_tab_y2,
        true
    );

//================//
//TAB TEXT//
//================//
    draw_set_font(
        fnt_gui_party_small
    );

    draw_set_halign(
        fa_center
    );

    draw_set_valign(
        fa_middle
    );

    draw_set_colour(
        (_t == _it_tab)
        ? c_white
        : c_black
    );

    draw_text(
        (_x1 + _x2) * 0.5,
        (
            _val_tab_y1 +
            _val_tab_y2
        ) * 0.5,
        _arr_tabs[_t]
    );
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

//===============================================================================//
// OVERWORLD
//===============================================================================//
if (_str_mode == "OVERWORLD"){

//===============================================================================//
// BEASTS
//===============================================================================//
if (_it_tab == 0){

    var _list_beasts =
        global.list_logbook_beasts;

    var _ct_catalog =
        ds_list_size(
            _list_beasts
        );

    var _it_max_page =
        hscr_cheats_get_max_page(
            _ct_catalog,
            _ct_rows_per_page
        );

    _it_page =
        clamp(
            _it_page,
            0,
            _it_max_page
        );

//================//
//COLUMN LAYOUT//
//================//
    var _val_gap = 18;

    var _val_catalog_w =
        floor(
            _val_content_w * 0.56
        );

    var _val_catalog_x1 =
        _val_left;

    var _val_catalog_x2 =
        _val_catalog_x1 +
        _val_catalog_w;

    var _val_party_x1 =
        _val_catalog_x2 +
        _val_gap;

    var _val_party_x2 =
        _val_right;

//================//
//HEADERS//
//================//
    draw_set_font(
        fnt_gui_party_small
    );

    draw_set_colour(c_white);
    draw_set_halign(fa_left);

    draw_text(
        _val_catalog_x1,
        _val_top,
        "BEAST CATALOG"
    );

    draw_text(
        _val_party_x1,
        _val_top,
        "CURRENT PARTY"
    );

//================//
//BEAST CATALOG//
//================//
    for (
        var _r = 0;
        _r < _ct_rows_per_page;
        _r++
    ){

        var _index =
            (_it_page *
            _ct_rows_per_page) +
            _r;

        if (_index >= _ct_catalog){
            break;
        }

        var _entry =
            ds_list_find_value(
                _list_beasts,
                _index
            );

        if (!is_struct(_entry)){
            continue;
        }

        var _y =
            _val_top +
            26 +
            (_r * _val_row_step);

        var _str_beast_color =
            hscr_cheats_get_entry_color(
                _entry
            );

        var _c_beast =
            hscr_cheats_get_color(
                _str_beast_color
            );

//----------------//
//COLORED BEAST PANEL//
//----------------//
draw_set_colour(
    _c_beast
);

draw_rectangle(
    _val_catalog_x1,
    _y,
    _val_catalog_x2,
    _y + _val_row_h,
    false
);

draw_set_colour(c_white);

draw_rectangle(
    _val_catalog_x1,
    _y,
    _val_catalog_x2,
    _y + _val_row_h,
    true
);

//----------------//
//BUTTON LAYOUT//
//----------------//
        var _val_button_gap = 5;

        var _val_button_w =
            min(
                105,
                floor(
                    _val_catalog_w *
                    0.25
                )
            );

        var _val_ranch_x2 =
            _val_catalog_x2 - 4;

        var _val_ranch_x1 =
            _val_ranch_x2 -
            _val_button_w;

        var _val_party_button_x2 =
            _val_ranch_x1 -
            _val_button_gap;

        var _val_party_button_x1 =
            _val_party_button_x2 -
            _val_button_w;

//----------------//
//NAME//
//----------------//
        draw_set_colour(c_black);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);

        draw_text(
            _val_catalog_x1 + 8,
            _y +
            (_val_row_h * 0.5),
            _entry._str_beast_name
        );

        draw_set_valign(fa_top);

//----------------//
//ADD PARTY//
//----------------//
        if (
            hscr_cheats_button(
                "PARTY",
                _val_party_button_x1,
                _y + 3,
                _val_party_button_x2,
                _y + _val_row_h - 3
            )
        ){

            hscr_cheats_add_beast(
                _entry._str_beast_id,
                "PARTY"
            );
        }

//----------------//
//ADD RANCH//
//----------------//
        if (
            hscr_cheats_button(
                "RANCH",
                _val_ranch_x1,
                _y + 3,
                _val_ranch_x2,
                _y + _val_row_h - 3
            )
        ){

            hscr_cheats_add_beast(
                _entry._str_beast_id,
                "RANCH"
            );
        }
    }

//================//
//CURRENT PARTY//
//================//
    if (
        ds_exists(
            global.list_player_party,
            ds_type_list
        )
    ){

        var _ct_party =
            ds_list_size(
                global.list_player_party
            );

        var _val_party_panel_h =
            70;

        var _val_party_panel_gap =
            7;

        for (
            var _p = 0;
            _p < _ct_party;
            _p++
        ){

            var _beast =
                ds_list_find_value(
                    global.list_player_party,
                    _p
                );

            if (!is_struct(_beast)){
                continue;
            }

            var _py =
                _val_top +
                26 +
                (
                    _p *
                    (
                        _val_party_panel_h +
                        _val_party_panel_gap
                    )
                );

            if (
                _py +
                _val_party_panel_h >
                _val_bottom
            ){
                break;
            }

            var _str_party_color =
                "UNCOLORED";

            if (
                variable_struct_exists(
                    _beast,
                    "_arr_beast_colors"
                ) &&
                is_array(
                    _beast._arr_beast_colors
                ) &&
                array_length(
                    _beast._arr_beast_colors
                ) > 0 &&
                _beast._arr_beast_colors[0]
                    != undefined
            ){
                _str_party_color =
                    _beast._arr_beast_colors[0];
            }

            var _c_party_border =
                hscr_cheats_get_color(
                    _str_party_color
                );

//----------------//
//PANEL//
//----------------//
            draw_set_colour(
                _c_party_background
            );

            draw_rectangle(
                _val_party_x1,
                _py,
                _val_party_x2,
                _py +
                _val_party_panel_h,
                false
            );

            draw_set_colour(
                _c_party_border
            );

            draw_rectangle(
                _val_party_x1,
                _py,
                _val_party_x2,
                _py +
                _val_party_panel_h,
                true
            );

//----------------//
//NAME / LEVEL//
//----------------//
            draw_set_colour(c_white);
            draw_set_font(
                fnt_gui_party_small
            );
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);

            draw_text(
                _val_party_x1 + 8,
                _py + 7,
                _beast._str_beast_name +
                "  LV." +
                string(
                    _beast._val_beast_level
                )
            );

//----------------//
//PARTY BUTTONS//
//----------------//
            var _val_inner_x1 =
                _val_party_x1 + 7;

            var _val_inner_x2 =
                _val_party_x2 - 7;

            var _val_button_gap = 4;

            var _val_available =
                _val_inner_x2 -
                _val_inner_x1 -
                (_val_button_gap * 3);

            var _val_button_w =
                _val_available / 4;

            var _val_button_y1 =
                _py + 34;

            var _val_button_y2 =
                _py +
                _val_party_panel_h -
                6;

            var _bx1 =
                _val_inner_x1;

            var _bx2 =
                _bx1 +
                _val_button_w;

            if (
                hscr_cheats_button(
                    "+LV",
                    _bx1,
                    _val_button_y1,
                    _bx2,
                    _val_button_y2
                )
            ){
                hscr_cheats_party_level(
                    _beast,
                    1
                );
            }

            _bx1 =
                _bx2 +
                _val_button_gap;

            _bx2 =
                _bx1 +
                _val_button_w;

            if (
                hscr_cheats_button(
                    "-LV",
                    _bx1,
                    _val_button_y1,
                    _bx2,
                    _val_button_y2
                )
            ){
                hscr_cheats_party_level(
                    _beast,
                    -1
                );
            }

            _bx1 =
                _bx2 +
                _val_button_gap;

            _bx2 =
                _bx1 +
                _val_button_w;

            if (
                hscr_cheats_button(
                    "HEAL",
                    _bx1,
                    _val_button_y1,
                    _bx2,
                    _val_button_y2
                )
            ){
                hscr_cheats_party_heal(
                    _beast
                );
            }

            _bx1 =
                _bx2 +
                _val_button_gap;

            _bx2 =
                _val_inner_x2;

            if (
                hscr_cheats_button(
                    "TALENTS",
                    _bx1,
                    _val_button_y1,
                    _bx2,
                    _val_button_y2
                )
            ){

                audio_play_sound(
                    snd_gui_error,
                    0,
                    false
                );

                hscr_cheats_log(
                    "RESET TALENTS",
                    "NOT IMPLEMENTED - NO ALLOCATED TALENT STATE EXISTS"
                );
            }
        }
    }

//================//
//PAGE//
//================//
    draw_set_colour(c_ltgray);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    draw_text(
        _val_left,
        _val_footer_y,
        "PAGE " +
        string(_it_page + 1) +
        "/" +
        string(_it_max_page + 1)
    );
}

//===============================================================================//
// CARDS
//===============================================================================//
else if (_it_tab == 1){

    var _list_cards =
        global.list_logbook_cards;

    var _ct_catalog =
        ds_list_size(
            _list_cards
        );

    var _it_max_page =
        hscr_cheats_get_max_page(
            _ct_catalog,
            _ct_rows_per_page
        );

    _it_page =
        clamp(
            _it_page,
            0,
            _it_max_page
        );

    draw_set_font(
        fnt_gui_party_small
    );

    draw_set_colour(c_white);
    draw_set_halign(fa_left);

    draw_text(
        _val_left,
        _val_top,
        "CARD CATALOG"
    );

    for (
        var _r = 0;
        _r < _ct_rows_per_page;
        _r++
    ){

        var _index =
            (_it_page *
            _ct_rows_per_page) +
            _r;

        if (_index >= _ct_catalog){
            break;
        }

        var _entry =
            ds_list_find_value(
                _list_cards,
                _index
            );

        if (!is_struct(_entry)){
            continue;
        }

        var _y =
            _val_top +
            26 +
            (_r * _val_row_step);

        var _str_card_color =
            hscr_cheats_get_entry_color(
                _entry
            );

        var _c_card =
            hscr_cheats_get_color(
                _str_card_color
            );

	//----------------//
	//COLORED CARD PANEL//
	//----------------//
	draw_set_colour(
	    _c_card
	);

	draw_rectangle(
	    _val_left,
	    _y,
	    _val_right,
	    _y + _val_row_h,
	    false
	);

	draw_set_colour(c_white);

	draw_rectangle(
	    _val_left,
	    _y,
	    _val_right,
	    _y + _val_row_h,
	    true
	);

//----------------//
//BUTTONS//
//----------------//
        var _val_library_w = 145;
        var _val_deck_w = 120;
        var _val_gap = 6;

        var _val_library_x2 =
            _val_right - 4;

        var _val_library_x1 =
            _val_library_x2 -
            _val_library_w;

        var _val_deck_x2 =
            _val_library_x1 -
            _val_gap;

        var _val_deck_x1 =
            _val_deck_x2 -
            _val_deck_w;

//----------------//
//NAME//
//----------------//
        draw_set_colour(c_black);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);

        draw_text(
            _val_left + 8,
            _y +
            (_val_row_h * 0.5),
            _entry._str_card_name
        );

        draw_set_valign(fa_top);

//----------------//
//ADD DECK//
//----------------//
        if (
            hscr_cheats_button(
                "ADD TO DECK",
                _val_deck_x1,
                _y + 3,
                _val_deck_x2,
                _y + _val_row_h - 3
            )
        ){
            hscr_cheats_add_card(
                _entry._str_card_id,
                "DECK"
            );
        }

//----------------//
//ADD LIBRARY//
//----------------//
        if (
            hscr_cheats_button(
                "ADD TO LIBRARY",
                _val_library_x1,
                _y + 3,
                _val_library_x2,
                _y + _val_row_h - 3
            )
        ){
            hscr_cheats_add_card(
                _entry._str_card_id,
                "LIBRARY"
            );
        }
    }

    draw_set_colour(c_ltgray);
    draw_set_halign(fa_left);

    draw_text(
        _val_left,
        _val_footer_y,
        "PAGE " +
        string(_it_page + 1) +
        "/" +
        string(_it_max_page + 1)
    );
}

//===============================================================================//
// ITEMS
//===============================================================================//
else if (_it_tab == 2){

    var _list_items =
        global.list_pool_items;

    var _ct_catalog =
        ds_list_size(
            _list_items
        );

    var _it_max_page =
        hscr_cheats_get_max_page(
            _ct_catalog,
            _ct_rows_per_page
        );

    _it_page =
        clamp(
            _it_page,
            0,
            _it_max_page
        );

    draw_set_font(
        fnt_gui_party_small
    );

    draw_set_colour(c_white);
    draw_set_halign(fa_left);

    draw_text(
        _val_left,
        _val_top,
        "ITEM CATALOG"
    );

    for (
        var _r = 0;
        _r < _ct_rows_per_page;
        _r++
    ){

        var _index =
            (_it_page *
            _ct_rows_per_page) +
            _r;

        if (_index >= _ct_catalog){
            break;
        }

        var _id =
            ds_list_find_value(
                _list_items,
                _index
            );

        var _item =
            scr_inventory_get_item_info(
                _id
            );

        if (_item == undefined){
            continue;
        }

        var _y =
            _val_top +
            26 +
            (_r * _val_row_step);

        var _str_item_type =
            "DEFAULT";

        if (
            variable_struct_exists(
                _item,
                "_str_item_type"
            )
        ){
            _str_item_type =
                _item._str_item_type;
        }

        var _c_item =
            hscr_cheats_get_item_color(
                _str_item_type
            );

//----------------//
//INVENTORY STYLE ROW//
//----------------//
        draw_set_colour(c_black);

        draw_rectangle(
            _val_left,
            _y,
            _val_right,
            _y + _val_row_h,
            false
        );

        draw_set_colour(_c_item);

        draw_rectangle(
            _val_left + 2,
            _y + 2,
            _val_right - 2,
            _y + _val_row_h - 2,
            false
        );

        draw_set_colour(c_black);

        draw_rectangle(
            _val_left,
            _y,
            _val_right,
            _y + _val_row_h,
            true
        );

//----------------//
//NAME//
//----------------//
        draw_set_colour(c_black);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);

        draw_text(
            _val_left + 8,
            _y +
            (_val_row_h * 0.5),
            _item._str_item_name
        );

        draw_set_valign(fa_top);

//----------------//
//ADD BUTTON//
//----------------//
        var _val_button_x2 =
            _val_right - 4;

        var _val_button_x1 =
            _val_button_x2 - 165;

        if (
            hscr_cheats_button(
                "ADD TO INVENTORY",
                _val_button_x1,
                _y + 3,
                _val_button_x2,
                _y + _val_row_h - 3
            )
        ){
            hscr_cheats_add_item(
                _id
            );
        }
    }

    draw_set_colour(c_ltgray);
    draw_set_halign(fa_left);

    draw_text(
        _val_left,
        _val_footer_y,
        "PAGE " +
        string(_it_page + 1) +
        "/" +
        string(_it_max_page + 1)
    );
}

//===============================================================================//
// MISC
//===============================================================================//
else if (_it_tab == 3){

    draw_set_font(
        fnt_gui_party_small
    );

    draw_set_colour(c_white);
    draw_set_halign(fa_left);

    draw_text(
        _val_left,
        _val_top,
        "GOLD"
    );

//================//
//GOLD BUTTONS//
//================//
    var _val_gold_y =
        _val_top + 26;

    var _arr_gold_buttons = [
        ["-1000 GP",-1000],
        ["-100 GP",-100],
        ["-1 GP",-1],
        ["+1 GP",1],
        ["+100 GP",100],
        ["+1000 GP",1000]
    ];

    var _val_gold_button_w =
        (_val_right - _val_left - 25) / 6;

    for (
        var _g = 0;
        _g < array_length(_arr_gold_buttons);
        _g++
    ){

        var _gx1 =
            _val_left +
            (_g * (_val_gold_button_w + 5));

        var _gx2 =
            _gx1 +
            _val_gold_button_w;

        var _val_gold_change =
            _arr_gold_buttons[_g][1];

        if (
            hscr_cheats_button(
                _arr_gold_buttons[_g][0],
                _gx1,
                _val_gold_y,
                _gx2,
                _val_gold_y + 32
            )
        ){

            if (
                _val_gold_change < 0 &&
                global.val_player_gold <= 0
            ){

                audio_play_sound(
                    snd_gui_error,
                    0,
                    false
                );

                hscr_cheats_log(
                    "GOLD REMOVE CAPPED",
                    "GOLD ALREADY 0"
                );
            }
            else{

                var _val_gold_before =
                    global.val_player_gold;

                global.val_player_gold =
                    max(
                        0,
                        global.val_player_gold +
                        _val_gold_change
                    );

                if (
                    global.val_player_gold ==
                    _val_gold_before
                ){

                    audio_play_sound(
                        snd_gui_error,
                        0,
                        false
                    );
                }
                else{

                    audio_play_sound(
                        snd_battle_heal,
                        0,
                        false
                    );
                }

                hscr_cheats_log(
                    (_val_gold_change > 0)
                    ? "GOLD ADDED"
                    : "GOLD REMOVED",
                    "REQUESTED: " +
                    string(_val_gold_change) +
                    " | GOLD: " +
                    string(_val_gold_before) +
                    " -> " +
                    string(global.val_player_gold)
                );
            }
        }
    }

//================//
//SPAWN HEADER//
//================//
    var _val_spawn_top =
        _val_top + 75;

    draw_set_colour(c_white);

    draw_text(
        _val_left,
        _val_spawn_top,
        "SPAWN WILD BEAST"
    );

    var _list_beasts =
        global.list_logbook_beasts;

    var _ct_catalog =
        ds_list_size(
            _list_beasts
        );

    var _it_max_page =
        hscr_cheats_get_max_page(
            _ct_catalog,
            _ct_rows_per_page
        );

    _it_page =
        clamp(
            _it_page,
            0,
            _it_max_page
        );

//================//
//SPAWN ROWS//
//================//
    for (
        var _r = 0;
        _r < _ct_rows_per_page;
        _r++
    ){

        var _index =
            (_it_page *
            _ct_rows_per_page) +
            _r;

        if (_index >= _ct_catalog){
            break;
        }

        var _entry =
            ds_list_find_value(
                _list_beasts,
                _index
            );

        if (!is_struct(_entry)){
            continue;
        }

        var _y =
            _val_spawn_top +
            24 +
            (_r * _val_row_step);

        if (
            _y + _val_row_h >
            _val_bottom
        ){
            break;
        }

        var _str_beast_color =
            hscr_cheats_get_entry_color(
                _entry
            );

        var _c_beast =
            hscr_cheats_get_color(
                _str_beast_color
            );

		//----------------//
		//COLORED BEAST PANEL//
		//----------------//
		draw_set_colour(
		    _c_beast
		);

		draw_rectangle(
		    _val_left,
		    _y,
		    _val_right,
		    _y + _val_row_h,
		    false
		);

		draw_set_colour(c_white);

		draw_rectangle(
		    _val_left,
		    _y,
		    _val_right,
		    _y + _val_row_h,
		    true
		);

        draw_set_colour(c_black);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);

        draw_text(
            _val_left + 8,
            _y +
            (_val_row_h * 0.5),
            _entry._str_beast_name
        );

        draw_set_valign(fa_top);

        if (
            hscr_cheats_button(
                "SPAWN",
                _val_right - 110,
                _y + 3,
                _val_right - 4,
                _y + _val_row_h - 3
            )
        ){

            hscr_cheats_start_tool(
                "SPAWN_WILD",
                "SPAWN " +
                string_upper(
                    _entry._str_beast_name
                ),
                "WORLD_POSITION",
                _entry._str_beast_id
            );
        }
    }

    draw_set_colour(c_ltgray);

    draw_text(
        _val_left,
        _val_footer_y,
        "PAGE " +
        string(_it_page + 1) +
        "/" +
        string(_it_max_page + 1)
    );
}

}

//===============================================================================//
// BATTLE
//===============================================================================//
else{

//===============================================================================//
// INTERACT
//===============================================================================//
if (_it_tab == 0){

    draw_set_font(
        fnt_gui_party_small
    );

    draw_set_colour(c_white);
    draw_set_halign(fa_left);

    draw_text(
        _val_left,
        _val_top,
        "TARGET"
    );

//================//
//TARGET BUTTONS//
//================//
    var _val_target_y =
        _val_top + 24;

    var _val_target_gap = 5;

    var _val_target_w =
        (_val_content_w -
        (_val_target_gap * 6)) /
        7;

    var _arr_target_buttons = [
        ["RESURRECT","RESURRECT","RESURRECT TARGET"],
        ["HEAL +1","HEAL_1","HEAL TARGET +1"],
        ["HEAL +10","HEAL_10","HEAL TARGET +10"],
        ["FULL HEAL","HEAL_FULL","FULL HEAL TARGET"],
        ["DAMAGE -1","DAMAGE_1","DAMAGE TARGET -1"],
        ["DAMAGE -10","DAMAGE_10","DAMAGE TARGET -10"],
        ["KILL","KILL","KILL TARGET"]
    ];

    for (
        var _i = 0;
        _i < array_length(
            _arr_target_buttons
        );
        _i++
    ){

        var _bx1 =
            _val_left +
            (
                _i *
                (
                    _val_target_w +
                    _val_target_gap
                )
            );

        var _bx2 =
            _bx1 +
            _val_target_w;

        if (
            hscr_cheats_button(
                _arr_target_buttons[_i][0],
                _bx1,
                _val_target_y,
                _bx2,
                _val_target_y + 30
            )
        ){

            hscr_cheats_start_tool(
                _arr_target_buttons[_i][1],
                _arr_target_buttons[_i][2],
                "BATTLE_UNIT"
            );
        }
    }

//================//
//LEVEL//
//================//
    var _val_level_y =
        _val_target_y + 48;

    draw_set_colour(c_white);

    draw_text(
        _val_left,
        _val_level_y,
        "LEVEL"
    );

    var _arr_level_buttons = [
        ["+1","LEVEL_1","TARGET LEVEL +1"],
        ["+5","LEVEL_5","TARGET LEVEL +5"],
        ["-1","LEVEL_MINUS_1","TARGET LEVEL -1"],
        ["-5","LEVEL_MINUS_5","TARGET LEVEL -5"]
    ];

    for (
        var _i = 0;
        _i < 4;
        _i++
    ){

        var _bx1 =
            _val_left +
            (_i * 65);

        if (
            hscr_cheats_button(
                _arr_level_buttons[_i][0],
                _bx1,
                _val_level_y + 23,
                _bx1 + 55,
                _val_level_y + 51
            )
        ){

            hscr_cheats_start_tool(
                _arr_level_buttons[_i][1],
                _arr_level_buttons[_i][2],
                "BATTLE_UNIT"
            );
        }
    }

//================//
//CLEANSE//
//================//
    var _val_cleanse_y =
        _val_level_y + 70;

    draw_set_colour(c_white);

    draw_text(
        _val_left,
        _val_cleanse_y,
        "CLEANSE"
    );

    var _arr_cleanse_buttons = [
        ["DOT -1","DOT|STACKS|1"],
        ["DOT ALL","DOT|STATUS|ALL"],
        ["DEBUFF 1","DEBUFF|STATUS|1"],
        ["DEBUFF ALL","DEBUFF|STATUS|ALL"],
        ["CC 1","CC|STATUS|1"],
        ["CC ALL","CC|STATUS|ALL"],
        ["NEGATIVE ALL","NEGATIVE|STATUS|ALL"],
        ["ALL","ALL|STATUS|ALL"]
    ];

    var _val_cleanse_gap = 5;

    var _val_cleanse_w =
        (
            _val_content_w -
            (_val_cleanse_gap * 3)
        ) / 4;

    for (
        var _i = 0;
        _i < array_length(
            _arr_cleanse_buttons
        );
        _i++
    ){

        var _col =
            _i mod 4;

        var _row =
            floor(
                _i / 4
            );

        var _bx1 =
            _val_left +
            (
                _col *
                (
                    _val_cleanse_w +
                    _val_cleanse_gap
                )
            );

        var _by1 =
            _val_cleanse_y +
            23 +
            (_row * 34);

        if (
            hscr_cheats_button(
                _arr_cleanse_buttons[_i][0],
                _bx1,
                _by1,
                _bx1 +
                _val_cleanse_w,
                _by1 + 28
            )
        ){

            hscr_cheats_start_tool(
                "CLEANSE",
                "CLEANSE " +
                _arr_cleanse_buttons[_i][0],
                "BATTLE_UNIT",
                _arr_cleanse_buttons[_i][1]
            );
        }
    }

//================//
//SUBMENU BUTTONS//
//================//
    var _val_submenu_y =
        _val_cleanse_y + 100;

    if (
        hscr_cheats_button(
            "APPLY STATUS",
            _val_left,
            _val_submenu_y,
            _val_left + 145,
            _val_submenu_y + 30
        )
    ){

        _it_submenu = 1;
        _it_page = 0;
    }

    if (
        hscr_cheats_button(
            "SPAWN MINION",
            _val_left + 155,
            _val_submenu_y,
            _val_left + 310,
            _val_submenu_y + 30
        )
    ){

        _it_submenu = 2;
        _it_page = 0;
    }

    if (
        _it_submenu != 0 &&
        hscr_cheats_button(
            "CLOSE LIST",
            _val_left + 320,
            _val_submenu_y,
            _val_left + 445,
            _val_submenu_y + 30
        )
    ){

        _it_submenu = 0;
        _it_page = 0;
    }

//===============================================================================//
// STATUS SUBMENU
//===============================================================================//
    if (_it_submenu == 1){

        var _arr_all_statuses = [];

        for (
            var _i = 0;
            _i < array_length(
                _arr_cheat_dots
            );
            _i++
        ){

            array_push(
                _arr_all_statuses,
                [
                    "DOT",
                    _arr_cheat_dots[_i]
                ]
            );
        }

        for (
            var _i = 0;
            _i < array_length(
                _arr_cheat_cc
            );
            _i++
        ){

            array_push(
                _arr_all_statuses,
                [
                    "CC",
                    _arr_cheat_cc[_i]
                ]
            );
        }

        for (
            var _i = 0;
            _i < array_length(
                _arr_cheat_debuffs
            );
            _i++
        ){

            array_push(
                _arr_all_statuses,
                [
                    "DEBUFF",
                    _arr_cheat_debuffs[_i]
                ]
            );
        }

        for (
            var _i = 0;
            _i < array_length(
                _arr_cheat_buffs
            );
            _i++
        ){

            array_push(
                _arr_all_statuses,
                [
                    "BUFF",
                    _arr_cheat_buffs[_i]
                ]
            );
        }

        var _ct_per_page = 12;

        var _it_max_page =
            hscr_cheats_get_max_page(
                array_length(
                    _arr_all_statuses
                ),
                _ct_per_page
            );

        _it_page =
            clamp(
                _it_page,
                0,
                _it_max_page
            );

        var _val_list_y =
            _val_submenu_y + 43;

        var _val_gap = 5;

        var _val_button_w =
            (
                _val_content_w -
                (_val_gap * 3)
            ) / 4;

        for (
            var _i = 0;
            _i < _ct_per_page;
            _i++
        ){

            var _index =
                (_it_page *
                _ct_per_page) +
                _i;

            if (
                _index >=
                array_length(
                    _arr_all_statuses
                )
            ){
                break;
            }

            var _entry =
                _arr_all_statuses[
                    _index
                ];

            var _col =
                _i mod 4;

            var _row =
                floor(
                    _i / 4
                );

            var _bx1 =
                _val_left +
                (
                    _col *
                    (
                        _val_button_w +
                        _val_gap
                    )
                );

            var _by1 =
                _val_list_y +
                (_row * 34);

            if (
                hscr_cheats_button(
                    _entry[0] +
                    ": " +
                    _entry[1],
                    _bx1,
                    _by1,
                    _bx1 +
                    _val_button_w,
                    _by1 + 28
                )
            ){

                hscr_cheats_start_tool(
                    "STATUS",
                    "APPLY " +
                    _entry[1],
                    "BATTLE_UNIT",
                    _entry[0] +
                    "|" +
                    _entry[1]
                );
            }
        }

        draw_set_colour(c_ltgray);
        draw_set_halign(fa_left);

        draw_text(
            _val_left,
            _val_footer_y,
            "STATUS PAGE " +
            string(_it_page + 1) +
            "/" +
            string(_it_max_page + 1)
        );
    }

//===============================================================================//
// MINION SUBMENU
//===============================================================================//
    else if (_it_submenu == 2){

        var _ct_per_page = 12;

        var _it_max_page =
            hscr_cheats_get_max_page(
                array_length(
                    _arr_cheat_minions
                ),
                _ct_per_page
            );

        _it_page =
            clamp(
                _it_page,
                0,
                _it_max_page
            );

        var _val_list_y =
            _val_submenu_y + 43;

        var _val_gap = 5;

        var _val_button_w =
            (
                _val_content_w -
                (_val_gap * 3)
            ) / 4;

        for (
            var _i = 0;
            _i < _ct_per_page;
            _i++
        ){

            var _index =
                (_it_page *
                _ct_per_page) +
                _i;

            if (
                _index >=
                array_length(
                    _arr_cheat_minions
                )
            ){
                break;
            }

            var _col =
                _i mod 4;

            var _row =
                floor(
                    _i / 4
                );

            var _bx1 =
                _val_left +
                (
                    _col *
                    (
                        _val_button_w +
                        _val_gap
                    )
                );

            var _by1 =
                _val_list_y +
                (_row * 34);

            var _str_minion =
                _arr_cheat_minions[
                    _index
                ];

            if (
                hscr_cheats_button(
                    _str_minion,
                    _bx1,
                    _by1,
                    _bx1 +
                    _val_button_w,
                    _by1 + 28
                )
            ){

                hscr_cheats_start_tool(
                    "SPAWN_MINION",
                    "SPAWN " +
                    _str_minion,
                    "BATTLE_UNIT",
                    _str_minion
                );
            }
        }

        draw_set_colour(c_ltgray);
        draw_set_halign(fa_left);

        draw_text(
            _val_left,
            _val_footer_y,
            "MINION PAGE " +
            string(_it_page + 1) +
            "/" +
            string(_it_max_page + 1)
        );
    }
}

//===============================================================================//
// EVENTS / WEATHER
//===============================================================================//
else if (_it_tab == 1){

    var _val_gap = 24;

    var _val_column_w =
        (
            _val_content_w -
            _val_gap
        ) * 0.5;

    var _val_weather_x =
        _val_left;

    var _val_event_x =
        _val_left +
        _val_column_w +
        _val_gap;

    draw_set_font(
        fnt_gui_party_small
    );

    draw_set_colour(c_white);
    draw_set_halign(fa_left);

    draw_text(
        _val_weather_x,
        _val_top,
        "WEATHER"
    );

    draw_text(
        _val_event_x,
        _val_top,
        "EVENTS"
    );

//================//
//WEATHER//
//================//
    for (
        var _i = 0;
        _i < array_length(
            _arr_cheat_weather
        );
        _i++
    ){

        var _by =
            _val_top +
            27 +
            (_i * 38);

        if (
            hscr_cheats_button(
                _arr_cheat_weather[_i],
                _val_weather_x,
                _by,
                _val_weather_x +
                _val_column_w,
                _by + 30
            )
        ){

            scr_status_apply_weather(
                _arr_cheat_weather[_i]
            );

            hscr_cheats_log(
                "WEATHER STARTED",
                "WEATHER: " +
                _arr_cheat_weather[_i]
            );
        }
    }

//================//
//EVENTS//
//================//
    for (
        var _i = 0;
        _i < array_length(
            _arr_cheat_events
        );
        _i++
    ){

        var _event =
            _arr_cheat_events[_i];

        var _by =
            _val_top +
            27 +
            (_i * 38);

        if (
            hscr_cheats_button(
                _event,
                _val_event_x,
                _by,
                _val_event_x +
                _val_column_w,
                _by + 30
            )
        ){

            for (
                var _s =
                    ds_list_size(
                        global.list_statuses
                    ) - 1;
                _s >= 0;
                _s--
            ){

                var _status =
                    ds_list_find_value(
                        global.list_statuses,
                        _s
                    );

                if (
                    instance_exists(
                        _status
                    ) &&
                    _status._str_status_type
                        == "EVENT"
                ){

                    if (
                        _status._scr_status
                            != undefined
                    ){

                        _status._scr_status(
                            "DEATH",
                            _status
                        );
                    }
                    else{

                        scr_status_destroy(
                            _status
                        );
                    }
                }
            }

            switch (_event){

                case "BLOOD_MOON":

                    scr_status_event_blood_moon(
                        "APPLY",
                        undefined,
                        undefined,
                        "PLAYER"
                    );

                break;

                case "BLOODMIST":

                    scr_status_event_bloodmist(
                        "APPLY",
                        undefined,
                        4,
                        "PLAYER"
                    );

                break;

                case "BLOOMTIDE":

                    scr_status_event_bloomtide(
                        "APPLY",
                        undefined,
                        undefined,
                        "PLAYER"
                    );

                break;
            }

            hscr_cheats_log(
                "EVENT STARTED",
                "EVENT: " +
                _event
            );
        }
    }
}

//===============================================================================//
// HAND
//===============================================================================//
else if (_it_tab == 2){

    draw_set_font(
        fnt_gui_party_small
    );

    draw_set_colour(c_white);
    draw_set_halign(fa_left);

    draw_text(
        _val_left,
        _val_top,
        "PLAYER HAND"
    );

    var _val_y =
        _val_top + 30;

    var _val_gap = 10;

    var _val_button_w =
        (
            _val_content_w -
            (_val_gap * 2)
        ) / 3;

    if (
        hscr_cheats_button(
            "DRAW 1 CARD",
            _val_left,
            _val_y,
            _val_left +
            _val_button_w,
            _val_y + 38
        )
    ){

        var _ct_drawn =
            scr_battle_draw_cards(1);

        hscr_cheats_log(
            "CARD DRAW CHEAT",
            "DRAWN: " +
            string(_ct_drawn)
        );
    }

    if (
        hscr_cheats_button(
            "DISCARD CARD",
            _val_left +
            _val_button_w +
            _val_gap,
            _val_y,
            _val_left +
            (_val_button_w * 2) +
            _val_gap,
            _val_y + 38
        )
    ){

        hscr_cheats_start_tool(
            "DISCARD_CARD",
            "DISCARD HAND CARD",
            "BATTLE_CARD"
        );
    }

    if (
        hscr_cheats_button(
            "EXHAUST CARD",
            _val_left +
            (_val_button_w * 2) +
            (_val_gap * 2),
            _val_y,
            _val_right,
            _val_y + 38
        )
    ){

        hscr_cheats_start_tool(
            "EXHAUST_CARD",
            "EXHAUST HAND CARD",
            "BATTLE_CARD"
        );
    }
}

//===============================================================================//
// END BATTLE
//===============================================================================//
else if (_it_tab == 3){

    draw_set_font(
        fnt_gui_medium
    );

    draw_set_colour(c_white);
    draw_set_halign(fa_left);

    draw_text(
        _val_left,
        _val_top,
        "FORCE BATTLE RESULT"
    );

    var _val_y =
        _val_top + 45;

    var _val_button_w =
        min(
            220,
            (
                _val_content_w -
                15
            ) * 0.5
        );

    if (
        hscr_cheats_button(
            "WIN",
            _val_left,
            _val_y,
            _val_left +
            _val_button_w,
            _val_y + 50
        )
    ){

        hscr_cheats_end_battle(
            "WIN"
        );

        exit;
    }

    if (
        hscr_cheats_button(
            "LOSS",
            _val_left +
            _val_button_w +
            15,
            _val_y,
            _val_left +
            (_val_button_w * 2) +
            15,
            _val_y + 50
        )
    ){

        hscr_cheats_end_battle(
            "LOSS"
        );

        exit;
    }
}

}

//===============================================================================//
// FOOTER
//===============================================================================//
draw_set_font(
    fnt_gui_party_small
);

draw_set_colour(c_ltgray);
draw_set_halign(fa_right);
draw_set_valign(fa_top);

draw_text(
    _val_right,
    _val_footer_y,
    "LEFT/RIGHT: TAB   UP/DOWN OR WHEEL: PAGE   `: CLOSE"
);

//================//
//RESET DRAW STATE//
//================//
draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);