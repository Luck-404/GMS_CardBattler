//===============================================================================//
//
// BEAST PREVIEW
// FUNCTION: Draws an inspection panel for the hovered beast while
//           the preview key is held.
//           Displays core stats, ability, and talent trees.
//
//===============================================================================//
#region BEAST PREVIEW
if (_flag_preview_beast && _stct_unit != undefined){

	draw_set_font(fnt_small_gui);
	draw_set_colour(c_black);

	var _val_panel_w = 360;
	var _val_panel_h = 380;

	var _val_panel_x = room_width * 0.5 - (_val_panel_w * 0.5);
	var _val_panel_y = 40;

	draw_set_colour(c_dkgray);
	draw_rectangle(_val_panel_x,_val_panel_y,_val_panel_x + _val_panel_w,_val_panel_y + _val_panel_h,false);

	draw_set_colour(c_black);
	draw_rectangle(_val_panel_x,_val_panel_y,_val_panel_x + _val_panel_w,_val_panel_y + _val_panel_h,true);

	var _val_text_x = _val_panel_x + 12;
	var _val_text_y = _val_panel_y + 12;
	var _val_lh = 18;

	draw_set_colour(c_white);

	draw_text(_val_text_x,_val_text_y,string(_stct_unit._str_beast_name));

	_val_text_y += _val_lh * 2;

	draw_text(_val_text_x,_val_text_y,"=== STATS ===");
	_val_text_y += _val_lh;

	var _val_hp = _stct_unit._val_beast_hp_stat;
	var _val_con = _stct_unit._val_beast_con_stat;
	var _val_ppow = _stct_unit._val_beast_ppow_stat;
	var _val_mpow = _stct_unit._val_beast_mpow_stat;
	var _val_pdef = _stct_unit._val_beast_pdef_stat;
	var _val_mdef = _stct_unit._val_beast_mdef_stat;
	var _val_crit = _stct_unit._val_beast_crit_stat;
	var _val_dodge = _stct_unit._val_beast_dod_stat;
	var _val_minions = _stct_unit._val_beast_min_stat;

	draw_text(_val_text_x,_val_text_y,"HP: " + string(_val_hp) + " (" + scr_get_beast_grade_letter(_val_hp) + " x" + string(scr_get_beast_grade_modifier(_val_hp)) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"CON: " + string(_val_con) + " (" + scr_get_beast_grade_letter(_val_con) + " x" + string(scr_get_beast_grade_modifier(_val_con)) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"PPOW: " + string(_val_ppow) + " (" + scr_get_beast_grade_letter(_val_ppow) + " x" + string(scr_get_beast_grade_modifier(_val_ppow)) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"MPOW: " + string(_val_mpow) + " (" + scr_get_beast_grade_letter(_val_mpow) + " x" + string(scr_get_beast_grade_modifier(_val_mpow)) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"PDEF: " + string(_val_pdef) + " (" + scr_get_beast_grade_letter(_val_pdef) + " x" + string(scr_get_beast_grade_modifier(_val_pdef)) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"MDEF: " + string(_val_mdef) + " (" + scr_get_beast_grade_letter(_val_mdef) + " x" + string(scr_get_beast_grade_modifier(_val_mdef)) + ")");
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"CRIT: " + string(_val_crit));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"DODGE: " + string(_val_dodge));
	_val_text_y += _val_lh;

	draw_text(_val_text_x,_val_text_y,"MINIONS: " + string(_val_minions));
	_val_text_y += _val_lh * 2;

	draw_text(_val_text_x,_val_text_y,"=== ABILITY ===");
	_val_text_y += _val_lh;

	draw_text_ext(_val_text_x,_val_text_y,string(_stct_unit._str_beast_ability),-1,320);

	_val_text_y += 60;

	draw_text(_val_text_x,_val_text_y,"=== TALENT TREES ===");
	_val_text_y += _val_lh;

	var _arr_trees = _stct_unit._arr_beast_talent_trees;
	var _str_tree_text = "";

	for (var _it_tree = 0; _it_tree < array_length(_arr_trees); _it_tree++){
		if (_it_tree > 0){
			_str_tree_text += ", ";
		}

		_str_tree_text += string(_arr_trees[_it_tree]);
	}

	draw_text(_val_text_x,_val_text_y,_str_tree_text);
}
#endregion