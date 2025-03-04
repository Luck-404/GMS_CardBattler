//////////////////////////////////////////////////////////////////////
//						SCR_RANDOMIZE_DECK							//
//																	//
// > ON ENTRY INTO THE ENCOUTER, RANDOMIZE THE PLAYER'S DECK.		//
//////////////////////////////////////////////////////////////////////
function scr_randomize_deck(){
var _tmp_deck = ds_list_create();

	//randomize them into temp
	for (var _i = 0; _i < ds_list_size(global.player_deck); _i++){
		// Randomly select a card from the deck
		var _index = irandom(ds_list_size(global.player_deck) - 1);
		var _ref_card = ds_list_find_value(global.player_deck, _index);
			// Add card to the tmp deck
		ds_list_add(_tmp_deck, _ref_card);
			// Remove card from the deck
		ds_list_delete(global.player_deck, _index);
	}
	
	//randomize them back into deck
	for (var _i = 0; _i < ds_list_size(_tmp_deck); _i++){
		// Randomly select a card from the tmp deck
		var _index = irandom(ds_list_size(_tmp_deck) - 1);
		var _ref_card = ds_list_find_value(_tmp_deck, _index);
			// Add card to deck
		ds_list_add(global.player_hand, _ref_card);
			// Remove card from tmp deck
		ds_list_delete(_tmp_deck, _index);
	}	
}