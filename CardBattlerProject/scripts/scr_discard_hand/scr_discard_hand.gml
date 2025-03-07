//////////////////////////////////////////////////////////////////////
//						SCR_DISCARD_HAND							//
//																	//
// > TAKE ALL CARDS IN THE PLAYER'S HAND AND THROW THEM INTO		//
//   DISCARD														//
//////////////////////////////////////////////////////////////////////
function scr_discard_hand(){
    // put your hand into the discard pile		
    while(ds_list_size(global.player_hand) > 0) {			
	    var _ref_card = ds_list_find_value(global.player_hand, 0);
		scr_discard(_ref_card);	
    }	
}