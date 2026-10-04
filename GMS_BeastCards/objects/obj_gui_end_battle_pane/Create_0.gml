//===============================================================================//
//
// CREATE: OBJ_GUI_END_BATTLE_PANE
// FUNCTION: Initializes the end battle pane.
//           Stores battle result state, normalized reward display data,
//           battle-grade data, party layout, and result-screen drawing helpers.
//           Creates the confirm button used to leave the battle result screen.
//           Immediately closes the Cheats Menu and clears GUI pause state.
//
//===============================================================================//

//---------//
//VARIABLES//
//---------//
#region VARIABLES

//--------//
//BUTTON//
//--------//
_ref_confirm_button = instance_create_layer(
	room_width * 0.5,
	room_height * 0.5 + 450,
	"ily_fx",
	obj_gui_end_battle_confirm_button
);

//--------------//
//RESULT STATE//
//--------------//
_str_condition = "";
_flag_finished = false;

//-------------//
//PANE LAYOUT//
//-------------//
_val_pane_w = 800;
_val_pane_h = 800;

_val_pane_left =
	x -
	(_val_pane_w * 0.5);

_val_pane_top =
	y -
	(_val_pane_h * 0.5);

//--------------//
//PARTY DISPLAY//
//--------------//
_val_slot_size = 100;
_val_spacing = 15;
_val_padding_y = 15;
_flag_score_hovered = false;
_ct_units = 0;

if (
	instance_exists(obj_battle_player_controller) &&
	ds_exists(
		obj_battle_player_controller._list_beasts,
		ds_type_list
	)
){

	_ct_units =
		ds_list_size(
			obj_battle_player_controller._list_beasts
		);
}

_val_total_width =
	(_ct_units * _val_slot_size) +
	(max(0,_ct_units - 1) * _val_spacing);

_val_row_start_x =
	x -
	(_val_total_width * 0.5);

_val_row_y =
	_val_pane_top +
	500;

//--------------//
//REWARD DISPLAY//
//--------------//
_arr_reward_entries = [];
_arr_reward_display = [];
_it_hovered_reward = -1;
_stct_hovered_reward = undefined;
_stct_reward_result = undefined;
_stct_battle_grade = undefined;

//-------------------//
//REWARD LIST LAYOUT//
//-------------------//
_val_reward_list_x1 =
	_val_pane_left +
	40;

_val_reward_list_x2 =
	_val_pane_left +
	_val_pane_w -
	40;

_val_reward_list_y1 =
	_val_pane_top +
	150;

_val_reward_list_y2 =
	_val_row_y -
	55;

//----------------//
//BATTLE SNAPSHOT//
//----------------//
// Assigned by OBJ_BATTLE_TURN_CONTROLLER immediately after this pane is created.
_val_battle_elapsed_seconds = 0;
_ct_battle_rounds = 0;

#endregion

//----//
//INIT//
//----//
#region INIT

//================//
//CLOSE CHEATS//
//================//
var _flag_cheats_active =
	variable_global_exists("ref_active_gui") &&
	instance_exists(global.ref_active_gui) &&
	variable_instance_exists(
		global.ref_active_gui,
		"_str_type"
	) &&
	global.ref_active_gui._str_type == "CHEATS";

if (_flag_cheats_active){

	if (instance_exists(obj_gui_controller)){

		obj_gui_controller.hscr_gui_destroy_active(
			"BATTLE END PANE"
		);
	}
	else{

		var _ref_cheats =
			global.ref_active_gui;

		global.ref_active_gui =
			undefined;

		instance_destroy(
			_ref_cheats
		);
	}
}

//================//
//CLEAR GUI PAUSE//
//================//
if (instance_exists(obj_gui_controller)){

	obj_gui_controller.hscr_gui_set_pause(
		false,
		"BATTLE END PANE"
	);
}
else{

	global.flag_pause =
		false;
}

#endregion

//-------//
//METHODS//
//-------//
#region METHODS

//—------------------------------------------------------------------------------//
// HSCR_GUI_END_BATTLE_GET_RARITY_COLOUR
// FUNCTION: Returns the display colour used for a Card rarity.
//—------------------------------------------------------------------------------//
hscr_gui_end_battle_get_rarity_colour = function(_str_rarity){

	_str_rarity =
		string_upper(
			string(
				_str_rarity
			)
		);

	switch (_str_rarity){

		case "I":
			return c_white;

		case "II":
			return make_colour_rgb(
				110,
				225,
				130
			);

		case "III":
			return c_aqua;

		case "IV":
			return c_yellow;
	}

	return c_white;
};


//—------------------------------------------------------------------------------//
// HSCR_GUI_END_BATTLE_GET_REWARD_COLOUR
// FUNCTION: Returns the accent colour for one normalized reward row.
//—------------------------------------------------------------------------------//
hscr_gui_end_battle_get_reward_colour = function(_stct_reward){

	if (!is_struct(_stct_reward)){
		return c_white;
	}

	switch (_stct_reward._str_reward_type){

		case "GOLD":
			return c_yellow;

		case "EXP":
			return c_aqua;

		case "CARD":
			return hscr_gui_end_battle_get_rarity_colour(
				_stct_reward._str_rarity
			);

		case "ITEM":

			switch (_stct_reward._str_reward_subtype){

				case "MATERIAL":
					return make_colour_rgb(
						184,
						156,
						110
					);

				case "EGG":
					return make_colour_rgb(
						180,
						100,
						255
					);

				case "PRISM":
					return c_aqua;

				case "CONSUMABLE":
					return c_lime;

				case "HELD":
					return make_colour_rgb(
						255,
						140,
						0
					);

				case "QUEST":
					return c_yellow;
			}

		break;
	}

	return c_white;
};


//-------------------------------------------------------------------------------//
// HSCR_GUI_END_BATTLE_GET_SOURCE_TEXT
// FUNCTION: Returns readable source text for one normalized reward.
//-------------------------------------------------------------------------------//
hscr_gui_end_battle_get_source_text = function(_stct_reward){

	if (!is_struct(_stct_reward)){
		return "";
	}

	var _str_source =
		string_upper(
			string(
				_stct_reward._str_source
			)
		);

	var _str_detail =
		string_upper(
			string(
				_stct_reward
					._str_source_detail
			)
		);

	_str_detail =
		string_replace_all(
			_str_detail,
			"_",
			" "
		);

	switch (_str_source){

		case "BATTLE":
			return "BATTLE";

		case "EGG":

			if (_str_detail != ""){
				return "EGG | " + _str_detail;
			}

			return "EGG";

		case "BEAST_MATERIAL":

			if (_str_detail != ""){
				return "BEAST | " + _str_detail;
			}

			return "BEAST";

		case "ZONE_MATERIAL":

			if (_str_detail != ""){
				return "ZONE | " + _str_detail;
			}

			return "ZONE";

		case "BEAST_CARD":

			if (_str_detail != ""){
				return "BEAST | " + _str_detail;
			}

			return "BEAST";

		case "ZONE_CARD":

			if (_str_detail != ""){
				return "ZONE | " + _str_detail;
			}

			return "ZONE";

		case "BEAST_ITEM":

			if (_str_detail != ""){
				return "BEAST | " + _str_detail;
			}

			return "BEAST";

		case "ZONE_ITEM":

			if (_str_detail != ""){
				return "ZONE | " + _str_detail;
			}

			return "ZONE";

		case "SECRET_ZONE_ITEM":

			if (_str_detail != ""){
				return "SECRET | " + _str_detail;
			}

			return "SECRET";

		case "GLOBAL_BONUS":
			return "BONUS LOOT FOUND";

		case "MULTIPLE":
			return "MULTIPLE SOURCES";
	}

	if (_str_detail != ""){

		return
			string_replace_all(
				_str_source,
				"_",
				" "
			) +
			" | " +
			_str_detail;
	}

	return string_replace_all(
		_str_source,
		"_",
		" "
	);
};


//-------------------------------------------------------------------------------//
// HSCR_GUI_END_BATTLE_BUILD_REWARD_DISPLAY
// FUNCTION: Builds display-only reward rows from normalized reward results.
//           Normal duplicate Items/Cards are merged.
//           GLOBAL_BONUS rewards remain separate so their special presentation
//           can never be lost through duplicate merging.
//-------------------------------------------------------------------------------//
hscr_gui_end_battle_build_reward_display = function(){

	_arr_reward_display = [];

	if (!is_array(_arr_reward_entries)){
		return;
	}

	for (
		var _it_reward = 0;
		_it_reward <
			array_length(
				_arr_reward_entries
			);
		_it_reward++
	){

		var _stct_reward =
			_arr_reward_entries[
				_it_reward
			];

		if (!is_struct(_stct_reward)){
			continue;
		}

		var _str_reward_type =
			string_upper(
				string(
					_stct_reward
						._str_reward_type
				)
			);

		var _str_reward_subtype =
			string_upper(
				string(
					_stct_reward
						._str_reward_subtype
				)
			);

		var _str_reward_id =
			string_upper(
				string(
					_stct_reward
						._str_reward_id
				)
			);

		var _str_rarity =
			string_upper(
				string(
					_stct_reward
						._str_rarity
				)
			);

		var _str_source =
			string_upper(
				string(
					_stct_reward
						._str_source
				)
			);

		var _str_source_detail =
			string_upper(
				string(
					_stct_reward
						._str_source_detail
				)
			);

		var _flag_bonus_loot =
			_str_source ==
			"GLOBAL_BONUS";

		var _ct_amount =
			max(
				1,
				_stct_reward
					._ct_amount
			);

		var _ct_recipients = 0;

		if (
			variable_struct_exists(
				_stct_reward,
				"_ct_recipients"
			)
		){

			_ct_recipients =
				max(
					0,
					_stct_reward
						._ct_recipients
				);
		}

		//=======================//
		//CHECK EXISTING DISPLAY//
		//=======================//
		var _it_existing = -1;

		for (
			var _it_display = 0;
			_it_display <
				array_length(
					_arr_reward_display
				);
			_it_display++
		){

			var _stct_existing =
				_arr_reward_display[
					_it_display
				];

			if (!is_struct(_stct_existing)){
				continue;
			}

			var _flag_existing_bonus =
				_stct_existing._str_source ==
				"GLOBAL_BONUS";

			if (
				_stct_existing._str_reward_type ==
					_str_reward_type &&
				_stct_existing._str_reward_subtype ==
					_str_reward_subtype &&
				_stct_existing._str_reward_id ==
					_str_reward_id &&
				_stct_existing._str_rarity ==
					_str_rarity &&
				_flag_existing_bonus ==
					_flag_bonus_loot
			){

				_it_existing =
					_it_display;

				break;
			}
		}

		//===================//
		//MERGE DUPLICATE ROW//
		//===================//
		if (_it_existing >= 0){

			var _stct_existing =
				_arr_reward_display[
					_it_existing
				];

			_stct_existing._ct_amount +=
				_ct_amount;

			_stct_existing._ct_recipients =
				max(
					_stct_existing
						._ct_recipients,
					_ct_recipients
				);

			if (
				!_flag_bonus_loot &&
				(
					_stct_existing._str_source !=
						_str_source ||
					_stct_existing
						._str_source_detail !=
						_str_source_detail
				)
			){

				_stct_existing._str_source =
					"MULTIPLE";

				_stct_existing._str_source_detail =
					"";
			}

			continue;
		}

		//================//
		//CREATE NEW ROW//
		//================//
		array_push(
			_arr_reward_display,
			{
				_str_reward_type :
					_str_reward_type,

				_str_reward_subtype :
					_str_reward_subtype,

				_str_reward_id :
					_str_reward_id,

				_str_display_name :
					string(
						_stct_reward
							._str_display_name
					),

				_ct_amount :
					_ct_amount,

				_ct_recipients :
					_ct_recipients,

				_str_rarity :
					_str_rarity,

				_str_source :
					_str_source,

				_str_source_detail :
					_str_source_detail,

				_spr_reward :
					_stct_reward._spr_reward
			}
		);
	}
};

//—------------------------------------------------------------------------------//
// HSCR_GUI_END_BATTLE_DRAW_SCORE
// FUNCTION: Draws the battle score in a centered hoverable box.
//—------------------------------------------------------------------------------//
hscr_gui_end_battle_draw_score = function(){

	_flag_score_hovered = false;

	if (!is_struct(_stct_battle_grade)){
		return;
	}

	//================//
	//SCORE BOX//
	//================//
	var _val_box_w = 190;
	var _val_box_h = 44;

	var _val_box_x1 =
		x -
		(_val_box_w * 0.5);

	var _val_box_x2 =
		x +
		(_val_box_w * 0.5);

	var _val_box_y1 =
		_val_pane_top +
		70;

	var _val_box_y2 =
		_val_box_y1 +
		_val_box_h;

	//================//
	//CHECK HOVER//
	//================//
	var _val_mouse_x =
		device_mouse_x_to_gui(0);

	var _val_mouse_y =
		device_mouse_y_to_gui(0);

	_flag_score_hovered =
		point_in_rectangle(
			_val_mouse_x,
			_val_mouse_y,
			_val_box_x1,
			_val_box_y1,
			_val_box_x2,
			_val_box_y2
		);

	//================//
	//DRAW BACKGROUND//
	//================//
	draw_set_colour(
		_flag_score_hovered ?
			make_colour_rgb(
				75,
				75,
				75
			) :
			global.c_dk_gray
	);

	draw_rectangle(
		_val_box_x1,
		_val_box_y1,
		_val_box_x2,
		_val_box_y2,
		false
	);

	//=============//
	//DRAW BORDER//
	//=============//
	draw_set_colour(
		c_black
	);

	draw_rectangle(
		_val_box_x1,
		_val_box_y1,
		_val_box_x2,
		_val_box_y2,
		true
	);

	//===========//
	//DRAW SCORE//
	//===========//
	draw_set_font(
		fnt_gui_medium
	);

	draw_set_halign(
		fa_center
	);

	draw_set_valign(
		fa_middle
	);

	draw_set_colour(
		c_white
	);

	draw_text(
		x,
		_val_box_y1 +
		(_val_box_h * 0.5),
		"SCORE: " +
		string(
			round(
				_stct_battle_grade._val_score
			)
		)
	);

	//================//
	//RESET DRAW STATE//
	//================//
	draw_set_halign(
		fa_left
	);

	draw_set_valign(
		fa_top
	);
};

//—------------------------------------------------------------------------------//
// HSCR_GUI_END_BATTLE_DRAW_SCORE_TOOLTIP
// FUNCTION: Draws the battle-score criteria while the score box is hovered.
//           Uses fixed line spacing so all tooltip text remains inside the box.
//—------------------------------------------------------------------------------//
hscr_gui_end_battle_draw_score_tooltip = function(){

	if (!_flag_score_hovered){
		return;
	}

	if (!is_struct(_stct_battle_grade)){
		return;
	}

	#region VARIABLES

	var _val_gui_w =
		display_get_gui_width();

	var _val_gui_h =
		display_get_gui_height();

	var _val_mouse_x =
		device_mouse_x_to_gui(0);

	var _val_mouse_y =
		device_mouse_y_to_gui(0);

	var _val_tooltip_w = 470;

	var _val_padding = 12;
	var _val_line_h = 15;

	var _val_optional_bonus =
		_stct_battle_grade
			._val_optional_chance_bonus;

	var _val_gold_bonus =
		(
			_stct_battle_grade
				._val_gold_multiplier -
			1
		) *
		100;

	var _arr_tooltip_lines = [

		"HOW BATTLE SCORE IS EARNED",

		"",

		"TIME",
		"<=45s +40 | <=75s +35 | <=120s +30",
		"<=180s +22 | <=300s +12 | >300s +5",

		"",

		"FINAL PARTY HP",
		">=90% +40 | >=80% +35 | >=65% +28",
		">=50% +20 | >=25% +10 | <25% +0",

		"",

		"ENCOUNTER DIFFICULTY",
		"EASY +0 | MEDIUM +5 | HARD +10 | ELITE +15",

		"",

		"ENEMY AVG LEVEL ABOVE PARTY",
		"+1-2 +2 | +3-4 +4 | +5 OR MORE +5",
		"EQUAL OR LOWER +0",

		"",

		"CURRENT SCORE: " +
		string(
			round(
				_stct_battle_grade._val_score
			)
		),

		"DROP BONUS: +" +
		string_format(
			_val_optional_bonus,
			0,
			1
		) +
		"% | GOLD BONUS: +" +
		string(
			round(
				_val_gold_bonus
			)
		) +
		"%"
	];

	var _ct_lines =
		array_length(
			_arr_tooltip_lines
		);

	var _val_tooltip_h =
		(_val_padding * 2) +
		(_ct_lines * _val_line_h);

	var _val_tooltip_x =
		clamp(
			_val_mouse_x +
			18,
			10,
			_val_gui_w -
			_val_tooltip_w -
			10
		);

	var _val_tooltip_y =
		clamp(
			_val_mouse_y +
			18,
			10,
			_val_gui_h -
			_val_tooltip_h -
			10
		);

	#endregion

	#region DRAW BOX

	//------//
	//SHADOW//
	//------//
	draw_set_alpha(
		0.45
	);

	draw_set_colour(
		c_black
	);

	draw_rectangle(
		_val_tooltip_x + 4,
		_val_tooltip_y + 4,
		_val_tooltip_x +
			_val_tooltip_w +
			4,
		_val_tooltip_y +
			_val_tooltip_h +
			4,
		false
	);

	//----------//
	//BACKGROUND//
	//----------//
	draw_set_alpha(
		0.97
	);

	draw_set_colour(
		global.c_dk_gray
	);

	draw_rectangle(
		_val_tooltip_x,
		_val_tooltip_y,
		_val_tooltip_x +
			_val_tooltip_w,
		_val_tooltip_y +
			_val_tooltip_h,
		false
	);

	//------//
	//BORDER//
	//------//
	draw_set_alpha(
		1
	);

	draw_set_colour(
		c_yellow
	);

	draw_rectangle(
		_val_tooltip_x,
		_val_tooltip_y,
		_val_tooltip_x +
			_val_tooltip_w,
		_val_tooltip_y +
			_val_tooltip_h,
		true
	);

	#endregion

	#region DRAW TEXT

	draw_set_font(
		fnt_gui_party_small
	);

	draw_set_halign(
		fa_left
	);

	draw_set_valign(
		fa_top
	);

	for (
		var _it_line = 0;
		_it_line < _ct_lines;
		_it_line++
	){

		var _str_line =
			_arr_tooltip_lines[
				_it_line
			];

		//----------------//
		//SECTION COLOUR//
		//----------------//
		var _flag_heading =
			_str_line ==
				"HOW BATTLE SCORE IS EARNED" ||
			_str_line ==
				"TIME" ||
			_str_line ==
				"FINAL PARTY HP" ||
			_str_line ==
				"ENCOUNTER DIFFICULTY" ||
			_str_line ==
				"ENEMY AVG LEVEL ABOVE PARTY";

		draw_set_colour(
			_flag_heading ?
				c_yellow :
				c_white
		);

		draw_text(
			_val_tooltip_x +
				_val_padding,
			_val_tooltip_y +
				_val_padding +
				(_it_line * _val_line_h),
			_str_line
		);
	}

	#endregion

	#region RESET DRAW STATE

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
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_END_BATTLE_DRAW_REWARDS
// FUNCTION: Draws normalized rewards as a compact variable-length vertical list.
//           Tracks the currently hovered reward row for tooltip display.
//           GLOBAL_BONUS Cards receive a pink outline and BONUS LOOT FOUND label.
//-------------------------------------------------------------------------------//
hscr_gui_end_battle_draw_rewards = function(){

	_it_hovered_reward = -1;
	_stct_hovered_reward = undefined;

	var _ct_rewards =
		array_length(
			_arr_reward_display
		);

	if (_ct_rewards <= 0){

		draw_set_font(
			fnt_gui_small
		);

		draw_set_halign(
			fa_center
		);

		draw_set_colour(
			c_black
		);

		draw_text(
			x,
			_val_reward_list_y1,
			"NO REWARD DATA"
		);

		draw_set_halign(
			fa_left
		);

		return;
	}

	#region VARIABLES

	var _c_bonus_loot =
		make_colour_rgb(
			255,
			105,
			180
		);

	var _c_hover =
		c_white;

	var _val_mouse_x =
		device_mouse_x_to_gui(0);

	var _val_mouse_y =
		device_mouse_y_to_gui(0);

	var _val_available_h =
		_val_reward_list_y2 -
		_val_reward_list_y1;

	var _val_row_h =
		min(
			34,
			floor(
				_val_available_h /
				max(
					1,
					_ct_rewards
				)
			)
		);

	_val_row_h =
		max(
			24,
			_val_row_h
		);

	#endregion

	#region HEADER

	draw_set_font(
		fnt_gui_small
	);

	draw_set_halign(
		fa_left
	);

	draw_set_valign(
		fa_top
	);

	draw_set_colour(
		c_black
	);

	draw_text(
		_val_reward_list_x1,
		_val_reward_list_y1 - 24,
		"REWARDS"
	);

	#endregion

	#region DRAW ROWS

	for (
		var _it_reward = 0;
		_it_reward < _ct_rewards;
		_it_reward++
	){

		var _stct_reward =
			_arr_reward_display[
				_it_reward
			];

		if (!is_struct(_stct_reward)){
			continue;
		}

		var _flag_bonus_loot =
			_stct_reward._str_source ==
			"GLOBAL_BONUS";

		var _val_row_y =
			_val_reward_list_y1 +
			(_it_reward * _val_row_h);

		var _val_row_y2 =
			_val_row_y +
			_val_row_h -
			2;

		//================//
		//CHECK ROW HOVER//
		//================//
		var _flag_hovered =
			point_in_rectangle(
				_val_mouse_x,
				_val_mouse_y,
				_val_reward_list_x1,
				_val_row_y,
				_val_reward_list_x2,
				_val_row_y2
			);

		if (_flag_hovered){

			_it_hovered_reward =
				_it_reward;

			_stct_hovered_reward =
				_stct_reward;
		}

		var _c_accent =
			_flag_bonus_loot
			? _c_bonus_loot
			: hscr_gui_end_battle_get_reward_colour(
				_stct_reward
			);

		//================//
		//ROW BACKGROUND//
		//================//
		draw_set_alpha(
			_flag_hovered
			? 1
			: 0.92
		);

		draw_set_colour(
			global.c_dk_gray
		);

		draw_rectangle(
			_val_reward_list_x1,
			_val_row_y,
			_val_reward_list_x2,
			_val_row_y2,
			false
		);

		draw_set_alpha(
			1
		);

		//================//
		//BONUS PINK BORDER//
		//================//
		if (_flag_bonus_loot){

			draw_set_colour(
				_c_bonus_loot
			);

			draw_rectangle(
				_val_reward_list_x1,
				_val_row_y,
				_val_reward_list_x2,
				_val_row_y2,
				true
			);

			draw_rectangle(
				_val_reward_list_x1 + 1,
				_val_row_y + 1,
				_val_reward_list_x2 - 1,
				_val_row_y2 - 1,
				true
			);
		}
		else if (_flag_hovered){

			//================//
			//NORMAL HOVER BORDER//
			//================//
			draw_set_colour(
				_c_hover
			);

			draw_rectangle(
				_val_reward_list_x1,
				_val_row_y,
				_val_reward_list_x2,
				_val_row_y2,
				true
			);
		}

		//===============//
		//ACCENT STRIPE//
		//===============//
		draw_set_colour(
			_c_accent
		);

		draw_rectangle(
			_val_reward_list_x1,
			_val_row_y,
			_val_reward_list_x1 + 5,
			_val_row_y2,
			false
		);

		//========//
		//SPRITE//
		//========//
		var _spr_reward =
			_stct_reward._spr_reward;

		var _val_icon_x =
			_val_reward_list_x1 +
			23;

		var _val_icon_y =
			_val_row_y +
			(_val_row_h * 0.5);

		if (
			_spr_reward != undefined &&
			sprite_exists(
				_spr_reward
			)
		){

			var _val_sprite_w =
				max(
					1,
					sprite_get_width(
						_spr_reward
					)
				);

			var _val_sprite_h =
				max(
					1,
					sprite_get_height(
						_spr_reward
					)
				);

			var _val_icon_scale =
				min(
					24 /
						_val_sprite_w,
					24 /
						_val_sprite_h
				);

			draw_sprite_ext(
				_spr_reward,
				0,
				_val_icon_x,
				_val_icon_y,
				_val_icon_scale,
				_val_icon_scale,
				0,
				c_white,
				1
			);
		}

		//================//
		//REWARD NAME//
		//================//
		var _str_reward_name =
			string(
				_stct_reward
					._str_display_name
			);

		var _str_amount =
			"";

		switch (
			_stct_reward
				._str_reward_type
		){

			case "GOLD":

				_str_reward_name =
					"GOLD";

				_str_amount =
					"+" +
					string(
						_stct_reward
							._ct_amount
					);

			break;

			case "EXP":

				_str_reward_name =
					"EXP";

				_str_amount =
					"+" +
					string(
						_stct_reward
							._ct_amount
					) +
					" EACH";

			break;

			default:

				if (
					_stct_reward
						._ct_amount > 1
				){

					_str_amount =
						"x" +
						string(
							_stct_reward
								._ct_amount
						);
				}

			break;
		}

		draw_set_font(
			fnt_gui_small
		);

		draw_set_halign(
			fa_left
		);

		draw_set_valign(
			fa_middle
		);

		draw_set_colour(
			c_white
		);

		var _val_name_x =
			_val_reward_list_x1 +
			44;

		draw_text(
			_val_name_x,
			_val_icon_y,
			_str_reward_name
		);

		var _val_text_cursor =
			_val_name_x +
			string_width(
				_str_reward_name
			);

		//========//
		//RARITY//
		//========//
		if (
			_stct_reward
				._str_reward_type ==
				"CARD" &&
			_stct_reward
				._str_rarity !=
				""
		){

			var _str_rarity =
				" [" +
				_stct_reward
					._str_rarity +
				"]";

			draw_set_colour(
				hscr_gui_end_battle_get_rarity_colour(
					_stct_reward
						._str_rarity
				)
			);

			draw_text(
				_val_text_cursor,
				_val_icon_y,
				_str_rarity
			);

			_val_text_cursor +=
				string_width(
					_str_rarity
				);
		}

		//========//
		//AMOUNT//
		//========//
		if (_str_amount != ""){

			draw_set_colour(
				c_white
			);

			draw_text(
				_val_text_cursor + 8,
				_val_icon_y,
				_str_amount
			);
		}

		//===============//
		//SOURCE / EXTRA//
		//===============//
		var _str_source =
			hscr_gui_end_battle_get_source_text(
				_stct_reward
			);

		if (
			_stct_reward
				._str_reward_type ==
				"EXP" &&
			_stct_reward
				._ct_recipients > 0
		){

			_str_source =
				string(
					_stct_reward
						._ct_recipients
				) +
				" BEASTS";
		}

		draw_set_font(
			fnt_gui_party_small
		);

		draw_set_halign(
			fa_right
		);

		draw_set_colour(
			_flag_bonus_loot
			? _c_bonus_loot
			: c_ltgray
		);

		draw_text(
			_val_reward_list_x2 - 10,
			_val_icon_y,
			_str_source
		);

		draw_set_halign(
			fa_left
		);
	}

	#endregion

	#region RESET

	draw_set_valign(
		fa_top
	);

	draw_set_halign(
		fa_left
	);

	draw_set_alpha(
		1
	);

	draw_set_colour(
		c_white
	);

	#endregion
};


//—------------------------------------------------------------------------------//
// HSCR_GUI_END_BATTLE_DRAW_PARTY
// FUNCTION: Draws the post-battle Party row.
//—------------------------------------------------------------------------------//
hscr_gui_end_battle_draw_party = function(_flag_draw_level=true){

	var _val_display_index = 0;

	for (
		var _it_beast = 0;
		_it_beast < ds_list_size(global.list_player_party);
		_it_beast++
	){

		var _stct_beast =
			ds_list_find_value(
				global.list_player_party,
				_it_beast
			);

		if (!is_struct(_stct_beast)){
			continue;
		}

		var _ref_battle_beast =
			noone;

		//-------------------//
		//FIND BATTLE BEAST//
		//-------------------//
		for (
			var _it_battle_beast = 0;
			_it_battle_beast <
				ds_list_size(
					obj_battle_player_controller
						._list_beasts
				);
			_it_battle_beast++
		){

			var _ref_check_beast =
				ds_list_find_value(
					obj_battle_player_controller
						._list_beasts,
					_it_battle_beast
				);

			if (!instance_exists(_ref_check_beast)){
				continue;
			}

			if (
				_ref_check_beast._uid_beast ==
				_stct_beast._uid_beast
			){

				_ref_battle_beast =
					_ref_check_beast;

				break;
			}
		}

		if (!instance_exists(_ref_battle_beast)){
			continue;
		}

		var _flag_dead =
			_ref_battle_beast._val_cur_hp <= 0;

		//---------------//
		//SLOT POSITION//
		//---------------//
		var _val_box_x =
			_val_row_start_x +
			(
				(_val_slot_size + _val_spacing) *
				_val_display_index
			);

		var _val_box_y =
			_val_row_y;

		_val_display_index++;

		//-----------//
		//DRAW SLOT//
		//-----------//
		draw_set_colour(
			c_black
		);

		draw_rectangle(
			_val_box_x,
			_val_box_y,
			_val_box_x + _val_slot_size,
			_val_box_y + _val_slot_size,
			false
		);

		draw_set_colour(
			_flag_dead ?
				c_maroon :
				global.c_dk_gray
		);

		draw_rectangle(
			_val_box_x + 5,
			_val_box_y + 5,
			_val_box_x + 95,
			_val_box_y + 95,
			false
		);

		//-----------//
		//DRAW BEAST//
		//-----------//
		var _val_beast_x =
			_val_box_x +
			(_val_slot_size * 0.5);

		var _val_beast_y =
			_val_box_y +
			(_val_slot_size * 0.5);

		var _spr_shadow =
			scr_beast_get_type_shadow(
				_stct_beast._str_beast_color_type
			);

		draw_sprite_ext(
			_spr_shadow,
			0,
			_val_beast_x,
			_val_beast_y + 24,
			1,
			1,
			0,
			c_white,
			1
		);

		var _c_beast =
			_flag_dead ?
				c_ltgray :
				c_white;

		draw_sprite_ext(
			_stct_beast._spr_beast,
			0,
			_val_beast_x,
			_val_beast_y,
			0.125,
			0.125,
			0,
			_c_beast,
			1
		);

		//--------//
		//DRAW HP//
		//--------//
		draw_set_font(
			fnt_gui_small
		);

		draw_set_halign(
			fa_left
		);

		draw_set_valign(
			fa_top
		);

		draw_set_colour(
			c_black
		);

		var _str_hp = "";

		if (_flag_dead){

			_str_hp =
				"DEAD";
		}
		else{

			_str_hp =
				"HP: " +
				string(
					_ref_battle_beast._val_cur_hp
				) +
				"/" +
				string(
					_ref_battle_beast._val_max_hp
				);
		}

		var _val_text_x =
			_val_beast_x;

		var _val_text_y =
			_val_box_y +
			_val_slot_size +
			15;

		draw_text(
			_val_text_x -
				(string_width(_str_hp) * 0.5),
			_val_text_y,
			_str_hp
		);

		//-----------//
		//DRAW LEVEL//
		//-----------//
		if (_flag_draw_level){

			var _str_level =
				"Level: " +
				string(
					_stct_beast._val_beast_level
				);

			draw_text(
				_val_text_x -
					(string_width(_str_level) * 0.5),
				_val_text_y + 30,
				_str_level
			);
		}
	}
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_END_BATTLE_GET_REWARD_DESCRIPTION
// FUNCTION: Returns the authoritative description text for a normalized reward.
//           Card descriptions come from SCR_CARD_GET_INFO.
//           Item descriptions come from SCR_INVENTORY_GET_ITEM_INFO.
//           Gold and EXP use simple result-screen descriptions.
//-------------------------------------------------------------------------------//
hscr_gui_end_battle_get_reward_description = function(_stct_reward){

	if (!is_struct(_stct_reward)){
		return "";
	}

	var _str_reward_type =
		string_upper(
			string(
				_stct_reward._str_reward_type
			)
		);

	var _str_reward_id =
		string_upper(
			string(
				_stct_reward._str_reward_id
			)
		);

	switch (_str_reward_type){

		//======//
		//CARD//
		//======//
		case "CARD":

			var _stct_card =
				scr_card_get_info(
					_str_reward_id
				);

			if (
				is_struct(_stct_card) &&
				variable_struct_exists(
					_stct_card,
					"_str_card_description"
				)
			){

				return string(
					_stct_card._str_card_description
				);
			}

		break;

		//======//
		//ITEM//
		//======//
		case "ITEM":

			var _stct_item =
				scr_inventory_get_item_info(
					_str_reward_id
				);

			if (
				is_struct(_stct_item) &&
				variable_struct_exists(
					_stct_item,
					"_str_item_desc"
				)
			){

				return string(
					_stct_item._str_item_desc
				);
			}

		break;

		//======//
		//GOLD//
		//======//
		case "GOLD":

			return
				"Currency earned from battle. Gold rewards increase with enemy Level, Battle Score, and applicable Held Item bonuses.";

		//=====//
		//EXP//
		//=====//
		case "EXP":

			return
				"Experience awarded to each surviving Party Beast. Higher-Level encounters award more EXP.";

	}

	return "No description available.";
};

//-------------------------------------------------------------------------------//
// HSCR_GUI_END_BATTLE_DRAW_REWARD_TOOLTIP
// FUNCTION: Draws the hovered reward's name, type/source information, and
//           authoritative Card or Item description.
//-------------------------------------------------------------------------------//
hscr_gui_end_battle_draw_reward_tooltip = function(){

	if (!is_struct(_stct_hovered_reward)){
		return;
	}

	#region VARIABLES

	var _stct_reward =
		_stct_hovered_reward;

	var _val_gui_w =
		display_get_gui_width();

	var _val_gui_h =
		display_get_gui_height();

	var _val_mouse_x =
		device_mouse_x_to_gui(0);

	var _val_mouse_y =
		device_mouse_y_to_gui(0);

	var _val_tooltip_w = 420;
	var _val_padding = 12;

	var _val_title_h = 20;
	var _val_meta_h = 18;
	var _val_gap = 6;

	var _val_description_sep = 14;

	var _str_name =
		string(
			_stct_reward
				._str_display_name
		);

	var _str_description =
		hscr_gui_end_battle_get_reward_description(
			_stct_reward
		);

	var _str_source =
		hscr_gui_end_battle_get_source_text(
			_stct_reward
		);

	var _str_meta = "";

	#endregion

	#region META TEXT

	switch (_stct_reward._str_reward_type){

		case "CARD":

			_str_meta =
				"CARD";

			if (_stct_reward._str_rarity != ""){

				_str_meta +=
					" | RARITY " +
					_stct_reward
						._str_rarity;
			}

		break;

		case "ITEM":

			_str_meta =
				string_replace_all(
					_stct_reward
						._str_reward_subtype,
					"_",
					" "
				);

		break;

		case "GOLD":

			_str_meta =
				"CURRENCY";

		break;

		case "EXP":

			_str_meta =
				"EXPERIENCE";

		break;
	}

	if (_str_source != ""){

		_str_meta +=
			" | " +
			_str_source;
	}

	#endregion

	#region DESCRIPTION HEIGHT

	draw_set_font(
		fnt_gui_party_small
	);

	var _val_description_w =
		_val_tooltip_w -
		(_val_padding * 2);

	var _val_description_h =
		string_height_ext(
			_str_description,
			_val_description_sep,
			_val_description_w
		);

	var _val_tooltip_h =
		(_val_padding * 2) +
		_val_title_h +
		_val_meta_h +
		_val_gap +
		_val_description_h;

	_val_tooltip_h =
		max(
			78,
			_val_tooltip_h
		);

	#endregion

	#region POSITION

	var _val_tooltip_x =
		_val_mouse_x +
		18;

	var _val_tooltip_y =
		_val_mouse_y +
		18;

	//------------------//
	//PREFER RIGHT SIDE//
	//------------------//
	if (
		_val_tooltip_x +
		_val_tooltip_w >
		_val_gui_w -
		10
	){

		_val_tooltip_x =
			_val_mouse_x -
			_val_tooltip_w -
			18;
	}

	//----------------//
	//CLAMP TO SCREEN//
	//----------------//
	_val_tooltip_x =
		clamp(
			_val_tooltip_x,
			10,
			_val_gui_w -
			_val_tooltip_w -
			10
		);

	_val_tooltip_y =
		clamp(
			_val_tooltip_y,
			10,
			_val_gui_h -
			_val_tooltip_h -
			10
		);

	#endregion

	#region COLOURS

	var _flag_bonus_loot =
		_stct_reward._str_source ==
		"GLOBAL_BONUS";

	var _c_border =
		_flag_bonus_loot
		? make_colour_rgb(
			255,
			105,
			180
		)
		: hscr_gui_end_battle_get_reward_colour(
			_stct_reward
		);

	#endregion

	#region SHADOW

	draw_set_alpha(
		0.45
	);

	draw_set_colour(
		c_black
	);

	draw_rectangle(
		_val_tooltip_x + 4,
		_val_tooltip_y + 4,
		_val_tooltip_x +
			_val_tooltip_w +
			4,
		_val_tooltip_y +
			_val_tooltip_h +
			4,
		false
	);

	#endregion

	#region BACKGROUND

	draw_set_alpha(
		0.98
	);

	draw_set_colour(
		global.c_dk_gray
	);

	draw_rectangle(
		_val_tooltip_x,
		_val_tooltip_y,
		_val_tooltip_x +
			_val_tooltip_w,
		_val_tooltip_y +
			_val_tooltip_h,
		false
	);

	#endregion

	#region BORDER

	draw_set_alpha(
		1
	);

	draw_set_colour(
		_c_border
	);

	draw_rectangle(
		_val_tooltip_x,
		_val_tooltip_y,
		_val_tooltip_x +
			_val_tooltip_w,
		_val_tooltip_y +
			_val_tooltip_h,
		true
	);

	#endregion

	#region TITLE

	draw_set_font(
		fnt_gui_small
	);

	draw_set_halign(
		fa_left
	);

	draw_set_valign(
		fa_top
	);

	draw_set_colour(
		c_white
	);

	draw_text(
		_val_tooltip_x +
			_val_padding,
		_val_tooltip_y +
			_val_padding,
		_str_name
	);

	#endregion

	#region META

	draw_set_font(
		fnt_gui_party_small
	);

	draw_set_colour(
		_c_border
	);

	draw_text(
		_val_tooltip_x +
			_val_padding,
		_val_tooltip_y +
			_val_padding +
			_val_title_h,
		_str_meta
	);

	#endregion

	#region DESCRIPTION

	draw_set_colour(
		c_white
	);

	draw_text_ext(
		_val_tooltip_x +
			_val_padding,
		_val_tooltip_y +
			_val_padding +
			_val_title_h +
			_val_meta_h +
			_val_gap,
		_str_description,
		_val_description_sep,
		_val_description_w
	);

	#endregion

	#region RESET DRAW STATE

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
};

#endregion

