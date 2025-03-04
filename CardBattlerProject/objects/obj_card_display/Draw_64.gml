//////////////////////////////////////////////////////////////////////
//					OBJ_CARD_DISPLAY DRAW GUI						//
//																	//
// > DRAW GUI FEATURES WHILE IN OVERWORLD -DRAW CARD DECK 			//
//////////////////////////////////////////////////////////////////////
if (instance_exists(obj_player) && !instance_exists(obj_transition) && ds_list_size(global.player_deck) != 0){
	
	//TEMP draw steps
	draw_text(1800, 200, "Steps: " + string(global.step_count));
	//TEMP draw particle trigger
	draw_text(1800, 100, "Particles?: " + string(obj_player._counter_particles));
	
	var _margin = 10;
	var _card_width = 32;
	var _card_height = 32;
	var _spacing = 3;

	 // Draw the card sprite
	for (var _i = 0; _i < ds_list_size(global.player_deck); _i++) {
	    var _ref_card = ds_list_find_value(global.player_deck, _i);
	    var _sprite = _ref_card[?"sprite"];
	    var _x_pos = _margin + (_i * (_card_width + _spacing));
	    var _y_pos = _margin;
	    draw_sprite_ext(_sprite, 0, _x_pos, _y_pos, 0.1, 0.1, 0, c_white, 1);
	}

	// Draw the total card count
	draw_text(1800,30,"Cards: " + string(ds_list_size(global.player_deck)));
	// Draw the total card count
	draw_text(1800,60,"Gold: " + string(global.gold));	
	
	
	//draw the current team's hp bottom right
	for (var _i = 0; _i < ds_list_size(global.player_party); _i++){
		var _ref_creature = ds_list_find_value(global.player_party,_i);
		draw_sprite_ext(_ref_creature[?"sprite"],0,1700,500+(_i*100),0.2,0.2,0,c_white,1);		
		draw_text(1750,500+(_i*100),"HP: " + string(_ref_creature[?"curhp"]) + "/" + string(_ref_creature[?"hp"]));
	}
	
	// Draw player x and y
	draw_text(960,10,string(obj_player.x) + "x " + string(obj_player.y) + "y");	

}