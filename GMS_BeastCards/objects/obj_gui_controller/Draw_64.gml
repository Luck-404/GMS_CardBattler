//
//
// DRAW GUI: OBJ_UI_CONTROLLER | DRAW GUI INFO
//
//
#region PAUSE NOTIFIER
	if (global.pause){
	draw_set_colour(c_white);
	draw_set_font(fnt_gui_large);
	draw_text((room_width/2)-string_width("GAME PAUSED")/2,(room_height/8-100),"GAME PAUSED");
	}
#endregion

//
// PARTY DRAW | DRAWS PLAYER'S PARTY IN OVERWORLD
//
#region PARTY DRAW
if (global.active_gui == undefined){
	for (var _i = 0; _i < ds_list_size(global.player_party); _i++){
	#region SETUP BACKGROUND BOX
	var _box_x = 5+(95*_i);
	//DRAW A BLACK OUTLINE
	draw_set_colour(c_black);
	draw_rectangle(_box_x,105,_box_x+100,5,false);
	
	//DRAW A GRAY BOX
	draw_set_colour(c_gray);
	draw_rectangle(_box_x+5,10,_box_x+95,100,false);
	#endregion
	
	#region DRAW UNIT
	var _unit_x = _box_x + 50;
	var _unit = ds_list_find_value(global.player_party,_i);
	
	//DRAW THE PLAYER'S UNITS AND THEIR INFO
	
	//DRAW APPROPRIATE SHADOW
	var _shadow    = scr_get_beast_type_shadow(_unit[?"beast_color_type"]);
	draw_sprite_ext(_shadow,0,_unit_x,80,1,1,0,c_white,1);
	
	//DRAW UNIT
	draw_sprite_ext(_unit[?"beast_sprite"],0,_unit_x,55,0.125,0.125,0,c_white,1); //DRAW UNIT SPRITE (its 512x512, draw it as 64x64... or 0.125 scaling)
	
	//DRAW INFO
	draw_set_colour(c_black);
	draw_set_font(fnt_small_party_draw);
	
	//GOAL:
		//"NAME" - "LEVEL" - "CUR HP" / "MAX HP" 
		//"TYPE" - "ABILITY" - "BREED"
		
	// GET DATA
	var _name    = _unit[?"beast_name"];
	var _level   = _unit[?"beast_level"];
	var _hp_cur  = _unit[?"beast_hp_cur"];
	var _hp_max  = _unit[?"beast_hp_max"];

	// BUILD STRING
	var _line1 = string(_name) + " - Lv." + string(_level) + " - " + string(_hp_cur) + "/" + string(_hp_max);

	// DRAW TEXT
	draw_text(_box_x + 8, 115, _line1);
	#endregion	
	}
}
#endregion
