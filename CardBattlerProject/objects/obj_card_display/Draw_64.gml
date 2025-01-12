if (room == rm_overworld){
	
	var margin = 10;
	var card_width = 32;
	var card_height = 32;
	var spacing = 3;

	for (var i = 0; i < ds_list_size(global.card_inventory); i++) {
	    var card = ds_list_find_value(global.card_inventory, i);
	    var sprite = ds_map_find_value(card, "sprite");
    
	    // Draw the card sprite
	    var x_pos = margin + (i * (card_width + spacing));
	    var y_pos = margin;
	    draw_sprite_ext(sprite, 0, x_pos, y_pos, 0.1, 0.1, 0, c_white, 1);
	}

	draw_text(1800,30,"Cards: " + string(ds_list_size(global.card_inventory)));

}