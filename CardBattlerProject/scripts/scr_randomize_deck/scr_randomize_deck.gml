//////////////////////////////////////////////////////////////////////
//						SCR_RANDOMIZE_DECK							//
//																	//
// > ON ENTRY INTO THE ENCOUTER POPULATE AN ENCOUNTER DECK WITH		//
//   CARD OBJECTS FOR THE PLAYER.									//
//////////////////////////////////////////////////////////////////////
function scr_randomize_deck(){
var _tmp_deck = ds_list_create();
	
	for (var _i = 0; _i < ds_list_size(global.player_deck); _i++){
		var _ref_card = ds_list_find_value(global.player_deck, _i);
		// Add card to the tmp deck
		ds_list_add(_tmp_deck, _ref_card);
	}
	
	//randomize the tmp deck into the player encounter deck
	while (ds_list_size(_tmp_deck) > 0){
		// Randomly select a card from the tmp deck
		var _index = irandom(ds_list_size(_tmp_deck) - 1);
		var _ref_card = ds_list_find_value(_tmp_deck, _index);
	
		//new card object
		var _new_card_object = instance_create_layer(86,952,"GUI",obj_card);
		_new_card_object._list = "deck";
		//implement all data needed
            _new_card_object._card_name = _ref_card[? "name"];
            _new_card_object._card_desc = _ref_card[? "description"];
            _new_card_object._card_cost = _ref_card[? "cost"];
            _new_card_object._card_script = _ref_card[? "script"];
            _new_card_object._card_sprite = _ref_card[? "sprite"];
			_new_card_object.sprite_index = _ref_card[? "sprite"];
			_new_card_object.image_index = 2;
			_new_card_object.image_speed = 0;
			_new_card_object._card_color = _ref_card[? "color"];
			_new_card_object._card_type = _ref_card[? "type"];
			_new_card_object._card_spec_req = _ref_card[? "spec"];
			_new_card_object._card_class_req = _ref_card[? "class"];
			_new_card_object._card_range = _ref_card[? "range"];
			_new_card_object._card_ref = _ref_card;
			_new_card_object._card_target_count = _ref_card[? "targets"];
			
			
			if(_ref_card[?"range"] == "Targetless"){
				_new_card_object._flag_targetless = true;			
			}
		// Add card obj to deck
		ds_list_add(global.player_encounter_deck, _new_card_object);
		// Remove card ref from tmp deck		
		ds_list_delete(_tmp_deck, _index);			
	}	


}