//////////////////////////////////////////////////////////////////////
//						OBJ_TREASURE STEP							//
//																	//
// > UPON INTERACTION, MAKE A NEW TREASURE IN A RANDOM SPOT			//
//////////////////////////////////////////////////////////////////////
if (instance_exists(obj_player) && global.player_ow_state == PLAYER_OW_STATE.GENERAL && distance_to_object(obj_player) < 64 && keyboard_check_pressed(ord("E"))){
	//roll a card
	var _rarity_roll = irandom_range(1, 100); // Determine rarity
    var _card = undefined;
		
	if (50 < _rarity_roll < 100){ //50% common
		_card = scr_roll_card("common");
	} else if (20 < _rarity_roll < 50){ //30% uncommon
		_card = scr_roll_card("uncommon");
	} else if (10 < _rarity_roll < 20){ //10% rare
		_card = scr_roll_card("rare");
	} else if (3 < _rarity_roll < 10){ //7% epic
		_card = scr_roll_card("epic");
	} else if (1 < _rarity_roll < 3){ //3% legendary
		_card = scr_roll_card("legendary");
	}
			
    ds_list_add(global.card_inventory, _card);
	
	_flag_interacted = true;
}

//if interacted with, make a new treasure and destroy self
if (_flag_interacted) {
    var _new_position = scr_find_valid_tile_in_tilemap();
    if (_new_position != noone) {
        var _new_x = _new_position[0];
        var _new_y = _new_position[1];
        instance_create_layer(_new_x, _new_y, "GUI", obj_lucky_spot); // Replace "Instances" with your desired layer
    }
    instance_destroy(); // Remove the current treasure
}