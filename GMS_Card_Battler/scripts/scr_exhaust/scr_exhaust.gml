//////////////////////////////////////////////////////////////////////
//							SCR_EXHAUST								//
//																	//
// > TAKE CARD IN THE PLAYER'S HAND AND THROW THEM INTO EXHAUST		//
//////////////////////////////////////////////////////////////////////
function scr_exhaust(_card){
	//remove from player hand
	ds_list_delete(global.player_hand, ds_list_find_index(global.player_hand,_card));
	//add to discard pile
	ds_list_add(global.player_exhaust_pile,_card);
	_card._list = "exhaust";
	_card.x = 1832;
	scr_reset_playstate();
}