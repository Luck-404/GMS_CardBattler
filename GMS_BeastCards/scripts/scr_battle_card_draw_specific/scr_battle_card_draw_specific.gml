//===============================================================================//
//
// SCRIPT: scr_battle_card_draw_specific
// FUNCTION: Draws one specified battle-card instance from the draw pile.
//           Moves that exact card from DECK to HAND and refreshes hand layout.
//
//===============================================================================//

function scr_battle_card_draw_specific(_ref_card){

	if (!instance_exists(_ref_card)){
		return false;
	}

	var _list_deck =
		obj_battle_player_controller._list_battle_deck;

	var _list_hand =
		obj_battle_player_controller._list_battle_hand;

	var _it_card =
		ds_list_find_index(_list_deck,_ref_card);

	if (_it_card == -1){
		return false;
	}

	if (_ref_card._str_location != "DECK"){
		return false;
	}

	//-----------------//
	//REMOVE FROM DECK//
	//-----------------//
	ds_list_delete(_list_deck,_it_card);

	//-------------//
	//ADD TO HAND//
	//-------------//
	ds_list_add(_list_hand,_ref_card);

	_ref_card._str_location =
		"HAND";

	//----------------//
	//REFRESH HAND GUI//
	//----------------//
	scr_battle_card_reposition();

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_card_draw,0,false);

	return true;
}