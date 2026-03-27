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
	
		//new card obj
		var _new_card_object = scr_create_card_object("deck",_ref_card);
		
		// Add card obj to deck
		ds_list_add(global.player_encounter_deck, _new_card_object);
		// Remove card ref from tmp deck		
		ds_list_delete(_tmp_deck, _index);			
	}	


}