///////////////////////////////////////////////
// DISPLAYS  CARDS TOP LEFT DURING OVERWORLD //
///////////////////////////////////////////////
if (room == rm_overworld){
	
	var _margin = 10;
	var _card_width = 32;
	var _card_height = 32;
	var _spacing = 3;

	 // Draw the card sprite
	for (var _i = 0; _i < ds_list_size(global.card_inventory); _i++) {
	    var _ref_card = ds_list_find_value(global.card_inventory, _i);
	    var _sprite = ds_map_find_value(_ref_card, "sprite");
    
	   
	    var _x_pos = _margin + (_i * (_card_width + _spacing));
	    var _y_pos = _margin;
	    draw_sprite_ext(_sprite, 0, _x_pos, _y_pos, 0.1, 0.1, 0, c_white, 1);
	}

	// Draw the total card count
	draw_text(1800,30,"Cards: " + string(ds_list_size(global.card_inventory)));

}