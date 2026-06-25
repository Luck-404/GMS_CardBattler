//===============================================================================//
//
// SCRIPT: scr_add_card_to_deck
// FUNCTION: Adds a card struct to the player deck if there is room.
// Adds the card struct to the player library if the deck is full.
// Returns void.
//
//===============================================================================//

function scr_add_card_to_deck(_stct_new_card){
	if (ds_list_size(global.player_deck) < 30){
		ds_list_add(global.player_deck,_stct_new_card);
	}
	else{
		ds_list_add(global.player_library,_stct_new_card);
	}
}