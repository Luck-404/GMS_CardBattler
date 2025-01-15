///////////////////////////////////////////////
// DISPLAYS  CARDS TOP LEFT DURING OVERWORLD //
///////////////////////////////////////////////
if (room == rm_overworld){
	// TODO
	// // HELPER - LIST CARD NAMES AND POSITIONS
	//for (var _i = 0; _i < ds_list_size(global.card_inventory); _i++) {
	//    var _ref_card = ds_list_find_value(global.card_inventory, _i);
	//    var _name = _ref_card[?"name"];
	//	show_debug_message("Card " + string(_i) + " is " + _name);
	//}
	
	
	var _margin = 10;
	var _card_width = 32;
	var _card_height = 32;
	var _spacing = 3;

	 // Draw the card sprite
	for (var _i = 0; _i < ds_list_size(global.card_inventory); _i++) {
	    var _ref_card = ds_list_find_value(global.card_inventory, _i);
	    var _sprite = _ref_card[?"sprite"];
	    var _x_pos = _margin + (_i * (_card_width + _spacing));
	    var _y_pos = _margin;
	    draw_sprite_ext(_sprite, 0, _x_pos, _y_pos, 0.1, 0.1, 0, c_white, 1);
	}

	// Draw the total card count
	draw_text(1800,30,"Cards: " + string(ds_list_size(global.card_inventory)));
	// Draw the total card count
	draw_text(1800,60,"Gold: " + string(global.gold));	
	
	//draw the current team's hp bottom right
	for (var _i = 0; _i < ds_list_size(global.player_team); _i++){
		var _ref_creature = ds_list_find_value(global.player_team,_i);
		draw_sprite_ext(_ref_creature[?"sprite"],0,1700,960,0.2,0.2,0,c_white,1);		
		draw_text(1750,960,"HP: " + string(_ref_creature[?"curhp"]) + "/" + string(_ref_creature[?"hp"]));
	}

}