// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exhaust(_card){
	//remove from player hand
	ds_list_delete(global.player_hand, ds_list_find_index(global.player_hand,_card));
	//add to discard pile
	ds_list_add(global.player_exhaust_pile,_card);

	//reset player's selected and such
	obj_player._channel_selected._selected = false;
	obj_player._channel_selected = undefined;
	obj_player._target_selected._selected = false;
	obj_player._target_selected = undefined;

	//destroy the card object
	instance_destroy(obj_player._card_selected);
	obj_player._card_selected = undefined;
}