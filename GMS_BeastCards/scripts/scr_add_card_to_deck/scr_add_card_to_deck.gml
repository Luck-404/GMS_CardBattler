//
//
// SCRIPT: SCR_ADD_CARD_TO_DECK | ADDS CARD TO DECK IF THERE IS ROOM, OTHERWISE ADDS TO library | RETURNS VOID
//
//
function scr_add_card_to_deck(_new_card){
	//ATTEMPT TO ADD TO DECK
	if (ds_list_size(global.player_deck) < 30){
		ds_list_add(global.player_deck,_new_card);
	}

	//ADD TO library
	else {
		ds_list_add(global.player_library,_new_card);	
	}
}