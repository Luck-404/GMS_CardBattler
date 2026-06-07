if (!instance_exists(obj_gui_end_battle_pane)){
	if (_status_sprite != undefined){
		draw_sprite(_status_sprite,0,x,y);
		draw_set_font(fnt_small_party_draw);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_colour(c_black);
		draw_text(x+5,y+10,string(_status_stacks));	
		draw_text(x-5,y+10,string(_status_lifetime));		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);	
	
		switch(_status_command){
			case "WAIT":
		
			break;
		
			case "REPEAT": //TRIGGER EFFECT AGAIN
				_status_scr("REPEAT",self);		
			break;
		
			case "DEATH": //WHEN EFFECT'S LIFE ENDS, OR IS REMOVED
				_status_scr("DEATH",self);
				_status_command = "WAIT";
			break;		
		}
	
		//----------------------------------------------------
		// TOOLTIP (CTRL HOVER)
		//----------------------------------------------------
		if (keyboard_check(vk_lcontrol) &&
		    position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), self))
		{
		    var _line1 = string(_status_name) + " | " + string(_status_desc);

		    var _line2 =
		        "LIFE: " + string(_status_lifetime)
		        + " | STACKS: " + string(_status_stacks);
			
			var _line3;
			if(_trigger_region== "undefined"){
			    _line3 =
			        "TRIGGERS AT: NEVER";
			} else {
			    _line3 =
			        "TRIGGERS AT: " + string(_trigger_region);
			}
		
		    var _panel_w = max(
		        string_width(_line1),
		        max(
		            string_width(_line2),
		            string_width(_line3)
		        )
		    ) + 24;

		    var _panel_h = 70;

		    var _px = room_width * 0.5 - (_panel_w * 0.5);
		    var _py = 20;

		    // background
		    draw_set_colour(c_dkgray);
		    draw_rectangle(
		        _px,
		        _py,
		        _px + _panel_w,
		        _py + _panel_h,
		        false
		    );

		    // border
		    draw_set_colour(c_black);
		    draw_rectangle(
		        _px,
		        _py,
		        _px + _panel_w,
		        _py + _panel_h,
		        true
		    );

		    // text
		    draw_set_colour(c_white);

		    draw_text(
		        _px + (_panel_w - string_width(_line1)) * 0.5,
		        _py + 8,
		        _line1
		    );

		    draw_text(
		        _px + (_panel_w - string_width(_line2)) * 0.5,
		        _py + 26,
		        _line2
		    );

		    draw_text(
		        _px + (_panel_w - string_width(_line3)) * 0.5,
		        _py + 44,
		        _line3
		    );
		}	
	}
}