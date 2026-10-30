//===============================================================================//
//
// SCRIPT: SCR_GUI_DRAW_BATTLE_INSPECTION_PANE
// FUNCTION: Draws the active Ctrl-inspection pane in the upper-left battle HUD.
//           Mirrors the current Battle Log dimensions.
//           Uses spaced Cheats-style text formatting.
//           Positions beneath the player's Mana rows.
//           Truncates the main body, but always reserves all 3 Recent Meals rows.
//
//===============================================================================//

function scr_gui_draw_battle_inspection_pane(){

	//================//
	//VALIDATE//
	//================//
	if (
		!variable_global_exists(
			"flag_battle_inspection"
		) ||
		!global.flag_battle_inspection
	){
		return false;
	}

	if (
		global.str_battle_inspection_title ==
		""
	){
		return false;
	}

	if (
		scr_gui_check_cheats_active()
	){
		return false;
	}

	#region LAYOUT

	//================//
	//DEFAULT SIZE//
	//================//
	var _val_pane_w = 200;

	var _val_header_h = 30;
	var _val_footer_h = 26;

	var _ct_entries = 4;
	var _val_entry_h = 48;

	var _val_pane_h =
		_val_header_h +
		(
			_ct_entries *
			_val_entry_h
		) +
		_val_footer_h;

	//========================//
	//MIRROR BATTLE LOG SIZE//
	//========================//
	if (
		instance_exists(
			obj_gui_battle_log_pane
		)
	){

		var _ref_log =
			instance_find(
				obj_gui_battle_log_pane,
				0
			);

		if (
			instance_exists(
				_ref_log
			)
		){

			_val_pane_w =
				_ref_log
					._val_pane_width;

			_val_pane_h =
				_ref_log
					._val_header_height +
				(
					_ref_log
						._ct_entries_per_page *
					_ref_log
						._val_entry_height
				) +
				_ref_log
					._val_footer_height;
		}
	}

	//================//
	//POSITION//
	//================//
	var _val_pane_x1 = 0;
	var _val_pane_y1 = 76;

	//================//
	//MANA CLEARANCE//
	//================//
	if (
		instance_exists(
			obj_battle_player_controller
		)
	){

		var _ref_player =
			instance_find(
				obj_battle_player_controller,
				0
			);

		if (
			instance_exists(
				_ref_player
			)
		){

			var _ct_mana_rows =
				max(
					1,
					ceil(
						max(
							1,
							_ref_player
								._val_max_mana
						) /
						max(
							1,
							_ref_player
								._ct_mana_per_row
						)
					)
				);

			var _val_mana_spacing =
				_ref_player
					._val_mana_orb_size +
				_ref_player
					._val_mana_orb_gap;

			var _val_last_mana_y =
				_ref_player
					._val_mana_start_y +
				(
					(
						_ct_mana_rows -
						1
					) *
					_val_mana_spacing
				);

			_val_pane_y1 =
				ceil(
					_val_last_mana_y +
					(
						_ref_player
							._val_mana_orb_size *
						0.5
					) +
					12
				);
		}
	}

	var _val_pane_x2 =
		_val_pane_x1 +
		_val_pane_w;

	var _val_pane_y2 =
		_val_pane_y1 +
		_val_pane_h;

	#endregion

	#region TEXT SETUP

	//================//
	//TEXT SETTINGS//
	//================//
	var _val_pad_x = 9;
	var _val_pad_y = 9;

	/*
		Extra vertical space between every rendered line.
		The old tooltip format used 4.
	*/
	var _val_line_sep = 12;

	var _val_title_body_gap = 12;

	var _val_text_w =
		_val_pane_w -
		(_val_pad_x * 2);

	draw_set_font(
		fnt_gui_party_small
	);

	draw_set_halign(
		fa_left
	);

	draw_set_valign(
		fa_top
	);

	var _str_title =
		global.str_battle_inspection_title;

	var _str_body =
		global.str_battle_inspection_body;

	//========================//
	//RECENT MEALS FOOTER//
	//========================//
	// Player Beast inspection data includes three meal rows at the end.
	// Extract those rows before the normal body-fit/truncation step.
	// The footer is anchored separately so all three rows remain visible.
	var _str_meals_header = "RECENT MEALS";
	var _str_meals_marker = "\n\n" + _str_meals_header;
	var _val_meals_pos = string_pos(_str_meals_marker,_str_body);
	var _str_meals_rows = "";
	var _val_meals_h = 0;
	var _val_meals_gap = 12;
	var _val_meals_sep = 12;

	if (_val_meals_pos > 0){

		var _str_meals_text = string_copy(
			_str_body,
			_val_meals_pos + string_length(_str_meals_marker),
			string_length(_str_body)
		);

		// The first character following the heading is a newline.
		if (string_char_at(_str_meals_text,1) == "\n"){
			_str_meals_text = string_delete(_str_meals_text,1,1);
		}

		_str_meals_rows = _str_meals_text;
		_str_body = string_copy(_str_body,1,_val_meals_pos - 1);

		_val_meals_h =
			string_height(_str_meals_header) +
			4 +
			string_height_ext(_str_meals_rows,_val_meals_sep,_val_text_w);

		// Normally this preserves the battle log's height. On very small
		// logs, expand just enough to fit the title, three meals and one
		// line of normal inspection data.
		var _val_required_h =
			(_val_pad_y * 2) +
			string_height(_str_title) +
			_val_title_body_gap +
			string_height("A") +
			_val_meals_gap +
			_val_meals_h;

		_val_pane_h = max(_val_pane_h,_val_required_h);
		_val_pane_y2 = _val_pane_y1 + _val_pane_h;
	}

	#endregion

	#region FIT TITLE

	//================//
	//FIT TITLE WIDTH//
	//================//
	if (
		string_width(
			_str_title
		) >
		_val_text_w
	){

		var _val_low_title = 0;

		var _val_high_title =
			string_length(
				_str_title
			);

		while (
			_val_low_title <
			_val_high_title
		){

			var _val_mid_title =
				floor(
					(
						_val_low_title +
						_val_high_title +
						1
					) *
					0.5
				);

			var _str_test_title =
				string_copy(
					_str_title,
					1,
					_val_mid_title
				) +
				"...";

			if (
				string_width(
					_str_test_title
				) <=
				_val_text_w
			){

				_val_low_title =
					_val_mid_title;
			}
			else{

				_val_high_title =
					_val_mid_title -
					1;
			}
		}

		_str_title =
			string_copy(
				_str_title,
				1,
				_val_low_title
			) +
			"...";
	}

	#endregion

	#region BODY LAYOUT

	//================//
	//BODY REGION//
	//================//
	var _val_title_h =
		string_height(
			_str_title
		);

	var _val_body_y =
		_val_pane_y1 +
		_val_pad_y +
		_val_title_h +
		_val_title_body_gap;

	var _val_meals_y = _val_pane_y2 - _val_pad_y - _val_meals_h;

	var _val_body_bottom = _val_pane_y2 - _val_pad_y;
	if (_val_meals_pos > 0){
		_val_body_bottom = _val_meals_y - _val_meals_gap;
	}

	var _val_max_body_h =
		max(
			1,
			_val_body_bottom - _val_body_y
		);

	//================//
	//FIT BODY HEIGHT//
	//================//
	var _str_draw_body =
		_str_body;

	if (
		string_height_ext(
			_str_draw_body,
			_val_line_sep,
			_val_text_w
		) >
		_val_max_body_h
	){

		var _val_low = 0;

		var _val_high =
			string_length(
				_str_draw_body
			);

		while (
			_val_low <
			_val_high
		){

			var _val_mid =
				floor(
					(
						_val_low +
						_val_high +
						1
					) *
					0.5
				);

			var _str_test =
				string_copy(
					_str_draw_body,
					1,
					_val_mid
				) +
				"...";

			if (
				string_height_ext(
					_str_test,
					_val_line_sep,
					_val_text_w
				) <=
				_val_max_body_h
			){

				_val_low =
					_val_mid;
			}
			else{

				_val_high =
					_val_mid -
					1;
			}
		}

		_str_draw_body =
			string_copy(
				_str_draw_body,
				1,
				_val_low
			) +
			"...";
	}

	#endregion

	#region PANEL

	//================//
	//BACKGROUND//
	//================//
	draw_set_alpha(
		0.96
	);

	draw_set_colour(
		c_black
	);

	draw_rectangle(
		_val_pane_x1,
		_val_pane_y1,
		_val_pane_x2,
		_val_pane_y2,
		false
	);

	//================//
	//OUTLINE//
	//================//
	draw_set_alpha(
		1
	);

	draw_set_colour(
		c_white
	);

	draw_rectangle(
		_val_pane_x1,
		_val_pane_y1,
		_val_pane_x2,
		_val_pane_y2,
		true
	);

	#endregion

	#region TITLE

	//================//
	//DRAW TITLE//
	//================//
	draw_set_colour(
		c_yellow
	);

	draw_text(
		_val_pane_x1 +
			_val_pad_x,
		_val_pane_y1 +
			_val_pad_y,
		_str_title
	);

	#endregion

	#region BODY

	//================//
	//DRAW BODY//
	//================//
	draw_set_colour(
		c_white
	);

	draw_text_ext(
		_val_pane_x1 +
			_val_pad_x,
		_val_body_y,
		_str_draw_body,
		_val_line_sep,
		_val_text_w
	);

	#endregion

	#region RECENT MEALS

	//========================//
	//PINNED RECENT MEALS//
	//========================//
	if (_val_meals_pos > 0){

		// Separate the untruncated three-row meal history from the body.
		draw_set_colour(c_gray);
		draw_line(
			_val_pane_x1 + _val_pad_x,
			_val_meals_y - 6,
			_val_pane_x2 - _val_pad_x,
			_val_meals_y - 6
		);

		draw_set_colour(c_yellow);
		draw_text(
			_val_pane_x1 + _val_pad_x,
			_val_meals_y,
			_str_meals_header
		);

		draw_set_colour(c_white);
		draw_text_ext(
			_val_pane_x1 + _val_pad_x,
			_val_meals_y + string_height(_str_meals_header) + 4,
			_str_meals_rows,
			_val_meals_sep,
			_val_text_w
		);
	}

	#endregion

	#region RESET

	draw_set_alpha(
		1
	);

	draw_set_colour(
		c_white
	);

	draw_set_halign(
		fa_left
	);

	draw_set_valign(
		fa_top
	);

	#endregion

	return true;
}

