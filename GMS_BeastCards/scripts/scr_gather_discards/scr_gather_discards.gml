//===============================================================================//
//
// SCR_GATHER_DISCARDS
// FUNCTION: Moves all cards from the discard pile back into the battle deck.
//           Resets their locations and shuffles the refreshed deck.
//
//===============================================================================//
function scr_gather_discards(){

	var _list_deck = obj_battle_player_controller._list_battle_deck;
	var _list_discard = obj_battle_player_controller._list_battle_discard;

	audio_play_sound(snd_card_shuffle,0,false);

	while (ds_list_size(_list_discard) > 0){

		var _ref_card = ds_list_find_value(_list_discard,0);

		ds_list_delete(_list_discard,0);
		ds_list_add(_list_deck,_ref_card);

		_ref_card.x = 70;
		_ref_card.y = room_height - 100;

		_ref_card._str_location = "DECK";
	}

	ds_list_shuffle(_list_deck);
}