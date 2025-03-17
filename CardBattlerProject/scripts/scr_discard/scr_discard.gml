//////////////////////////////////////////////////////////////////////
//							SCR_DISCARD								//
//																	//
// > TAKE CARDS IN THE PLAYER'S HAND AND THROW THEM INTO DISCARD	//
//////////////////////////////////////////////////////////////////////
function scr_discard(_card){
	//remove from player hand
	ds_list_delete(global.player_hand, ds_list_find_index(global.player_hand,_card));
	//add to discard pile
	ds_list_add(global.player_discard_pile,_card);
	_card._list = "discard";
	_card.x = 1663;
	
	scr_reset_playstate();
}