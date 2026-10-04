//===============================================================================//
//
// DRAW GUI: OBJ_GUI_BATTLE_START_PANE
// FUNCTION: Draws the pre-battle matchup pane.
//           Shows Player and Enemy team members, HP, Level, Speed,
//           average Level, average Speed, OUTLEVELED stacks,
//           opening initiative, and Start Battle.
//
//===============================================================================//

//================//
//DRAW STATE//
//================//

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);

//================//
//SCREEN DIM//
//================//

// The transition fader owns the background during battle entry.
// This fallback supports launching rm_battle directly without a transition.

if (!instance_exists(obj_transition_fader)){

    draw_set_alpha(0.35);
    draw_set_colour(c_black);

    draw_rectangle(
        0,
        0,
        display_get_gui_width(),
        display_get_gui_height(),
        false
    );
}

draw_set_alpha(1);
draw_set_colour(c_white);

//================//
//REFRESH LEVELS//
//================//

if (
    instance_exists(_ref_player_controller) &&
    instance_exists(_ref_enemy_controller)
){

    _val_player_avg_level =
        scr_battle_get_team_average_level(
            "PLAYER"
        );

    _val_enemy_avg_level =
        scr_battle_get_team_average_level(
            "ENEMY"
        );
}

//================//
//PANE LAYOUT//
//================//

var _val_pane_left =
    x -
    (_val_pane_w * 0.5);

var _val_pane_right =
    x +
    (_val_pane_w * 0.5);

var _val_pane_top =
    y -
    (_val_pane_h * 0.5);

var _val_pane_bottom =
    y +
    (_val_pane_h * 0.5);

var _val_team_top =
    _val_pane_top +
    60;

var _val_team_bottom =
    _val_pane_bottom -
    110;

var _val_player_x1 =
    _val_pane_left +
    25;

var _val_player_x2 =
    x -
    25;

var _val_enemy_x1 =
    x +
    25;

var _val_enemy_x2 =
    _val_pane_right -
    25;

//================//
//MAIN PANE//
//================//

draw_set_colour(c_black);

draw_rectangle(
    _val_pane_left,
    _val_pane_top,
    _val_pane_right,
    _val_pane_bottom,
    false
);

draw_set_colour(global.c_dk_gray);

draw_rectangle(
    _val_pane_left + 4,
    _val_pane_top + 4,
    _val_pane_right - 4,
    _val_pane_bottom - 4,
    false
);

//================//
//TEAM BOXES//
//================//

draw_set_colour(c_black);

draw_rectangle(
    _val_player_x1,
    _val_team_top,
    _val_player_x2,
    _val_team_bottom,
    true
);

draw_rectangle(
    _val_enemy_x1,
    _val_team_top,
    _val_enemy_x2,
    _val_team_bottom,
    true
);

//================//
//GOING FIRST BOX//
//================//

if (_str_first_team == "PLAYER"){

    draw_set_colour(c_yellow);

    draw_rectangle(
        _val_player_x1 - 3,
        _val_team_top - 3,
        _val_player_x2 + 3,
        _val_team_bottom + 3,
        true
    );

    draw_rectangle(
        _val_player_x1 - 4,
        _val_team_top - 4,
        _val_player_x2 + 4,
        _val_team_bottom + 4,
        true
    );
}
else if (_str_first_team == "ENEMY"){

    draw_set_colour(c_yellow);

    draw_rectangle(
        _val_enemy_x1 - 3,
        _val_team_top - 3,
        _val_enemy_x2 + 3,
        _val_team_bottom + 3,
        true
    );

    draw_rectangle(
        _val_enemy_x1 - 4,
        _val_team_top - 4,
        _val_enemy_x2 + 4,
        _val_team_bottom + 4,
        true
    );
}

//================//
//HEADERS//
//================//

draw_set_font(fnt_gui_medium);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_colour(c_white);

draw_text(
    (_val_player_x1 + _val_player_x2) * 0.5,
    _val_team_top + 14,
    "YOUR TEAM"
);

draw_text(
    (_val_enemy_x1 + _val_enemy_x2) * 0.5,
    _val_team_top + 14,
    "ENEMY TEAM"
);

//======================//
//AVERAGE LEVEL / SPEED//
//======================//

draw_set_font(fnt_gui_small);
draw_set_colour(c_ltgray);

draw_text(
    (_val_player_x1 + _val_player_x2) * 0.5,
    _val_team_top + 45,
    "AVG LVL: " +
    string(_val_player_avg_level) +
    "   AVG SPD: " +
    string_format(_val_player_avg_speed,0,1)
);

draw_text(
    (_val_enemy_x1 + _val_enemy_x2) * 0.5,
    _val_team_top + 45,
    "AVG LVL: " +
    string(_val_enemy_avg_level) +
    "   AVG SPD: " +
    string_format(_val_enemy_avg_speed,0,1)
);

//================//
//GOING FIRST TEXT//
//================//

draw_set_font(fnt_gui_medium);
draw_set_colour(c_yellow);

if (_str_first_team == "PLAYER"){

    draw_text(
        (_val_player_x1 + _val_player_x2) * 0.5,
        _val_team_top + 70,
        "GOING FIRST"
    );
}

if (_str_first_team == "ENEMY"){

    draw_text(
        (_val_enemy_x1 + _val_enemy_x2) * 0.5,
        _val_team_top + 70,
        "GOING FIRST"
    );
}

//================//
//VS//
//================//

draw_set_colour(c_white);
draw_set_font(fnt_gui_large);

draw_text(
    x,
    _val_team_top + 180,
    "VS"
);

//=====================//
//OUTLEVELED TOOLTIP//
//=====================//

var _str_outleveled_tooltip = "";

var _val_mouse_x =
    device_mouse_x_to_gui(0);

var _val_mouse_y =
    device_mouse_y_to_gui(0);

//================//
//PLAYER TEAM//
//================//

draw_set_halign(fa_left);

var _val_player_row_y =
    _val_team_top +
    110;

if (
    instance_exists(_ref_player_controller) &&
    ds_exists(
        _ref_player_controller._list_beasts_alive,
        ds_type_list
    )
){

    var _ct_player_beasts =
        min(
            5,
            ds_list_size(
                _ref_player_controller._list_beasts_alive
            )
        );

    for (
        var _it_beast = 0;
        _it_beast < _ct_player_beasts;
        _it_beast++
    ){

        var _ref_beast =
            ds_list_find_value(
                _ref_player_controller._list_beasts_alive,
                _it_beast
            );

        if (!instance_exists(_ref_beast)){
            continue;
        }

        if (!is_struct(_ref_beast._ref_unit)){
            continue;
        }

        var _val_row_y =
            _val_player_row_y +
            (
                _it_beast *
                (
                    _val_row_h +
                    _val_row_spacing
                )
            );

//----------//
//ROW BORDER//
//----------//

        draw_set_colour(c_black);

        draw_rectangle(
            _val_player_x1 + 12,
            _val_row_y,
            _val_player_x2 - 12,
            _val_row_y + _val_row_h,
            true
        );

//================//
//REORDER CONTROLS//
//================//
		var _flag_reorder_hover =
			point_in_rectangle(
				_val_mouse_x,
				_val_mouse_y,
				_val_player_x1 + 12,
				_val_row_y,
				_val_player_x2 - 12,
				_val_row_y + _val_row_h
			);

		if (_flag_reorder_hover){

			var _flag_can_move_up = _it_beast > 0;
			var _flag_can_move_down = _it_beast < _ct_player_beasts - 1;

			var _val_arrow_right_x = _val_player_x2 - 28;
			var _val_arrow_left_x = _val_player_x2 - 54;

			var _val_up_arrow_x =
				_flag_can_move_down ?
				_val_arrow_left_x :
				_val_arrow_right_x;

			var _val_down_arrow_x = _val_arrow_right_x;
			var _val_arrow_y = _val_row_y + 11;

			var _flag_up_arrow_hover =
				_flag_can_move_up &&
				point_in_rectangle(
					_val_mouse_x,
					_val_mouse_y,
					_val_up_arrow_x - 9,
					_val_arrow_y - 9,
					_val_up_arrow_x + 9,
					_val_arrow_y + 9
				);

			var _flag_down_arrow_hover =
				_flag_can_move_down &&
				point_in_rectangle(
					_val_mouse_x,
					_val_mouse_y,
					_val_down_arrow_x - 9,
					_val_arrow_y - 9,
					_val_down_arrow_x + 9,
					_val_arrow_y + 9
				);

//----------//
//UP ARROW//
//----------//
			if (_flag_can_move_up){

				draw_set_colour(c_black);
				draw_rectangle(
					_val_up_arrow_x - 8,
					_val_arrow_y - 8,
					_val_up_arrow_x + 8,
					_val_arrow_y + 8,
					false
				);

				draw_set_colour(_flag_up_arrow_hover ? c_yellow : c_white);
				draw_triangle(
					_val_up_arrow_x,
					_val_arrow_y - 5,
					_val_up_arrow_x - 5,
					_val_arrow_y + 4,
					_val_up_arrow_x + 5,
					_val_arrow_y + 4,
					false
				);
			}

//------------//
//DOWN ARROW//
//------------//
			if (_flag_can_move_down){

				draw_set_colour(c_black);
				draw_rectangle(
					_val_down_arrow_x - 8,
					_val_arrow_y - 8,
					_val_down_arrow_x + 8,
					_val_arrow_y + 8,
					false
				);

				draw_set_colour(_flag_down_arrow_hover ? c_yellow : c_white);
				draw_triangle(
					_val_down_arrow_x,
					_val_arrow_y + 5,
					_val_down_arrow_x - 5,
					_val_arrow_y - 4,
					_val_down_arrow_x + 5,
					_val_arrow_y - 4,
					false
				);
			}
		}

//---------//
//UNIT NAME//
//---------//

        draw_set_font(fnt_gui_small);
        draw_set_colour(c_white);

        draw_text(
            _val_player_x1 + 24,
            _val_row_y + 7,
            string_upper(
                _ref_beast._ref_unit._str_beast_name
            )
        );

//----------//
//UNIT STATS//
//----------//

        var _str_stats =
            "HP " +
            string(_ref_beast._val_cur_hp) +
            "/" +
            string(_ref_beast._val_max_hp) +
            "   LVL " +
            string(
                _ref_beast._ref_unit._val_beast_level
            ) +
            "   SPD " +
            string(
                round(
                    scr_battle_get_beast_speed(
                        _ref_beast
                    )
                )
            );

        draw_set_colour(c_ltgray);

        draw_text(
            _val_player_x1 + 24,
            _val_row_y + 28,
            _str_stats
        );

//================//
//OUTLEVELED STAR//
//================//

        var _ref_outleveled =
            scr_status_check(
                "OUTLEVELED",
                _ref_beast
            );

        if (
            _ref_outleveled != -1 &&
            instance_exists(_ref_outleveled) &&
            _ref_outleveled._ct_status_stacks > 0
        ){

            var _ct_stacks =
                _ref_outleveled._ct_status_stacks;

            var _val_star_x =
                _val_player_x2 -
                34;

            var _val_star_y =
                _val_row_y +
                (_val_row_h * 0.5);

            draw_sprite_ext(
                spr_status_buff_outleveled,
                0,
                _val_star_x,
                _val_star_y,
                0.5,
                0.5,
                0,
                c_white,
                1
            );

            draw_set_font(fnt_gui_party_small);
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_set_colour(c_black);

            draw_text(
                _val_star_x,
                _val_star_y,
                string(_ct_stacks)
            );

//----------------//
//STAR TOOLTIP//
//----------------//

            if (
                point_in_rectangle(
                    _val_mouse_x,
                    _val_mouse_y,
                    _val_star_x - 18,
                    _val_star_y - 18,
                    _val_star_x + 18,
                    _val_star_y + 18
                )
            ){

                _str_outleveled_tooltip =
                    string_upper(
                        _ref_beast._ref_unit._str_beast_name
                    ) +
                    " | OUTLEVELED x" +
                    string(_ct_stacks) +
                    " | +" +
                    string(_ct_stacks * 10) +
                    "% BASE PRIMARY STATS | LVL " +
                    string(
                        _ref_beast._ref_unit._val_beast_level
                    ) +
                    " VS ENEMY AVG LVL " +
                    string(_val_enemy_avg_level);
            }

            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
        }
    }
}

//================//
//ENEMY TEAM//
//================//

var _val_enemy_row_y =
    _val_team_top +
    110;

if (
    instance_exists(_ref_enemy_controller) &&
    ds_exists(
        _ref_enemy_controller._list_beasts_alive,
        ds_type_list
    )
){

    var _ct_enemy_beasts =
        min(
            5,
            ds_list_size(
                _ref_enemy_controller._list_beasts_alive
            )
        );

    for (
        var _it_beast = 0;
        _it_beast < _ct_enemy_beasts;
        _it_beast++
    ){

        var _ref_beast =
            ds_list_find_value(
                _ref_enemy_controller._list_beasts_alive,
                _it_beast
            );

        if (!instance_exists(_ref_beast)){
            continue;
        }

        if (!is_struct(_ref_beast._ref_unit)){
            continue;
        }

        var _val_row_y =
            _val_enemy_row_y +
            (
                _it_beast *
                (
                    _val_row_h +
                    _val_row_spacing
                )
            );

//----------//
//ROW BORDER//
//----------//

        draw_set_colour(c_black);

        draw_rectangle(
            _val_enemy_x1 + 12,
            _val_row_y,
            _val_enemy_x2 - 12,
            _val_row_y + _val_row_h,
            true
        );

//---------//
//UNIT NAME//
//---------//

        draw_set_font(fnt_gui_small);
        draw_set_colour(c_white);

        draw_text(
            _val_enemy_x1 + 24,
            _val_row_y + 7,
            string_upper(
                _ref_beast._ref_unit._str_beast_name
            )
        );

//----------//
//UNIT STATS//
//----------//

        var _str_stats =
            "HP " +
            string(_ref_beast._val_cur_hp) +
            "/" +
            string(_ref_beast._val_max_hp) +
            "   LVL " +
            string(
                _ref_beast._ref_unit._val_beast_level
            ) +
            "   SPD " +
            string(
                round(
                    scr_battle_get_beast_speed(
                        _ref_beast
                    )
                )
            );

        draw_set_colour(c_ltgray);

        draw_text(
            _val_enemy_x1 + 24,
            _val_row_y + 28,
            _str_stats
        );

//================//
//OUTLEVELED STAR//
//================//

        var _ref_outleveled =
            scr_status_check(
                "OUTLEVELED",
                _ref_beast
            );

        if (
            _ref_outleveled != -1 &&
            instance_exists(_ref_outleveled) &&
            _ref_outleveled._ct_status_stacks > 0
        ){

            var _ct_stacks =
                _ref_outleveled._ct_status_stacks;

            var _val_star_x =
                _val_enemy_x2 -
                34;

            var _val_star_y =
                _val_row_y +
                (_val_row_h * 0.5);

            draw_sprite_ext(
                spr_status_buff_outleveled,
                0,
                _val_star_x,
                _val_star_y,
                0.5,
                0.5,
                0,
                c_white,
                1
            );

            draw_set_font(fnt_gui_party_small);
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_set_colour(c_black);

            draw_text(
                _val_star_x,
                _val_star_y,
                string(_ct_stacks)
            );

//----------------//
//STAR TOOLTIP//
//----------------//

            if (
                point_in_rectangle(
                    _val_mouse_x,
                    _val_mouse_y,
                    _val_star_x - 18,
                    _val_star_y - 18,
                    _val_star_x + 18,
                    _val_star_y + 18
                )
            ){

                _str_outleveled_tooltip =
                    string_upper(
                        _ref_beast._ref_unit._str_beast_name
                    ) +
                    " | OUTLEVELED x" +
                    string(_ct_stacks) +
                    " | +" +
                    string(_ct_stacks * 10) +
                    "% BASE PRIMARY STATS | LVL " +
                    string(
                        _ref_beast._ref_unit._val_beast_level
                    ) +
                    " VS PLAYER AVG LVL " +
                    string(_val_player_avg_level);
            }

            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
        }
    }
}

//======================//
//OUTLEVELED EXPLANATION//
//======================//

if (_str_outleveled_tooltip != ""){

    draw_set_font(fnt_gui_small);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    var _val_tooltip_x = x;
    var _val_tooltip_y =
        _val_team_bottom +
        15;

    var _val_tooltip_w =
        min(
            _val_pane_w - 80,
            string_width(
                _str_outleveled_tooltip
            ) + 30
        );

    draw_set_colour(c_black);

    draw_rectangle(
        _val_tooltip_x - (_val_tooltip_w * 0.5),
        _val_tooltip_y - 11,
        _val_tooltip_x + (_val_tooltip_w * 0.5),
        _val_tooltip_y + 11,
        false
    );

    draw_set_colour(c_yellow);

    draw_text(
        _val_tooltip_x,
        _val_tooltip_y,
        _str_outleveled_tooltip
    );
}

//================//
//START BUTTON//
//================//

var _val_button_x1 =
    x -
    (_val_button_w * 0.5);

var _val_button_x2 =
    x +
    (_val_button_w * 0.5);

var _val_button_y1 =
    _val_pane_bottom -
    78;

var _val_button_y2 =
    _val_button_y1 +
    _val_button_h;

var _flag_button_hover =
    _val_mouse_x >= _val_button_x1 &&
    _val_mouse_x <= _val_button_x2 &&
    _val_mouse_y >= _val_button_y1 &&
    _val_mouse_y <= _val_button_y2;

draw_set_colour(c_black);

draw_rectangle(
    _val_button_x1 - 3,
    _val_button_y1 - 3,
    _val_button_x2 + 3,
    _val_button_y2 + 3,
    false
);

draw_set_colour(
    _flag_button_hover
        ? c_white
        : c_yellow
);

draw_rectangle(
    _val_button_x1,
    _val_button_y1,
    _val_button_x2,
    _val_button_y2,
    false
);

draw_set_font(fnt_gui_medium);
draw_set_colour(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(
    x,
    (_val_button_y1 + _val_button_y2) * 0.5,
    "START BATTLE!"
);

//================//
//RESET DRAW STATE//
//================//

draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);