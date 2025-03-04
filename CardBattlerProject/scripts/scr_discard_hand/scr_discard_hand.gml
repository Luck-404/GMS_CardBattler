//////////////////////////////////////////////////////////////////////
//						SCR_DISCARD_HAND							//
//																	//
// > TAKE ALL CARDS IN THE PLAYER'S HAND AND THROW THEM INTO		//
//   DISCARD														//
//////////////////////////////////////////////////////////////////////
function scr_discard_hand(){
    // put your hand into the discard pile		
    if (global.player_hand != -1 && ds_list_size(global.player_hand) > 0) {			
        for (var _i = 0; _i < ds_list_size(global.player_hand); _i++) {
            var _ref_card = ds_list_find_value(global.player_hand, _i);
			// Return the card to the deck
            ds_list_add(global.player_discard_pile, _ref_card);		
        }
		// Clear the current hand
        ds_list_clear(global.player_hand);  		
    }	
	
	//delete all card objects
	with(obj_card){
		instance_destroy(obj_card);	
	}
}