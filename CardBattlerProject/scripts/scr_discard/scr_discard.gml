// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_discard(_card){
	//remove from player hand
	ds_list_delete(global.player_hand, ds_list_find_index(global.player_hand,_card));
	//add to discard pile
	ds_list_add(global.player_discard_pile,_card);
	_card._list = "discard";
	_card.x = 1400;
	_card.y = 1000;
	
	with(obj_card){
		obj_card._active = false;
		obj_card._selected = false;
	}

	with(obj_creature){
		obj_creature._selected_target = false;
		obj_card._selected_channel = false;
	}
	
	//reset player's selected and such
	if(obj_player._card_selected != undefined){
		obj_player._card_selected._selected = false;
	}
	obj_player._card_selected = undefined;	
	if(obj_player._channel_selected != undefined){	
		obj_player._channel_selected._selected_channel = false;
	}
	obj_player._channel_selected = undefined;
	if(obj_player._target_selected != undefined){		
		obj_player._target_selected._selected_target = false;
	}
	obj_player._target_selected = undefined;
}