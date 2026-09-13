//===============================================================================//
//
// DRAW GUI END: OBJ_BATTLE_BEAST
// FUNCTION: Draws the hovered Beast inspection pane above other battle GUI.
//           Displays stats, current Speed, ability, held item, and Talent Trees.
//
//===============================================================================//

#region BEAST PREVIEW

//---------------//
//VALIDATE PREVIEW//
//---------------//
if (
	!_flag_preview_beast ||
	!is_struct(_ref_unit) ||
	instance_exists(obj_gui_end_battle_pane)
){
	exit;
}

//--------------//
//PANEL LAYOUT//
//--------------//
var _val_panel_w = 360;
var _val_panel_h = 420;

var _val_panel_x = room_width * 0.5 - (_val_panel_w * 0.5);
var _val_panel_y = 40;

var _val_text_x = _val_panel_x + 12;
var _val_text_y = _val_panel_y + 12;
var _val_line_height = 18;

//----------------//
//PANEL BACKGROUND//
//----------------//
draw_set_colour(c_dkgray);

draw_rectangle(
	_val_panel_x,
	_val_panel_y,
	_val_panel_x + _val_panel_w,
	_val_panel_y + _val_panel_h,
	false
);

draw_set_colour(c_black);

draw_rectangle(
	_val_panel_x,
	_val_panel_y,
	_val_panel_x + _val_panel_w,
	_val_panel_y + _val_panel_h,
	true
);

//----------//
//TEXT SETUP//
//----------//
draw_set_font(fnt_gui_small);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

//----------//
//BEAST NAME//
//----------//
draw_text(_val_text_x,_val_text_y,string(_ref_unit._str_beast_name));

_val_text_y += _val_line_height * 2;

//------//
//STATS//
//------//
draw_text(_val_text_x,_val_text_y,"=== STATS ===");

_val_text_y += _val_line_height;

var _val_hp = _ref_unit._val_beast_hp_stat;
var _val_con = _ref_unit._val_beast_con_stat;
var _val_ppow = _ref_unit._val_beast_ppow_stat;
var _val_mpow = _ref_unit._val_beast_mpow_stat;
var _val_pdef = _ref_unit._val_beast_pdef_stat;
var _val_mdef = _ref_unit._val_beast_mdef_stat;
var _val_crit = _ref_unit._val_beast_crit_stat;
var _val_dodge = _ref_unit._val_beast_dod_stat;
var _val_speed = scr_battle_get_beast_speed(self);
var _val_minions = _ref_unit._val_beast_min_stat;

draw_text(_val_text_x,_val_text_y,"HP: " + string(_val_hp) + " (" + scr_beast_get_grade_letter(_val_hp) + " x" + string(scr_beast_get_grade_modifier(_val_hp)) + ")");
_val_text_y += _val_line_height;

draw_text(_val_text_x,_val_text_y,"CON: " + string(_val_con) + " (" + scr_beast_get_grade_letter(_val_con) + " x" + string(scr_beast_get_grade_modifier(_val_con)) + ")");
_val_text_y += _val_line_height;

draw_text(_val_text_x,_val_text_y,"PPOW: " + string(_val_ppow) + " (" + scr_beast_get_grade_letter(_val_ppow) + " x" + string(scr_beast_get_grade_modifier(_val_ppow)) + ")");
_val_text_y += _val_line_height;

draw_text(_val_text_x,_val_text_y,"MPOW: " + string(_val_mpow) + " (" + scr_beast_get_grade_letter(_val_mpow) + " x" + string(scr_beast_get_grade_modifier(_val_mpow)) + ")");
_val_text_y += _val_line_height;

draw_text(_val_text_x,_val_text_y,"PDEF: " + string(_val_pdef) + " (" + scr_beast_get_grade_letter(_val_pdef) + " x" + string(scr_beast_get_grade_modifier(_val_pdef)) + ")");
_val_text_y += _val_line_height;

draw_text(_val_text_x,_val_text_y,"MDEF: " + string(_val_mdef) + " (" + scr_beast_get_grade_letter(_val_mdef) + " x" + string(scr_beast_get_grade_modifier(_val_mdef)) + ")");
_val_text_y += _val_line_height;

draw_text(_val_text_x,_val_text_y,"CRIT: " + string(_val_crit));
_val_text_y += _val_line_height;

draw_text(_val_text_x,_val_text_y,"DODGE: " + string(_val_dodge));
_val_text_y += _val_line_height;

draw_text(_val_text_x,_val_text_y,"SPEED: " + string(_val_speed));
_val_text_y += _val_line_height;

draw_text(_val_text_x,_val_text_y,"MINIONS: " + string(_val_minions));
_val_text_y += _val_line_height * 2;

//---------//
//ABILITY//
//---------//
draw_text(_val_text_x,_val_text_y,"=== ABILITY ===");

_val_text_y += _val_line_height;

draw_text_ext(
	_val_text_x,
	_val_text_y,
	string(_ref_unit._str_beast_ability),
	-1,
	320
);

_val_text_y += 60;

//----------//
//HELD ITEM//
//----------//
draw_text(_val_text_x,_val_text_y,"=== HELD ITEM ===");

_val_text_y += _val_line_height;

var _str_held_item = "NONE";

if (_stct_held_item != undefined && _stct_held_item != "EMPTY"){
	_str_held_item = string(_stct_held_item._str_item_name);
}

draw_text(_val_text_x,_val_text_y,_str_held_item);

_val_text_y += _val_line_height * 2;

//-------------//
//TALENT TREES//
//-------------//
draw_text(_val_text_x,_val_text_y,"=== TALENT TREES ===");

_val_text_y += _val_line_height;

var _arr_trees = _ref_unit._arr_beast_talent_trees;
var _str_tree_text = "";

for (var _it_tree = 0; _it_tree < array_length(_arr_trees); _it_tree++){

	if (_it_tree > 0){
		_str_tree_text += ", ";
	}

	_str_tree_text += string(_arr_trees[_it_tree]);
}

draw_text(_val_text_x,_val_text_y,_str_tree_text);

#endregion