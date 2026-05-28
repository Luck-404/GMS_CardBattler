//
//
// DRAW: OBJ_GUI_PARTY_PANE | DRAW PARTY UNITS, DRAW RANCH UNITS, ALLOW FOR MOVING BETWEEN THE TWO WITH A CLICK
//
//

//
// PARTY DRAW | DRAWS PLAYER'S PARTY IN GUI PANE
//
#region PARTY DRAW IN PANE
draw_self(); //DRAW PANE ITSELF

//DRAW SIGNIFIERS ABOVE THE PANE TO SHOW WHICH SIDE IS WHICH
#region SIGNS
draw_set_font(fnt_gui_medium);
draw_set_colour(c_white);
draw_text(_pane_left+100,_pane_top-25,"PARTY");
draw_text(_pane_left+615,_pane_top-25,"RANCH");
#endregion
draw_set_font(fnt_gui_small);

//
// PARTY SIDE (LEFT)
//
#region PARTY DRAW AND MOVING TO RANCH
for (var _i = 0; _i < 5; _i++)
{
    var _unit = ds_list_find_value(global.player_party, _i);

	//
	// DRAW BACKGROUND AND BOXES
	//
	#region BG
    var _box_x = _party_x;
    var _box_y = _start_y + (_i * (_slot_h + _slot_margin));

    // Background
    draw_set_colour(c_black);
    draw_rectangle(_box_x, _box_y, _box_x + _slot_w, _box_y + _slot_h, false);

    draw_set_colour(c_gray);
    draw_rectangle(_box_x + 4, _box_y + 4, _box_x + _slot_w - 4, _box_y + _slot_h - 4, false);
	#endregion
	
	//ALWAYS DRAW THE SLOTS EVEN IF NOT ENTIRELY FILLED.
	if (_unit != undefined){
		
    //
	// DRAW SPRITE BOX AS WELL AS UNIT
	//
	#region DRAW UNIT
    draw_set_colour(c_aqua);
    draw_rectangle(_box_x + 10, _box_y + 10, _box_x + 110, _box_y + 110, false);

    var _unit_x = _box_x + 60;
    var _unit_y = _box_y + 60;
    var _shadow = scr_get_beast_type_shadow(_unit[?"beast_color_type"]);
    draw_sprite_ext(_shadow, 0, _unit_x, _unit_y + 20, 1, 1, 0, c_white, 1);

    draw_sprite_ext(_unit[?"beast_sprite"],0,_unit_x,_unit_y,0.125,0.125,0,c_white,1);
	#endregion

	// 
    // DRAW UNIT INFO
	//
	#region DRAW UNIT INFO
    draw_set_colour(c_black);

    draw_text(_box_x + 125, _box_y + 20, _unit[?"beast_name"]);
    draw_text(_box_x + 125, _box_y + 45, "LV " + string(_unit[?"beast_level"]));
    draw_text(_box_x + 125, _box_y + 70, string(_unit[?"beast_hp_cur"]) + "/" + string(_unit[?"beast_hp_max"]));
	#endregion
	
	//
	// LEFT CLICKING UNITS FROM PARTY TO RANCH
	//
	#region LEFT CLICKING PARTY UNIT SENDS TO RANCH
	if (mouse_x > _box_x && mouse_x < _box_x + _slot_w && mouse_y > _box_y && mouse_y < _box_y + _slot_h && ds_list_size(global.player_party) > 1){
	    
		//DRAW THE HIGHLIGHT WHEN HOVERING
		draw_sprite(spr_ranch_gui_highlight, 0, _party_x + 185, _box_y + 65);

		//CHECK FOR CLICKS
	    if (mouse_check_button_pressed(mb_left) && !_flag_clicked){
			//ONLY ALLOW CLICK ONCE
	        _flag_clicked = true;
	        _cooldown = 10;

			//ADD TO RANCH, REMOVE FROM PARTY
	        ds_list_add(global.player_ranch, _unit);
	        ds_list_delete(global.player_party, _i);

			//SPAWN A NEW DUMMY UNIT
	        obj_ranch_gui_interactable.scr_spawn_ranch_unit(_unit);
			
			//UPDATE COUNTS
			_party_count = ds_list_size(global.player_party);
			_ranch_count = ds_list_size(global.player_ranch);
	    }
	}
	#endregion
	}
}
#endregion

//
// RANCH SIDE (RIGHT)
//
#region RANCH DRAW, MOVING TO PARTY, DELETING
var _start_index = _ranch_page * _ranch_per_page;

for (var _i = 0; _i < _ranch_per_page; _i++)
{
	//
	// DRAW SLOTS
	//
	#region DRAW SLOTS
    var _ranch_index = _start_index + _i;

    var _box_x = _ranch_x;
    var _box_y = _start_y + (_i * (_slot_h + _slot_margin));

    draw_set_colour(c_black);
    draw_rectangle(_box_x, _box_y, _box_x + _slot_w, _box_y + _slot_h, false);

    draw_set_colour(c_gray);
    draw_rectangle(_box_x + 4, _box_y + 4, _box_x + _slot_w - 4, _box_y + _slot_h - 4, false);
	#endregion
	
	//DRAW THE UNITS ON THE CURRENT PAGE
    if (_ranch_index < ds_list_size(global.player_ranch))
    {
        var _unit = ds_list_find_value(global.player_ranch, _ranch_index);

		if (_unit == undefined) continue;

		//
		// DRAW UNIT
		//
		#region DRAW UNIT
        draw_set_colour(c_green);
        draw_rectangle(_box_x + 10, _box_y + 10, _box_x + 110, _box_y + 110, false);

        var _unit_x = _box_x + 60;
        var _unit_y = _box_y + 60;

        var _shadow = scr_get_beast_type_shadow(_unit[?"beast_color_type"]);

        draw_sprite_ext(_shadow, 0, _unit_x, _unit_y + 20, 1, 1, 0, c_white, 1);

        draw_sprite_ext(
            _unit[?"beast_sprite"],
            0,
            _unit_x,
            _unit_y,
            0.125,
            0.125,
            0,
            c_white,
            1
        );
		#endregion
		
		//
		// DRAW UNIT INFO
		//
		#region DRAW UNIT INFO
        draw_set_colour(c_black);

        draw_text(_box_x + 125, _box_y + 20, _unit[?"beast_name"]);
        draw_text(_box_x + 125, _box_y + 45, "LV " + string(_unit[?"beast_level"]));
        draw_text(_box_x + 125, _box_y + 70,
            string(_unit[?"beast_hp_cur"]) + "/" +
            string(_unit[?"beast_hp_max"])
        );
		#endregion

        //
		// LEFT CLICK RANCH->PARTY
		//
		#region LEFT CLICKING
        if (mouse_x > _box_x && mouse_x < _box_x + _slot_w && mouse_y > _box_y && mouse_y < _box_y + _slot_h && ds_list_size(global.player_party) < 5){
            
			//DRAW HOVER HIGHLIGHT
			draw_sprite(spr_ranch_gui_highlight, 0, _ranch_x + 185, _box_y + 65);

			//CLICK
            if (mouse_check_button_pressed(mb_left) && !_flag_clicked)
            {
				//ONLY ALLOW CLICK ONCE
                _flag_clicked = true;
                _cooldown = 10;
				
				//ADD TO PARTY, REMOVE FROM RANCH
                ds_list_add(global.player_party, _unit);
                ds_list_delete(global.player_ranch, _ranch_index);

				//DESTROY DUMMY
                obj_ranch_gui_interactable.scr_destroy_ranch_unit(_unit[?"beast_uid"]);
				
				//UPDATE COUNTS
				_party_count = ds_list_size(global.player_party);
				_ranch_count = ds_list_size(global.player_ranch);					
            }
        }
		#endregion
		
		//
		// DELETE REMOVES UNIT FROM RANCH
		//
		#region DELETING UNIT
		if (keyboard_check_pressed(vk_delete) && _flag_clicked == false){
			//ONLY CLICK ONCE
            _flag_clicked = true;
            _cooldown = 10;			
			
			//REMOVE UNIT FROM RANCH
			ds_list_delete(global.player_ranch, _ranch_index);
			
			//REMOVE DUMMY FROM GAME
            obj_ranch_gui_interactable.scr_destroy_ranch_unit(_unit[?"beast_uid"]);

			//UPDATE COUNTS
			_party_count = ds_list_size(global.player_party);
			_ranch_count = ds_list_size(global.player_ranch);			
		}
		#endregion
    }
}

//
// PAGE DISPLAY
//
#region PAGES
//CALCULATE PAGES
var _total_pages = max(1, ceil(_ranch_count / _ranch_per_page));

draw_set_colour(c_black);
draw_set_halign(fa_center);

//DRAW
draw_text(_page_center_x,_page_y - 8,"PAGE " + string(_ranch_page + 1) + "/" + string(_total_pages));

draw_set_halign(fa_left);
#endregion

//
// CLICK COOLDOWN
//
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

