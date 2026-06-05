//
//
// DRAW: OBJ_GUI_PARTY | DRAW PARTY AND HANDLE LOGIC RELATED
//
//

//
// PARTY DRAW | DRAWS PLAYER'S PARTY IN GUI PANE
//
#region PARTY DRAW IN PANE
draw_self();
for (var _i = 0; _i < _unit_count; _i++)
{
    var _box_x = _row_start_x + ((_slot_size + _spacing) * _i);
    var _box_y = _row_y;

    var _unit = ds_list_find_value(global.player_party, _i);

    // Outline
    draw_set_colour(c_black);
    draw_rectangle(_box_x, _box_y,_box_x + _slot_size,_box_y + _slot_size,false);

    // Fill
    draw_set_colour(c_gray);
    draw_rectangle(_box_x + 5,_box_y + 5,_box_x + 95,_box_y + 95,false);

    // Center
    var _unit_x = _box_x + (_slot_size * 0.5);
    var _unit_y = _box_y + (_slot_size * 0.5);

    // Shadow
    var _shadow = scr_get_beast_type_shadow(_unit[?"beast_color_type"]);
    draw_sprite_ext(_shadow, 0, _unit_x, _unit_y + 25, 1, 1, 0, c_white, 1);

    // Unit
    draw_sprite_ext(_unit[?"beast_sprite"],0,_unit_x,_unit_y,0.125,0.125,0,c_white,1);
	
	//SLECT UNIT
	if (_i == _pos){
		draw_sprite(spr_gui_party_selected,0,_unit_x,_unit_y);
	}
	//HIGHLIGHT HOVER AND LEFT CLICK SELECTS
	if (mouse_x > _box_x && mouse_x < _box_x + _slot_size && mouse_y > _box_y && mouse_y < _box_y + _slot_size){
		draw_sprite(spr_gui_party_highlight,0,_unit_x,_unit_y);
		if (mouse_check_button_pressed(mb_left) && _flag_clicked == false){
			_cooldown = 10;
			_flag_clicked = true;
			if (ds_list_find_value(global.player_party,_pos) != undefined){
				_pos = _i;	
				_unit_selected = ds_list_find_value(global.player_party,_pos);
			}
		}
	//
	// REORDER
	//		
	for (var _k = 1; _k <= 5; _k++)
	{
	    if (keyboard_check_pressed(ord(string(_k))))
	    {
	        var _target = _k - 1; // key 1 = slot 0

	        // valid target + don't swap with self
	        if (_target < _unit_count && _target != _i)
	        {
	            var _hover_unit  = ds_list_find_value(global.player_party, _i);
	            var _target_unit = ds_list_find_value(global.player_party, _target);

	            ds_list_replace(global.player_party, _i, _target_unit);
	            ds_list_replace(global.player_party, _target, _hover_unit);

	            // refresh selected ref if it exists
	            if (_unit_selected != undefined)
	            {
	                _unit_selected = ds_list_find_value(global.player_party, _pos);
	            }

	            _flag_clicked = true;
	            _cooldown = 10;
	        }

	        break;
	    }
	}	
	}

	
}
#endregion

#region CLICK COOLDOWN
if (_flag_clicked == true){
	if (_cooldown > 0){
		_cooldown--;	
	} else {
		_cooldown = 0;
		_flag_clicked = false;
	}
}
#endregion

#region DRAW SELECTED DATA

if (_unit_selected != undefined)
{
    var _u = _unit_selected;

    var _x = _pane_left + 25;
    var _y = _row_y + _slot_size + 40;

    var _lh = 22;
    var _sg = 32;

    draw_set_colour(c_black);
	draw_set_font(fnt_gui_small);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);	

    // ==========================
    // HEADER
    // ==========================
	_color_1 = _u[?"beast_colors"][0];
	_color_2 = _u[?"beast_colors"][1];
	_color_type = _u[?"beast_color_type"];
	
    draw_text(
        _x, _y,
        _u[?"beast_name"]
        + " | LV "
        + string(_u[?"beast_level"])
        + " | "
        + string(_u[?"beast_exp"])
        + "/100"
    );
    _y += _lh;

    draw_text(
        _x, _y,
        _u[?"beast_archetype"]
        + " | "
        + _u[?"beast_class"]
    );
    _y += _lh;

	var _color_string;

	if (_color_2 == undefined)
	{
	    _color_string = string(_color_1);
	}
	else
	{
	    _color_string = string(_color_1) + ", " + string(_color_2);
	}

	draw_text(
	    _x, _y,
	    _color_string
	    + " | "
	    + string(_color_type)
	);
    _y += _lh;

    draw_text(
        _x, _y,
        "HP: "
        + string(_u[?"beast_hp_cur"])
        + "/"
        + string(_u[?"beast_hp_max"])
    );

    _y += _sg;

	// ==========================
	// CORE STATS
	// ==========================
	draw_text(_x, _y, "=== CORE STATS ===");
	_y += _lh;

	_hp_stat   = _u[?"beast_hp_stat"];
	_con_stat  = _u[?"beast_con_stat"];
	_ppow_stat = _u[?"beast_ppow_stat"];
	_mpow_stat = _u[?"beast_mpow_stat"];
	_pdef_stat = _u[?"beast_pdef_stat"];
	_mdef_stat = _u[?"beast_mdef_stat"];

	draw_text(_x, _y,
	    "HP: "
	    + string(_hp_stat)
	    + " | "
	    + scr_get_beast_grade_letter(_hp_stat)
	    + " "
	    + string(scr_get_beast_grade_modifier(_hp_stat))
	);
	_y += _lh;

	draw_text(_x, _y,
	    "CON: "
	    + string(_con_stat)
	    + " | "
	    + scr_get_beast_grade_letter(_con_stat)
	    + " | "
	    + string(scr_get_beast_grade_modifier(_con_stat))
	);
	_y += _lh;

	draw_text(_x, _y,
	    "PPOW: "
	    + string(_ppow_stat)
	    + " | "
	    + scr_get_beast_grade_letter(_ppow_stat)
	    + " | "
	    + string(scr_get_beast_grade_modifier(_ppow_stat))
	);
	_y += _lh;

	draw_text(_x, _y,
	    "MPOW: "
	    + string(_mpow_stat)
	    + " | "
	    + scr_get_beast_grade_letter(_mpow_stat)
	    + " | "
	    + string(scr_get_beast_grade_modifier(_mpow_stat))
	);
	_y += _lh;

	draw_text(_x, _y,
	    "PDEF: "
	    + string(_pdef_stat)
	    + " | "
	    + scr_get_beast_grade_letter(_pdef_stat)
	    + " | "
	    + string(scr_get_beast_grade_modifier(_pdef_stat))
	);
	_y += _lh;

	draw_text(_x, _y,
	    "MDEF: "
	    + string(_mdef_stat)
	    + " | "
	    + scr_get_beast_grade_letter(_mdef_stat)
	    + " | "
	    + string(scr_get_beast_grade_modifier(_mdef_stat))
	);

	_y += _sg;

    // ==========================
    // SECONDARY
    // ==========================
    draw_text(_x, _y, "=== SECONDARY STATS ===");
    _y += _lh;

    draw_text(_x, _y, "CRIT: " + string(_u[?"beast_crit_stat"]));
    _y += _lh;

    draw_text(_x, _y, "DODGE: " + string(_u[?"beast_dod_stat"]));
    _y += _lh;

    draw_text(_x, _y, "MINION COUNT: " + string(_u[?"beast_min_stat"]));

    _y += _sg;

    // ==========================
    // HELD ITEM
    // ==========================
    draw_text(
        _x, _y,
        "HELD ITEM: " + string(_u[?"beast_held_item"])
    );

    _y += _sg;

    // ==========================
    // ABILITY
    // ==========================
    draw_text(
        _x, _y,
        "ABILITY: " + string(_u[?"beast_ability"])
    );

    _y += _sg;

    // ==========================
    // LORE
    // ==========================
    draw_text(_x, _y, "=== LORE ===");
    _y += _lh;

    draw_text_ext(
        _x,
        _y,
        _u[?"beast_lore"],
        -1,
        740
    );
	
    _y += _sg * 4.5;
	
    draw_text_ext(
        _x,
        _y,
        _u[?"beast_role"],
        -1,
        740
    );	
}

#endregion