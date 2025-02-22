//////////////////////////////////////////////////////////////////////
//							OBJ_PLAYER DRAW							//
//																	//
// > DRAWS THE PLAYER'S SHADOW CIRCLE								//
//////////////////////////////////////////////////////////////////////
draw_self();
draw_sprite(spr_player_circle,0,x,y+15);

if (room == rm_encounter){	
		for (var _i = 0; _i < ds_list_size(global.player_team); _i++){	
			var _ref_unit = ds_list_find_value(global.player_team, _i);
			draw_set_font(fnt_fanwood);
			draw_set_color(c_black);
			draw_text(room_width/2 - 500 + (150*_i), room_width/2,string(_ref_unit[?"curhp"]) + "/" + string(_ref_unit[?"hp"]));
		}
}