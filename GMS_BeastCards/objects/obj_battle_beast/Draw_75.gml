

#region BEAST PREVIEW

if (_preview_beast && _ref_unit != undefined)
{
	var _u = _ref_unit;

	draw_set_font(fnt_gui_small);
	draw_set_colour(c_black);

	var _panel_w = 360;
	var _panel_h = 380;

	var _panel_x = room_width * 0.5 - (_panel_w * 0.5);
	var _panel_y = 40;

	// background
	draw_set_colour(c_dkgray);
	draw_rectangle(
		_panel_x,
		_panel_y,
		_panel_x + _panel_w,
		_panel_y + _panel_h,
		false
	);

	draw_set_colour(c_black);
	draw_rectangle(
		_panel_x,
		_panel_y,
		_panel_x + _panel_w,
		_panel_y + _panel_h,
		true
	);

	var _tx = _panel_x + 12;
	var _ty = _panel_y + 12;
	var _lh = 18;

	draw_set_colour(c_white);

	//
	// NAME
	//
	draw_text(
		_tx,
		_ty,
		string(_u[?"beast_name"])
	);

	_ty += _lh * 2;

	//
	// STATS
	//
	draw_text(_tx,_ty,"=== STATS ===");
	_ty += _lh;

	var _hp    = _u[?"beast_hp_stat"];
	var _con   = _u[?"beast_con_stat"];
	var _ppow  = _u[?"beast_ppow_stat"];
	var _mpow  = _u[?"beast_mpow_stat"];
	var _pdef  = _u[?"beast_pdef_stat"];
	var _mdef  = _u[?"beast_mdef_stat"];
	var _crit  = _u[?"beast_crit_stat"];
	var _dodge = _u[?"beast_dod_stat"];
	var _min   = _u[?"beast_min_stat"];

	draw_text(
	    _tx,
	    _ty,
	    "HP: "
	    + string(_hp)
	    + " ("
	    + scr_get_beast_grade_letter(_hp)
	    + " x"
	    + string(scr_get_beast_grade_modifier(_hp))
	    + ")"
	);
	_ty += _lh;

	draw_text(
	    _tx,
	    _ty,
	    "CON: "
	    + string(_con)
	    + " ("
	    + scr_get_beast_grade_letter(_con)
	    + " x"
	    + string(scr_get_beast_grade_modifier(_con))
	    + ")"
	);
	_ty += _lh;

	draw_text(
	    _tx,
	    _ty,
	    "PPOW: "
	    + string(_ppow)
	    + " ("
	    + scr_get_beast_grade_letter(_ppow)
	    + " x"
	    + string(scr_get_beast_grade_modifier(_ppow))
	    + ")"
	);
	_ty += _lh;

	draw_text(
	    _tx,
	    _ty,
	    "MPOW: "
	    + string(_mpow)
	    + " ("
	    + scr_get_beast_grade_letter(_mpow)
	    + " x"
	    + string(scr_get_beast_grade_modifier(_mpow))
	    + ")"
	);
	_ty += _lh;

	draw_text(
	    _tx,
	    _ty,
	    "PDEF: "
	    + string(_pdef)
	    + " ("
	    + scr_get_beast_grade_letter(_pdef)
	    + " x"
	    + string(scr_get_beast_grade_modifier(_pdef))
	    + ")"
	);
	_ty += _lh;

	draw_text(
	    _tx,
	    _ty,
	    "MDEF: "
	    + string(_mdef)
	    + " ("
	    + scr_get_beast_grade_letter(_mdef)
	    + " x"
	    + string(scr_get_beast_grade_modifier(_mdef))
	    + ")"
	);
	_ty += _lh;

	// NEW STATS
	draw_text(_tx, _ty, "CRIT: " + string(_crit));
	_ty += _lh;

	draw_text(_tx, _ty, "DODGE: " + string(_dodge));
	_ty += _lh;

	draw_text(_tx, _ty, "MINIONS: " + string(_min));
	_ty += _lh * 2;

	//
	// ABILITY
	//
	draw_text(_tx,_ty,"=== ABILITY ===");
	_ty += _lh;

	draw_text_ext(
		_tx,
		_ty,
		string(_u[?"beast_ability"]),
		-1,
		320
	);

	_ty += 60;

	//
	// TALENT TREES
	//
	draw_text(_tx,_ty,"=== TALENT TREES ===");
	_ty += _lh;

	var _trees = _u[?"beast_talent_trees"];
	var _tree_text = "";

	for (var _i = 0; _i < array_length(_trees); _i++)
	{
		if (_i > 0) _tree_text += ", ";
		_tree_text += string(_trees[_i]);
	}

	draw_text(
		_tx,
		_ty,
		_tree_text
	);
}

#endregion