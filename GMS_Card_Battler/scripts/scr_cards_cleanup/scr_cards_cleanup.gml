//////////////////////////////////////////////////////////////////////
//						SCR_CARDS_CLEANUP							//
//																	//
// > AT THE END OF AN ENCOUNTER, CLEANLY PUT THE CARDS FROM THE		//
//   HAND, DISCARD, AND EXHAUST BACK INTO THE PLAYER'S DECK.		//
//////////////////////////////////////////////////////////////////////
function scr_cards_cleanup(){
	scr_reset_playstate();
	
	//delete all cards
	with(obj_card){
		instance_destroy(obj_card);	
	}
	
	with(obj_enemy_card){
		instance_destroy(obj_enemy_card);	
	}	

	//clear lists
	ds_list_clear(global.player_encounter_deck);
	ds_list_clear(global.player_discard_pile);
	ds_list_clear(global.player_exhaust_pile);
	ds_list_clear(global.player_hand);	
	
	ds_list_clear(global.player_party_in_play);	
	ds_list_clear(global.player_party_dead);	
}