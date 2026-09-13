//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GATHER_DISCARDS
// FUNCTION: Moves all Cards from the player's Discard pile back into the Deck.
//           Resets their battle locations and positions, shuffles the Deck,
//           and logs the completed discard reshuffle.
//
// USES:     Player battle Deck and Discard lists and the battle Deck position.
//           Plays the shared Card shuffle sound when gathering begins.
//
//===============================================================================//

function scr_battle_gather_discards(){

	#region CARD LISTS

	//---------//
	//GET LISTS//
	//---------//
	var _list_deck = obj_battle_player_controller._list_battle_deck;
	var _list_discard = obj_battle_player_controller._list_battle_discard;

	var _ct_cards_gathered = ds_list_size(_list_discard);

	#endregion

	#region GATHER DISCARDS

	//----------------//
	//PLAY SHUFFLE SFX//
	//----------------//
	audio_play_sound(snd_battle_card_shuffle,0,false);

	//--------------------//
	//RETURN CARDS TO DECK//
	//--------------------//
	while (ds_list_size(_list_discard) > 0){

		var _ref_card = ds_list_find_value(_list_discard,0);

		ds_list_delete(_list_discard,0);
		ds_list_add(_list_deck,_ref_card);

		_ref_card.x = 70;
		_ref_card.y = room_height - 100;

		_ref_card._str_location = "DECK";
	}

	//--------------//
	//SHUFFLE DECK//
	//--------------//
	ds_list_shuffle(_list_deck);

	#endregion

	#region DEBUG

	//------------------//
	//LOG DECK SHUFFLE//
	//------------------//
	if (_ct_cards_gathered > 0){

		scr_debug_log(
			"CARDS",
			"SHUFFLE",
			undefined,
			"PLAYER SHUFFLED " + string(_ct_cards_gathered) +
			(_ct_cards_gathered == 1 ? " DISCARD" : " DISCARDS") +
			" INTO DECK | DECK: " + string(ds_list_size(_list_deck)) +
			" | DISCARD: " + string(ds_list_size(_list_discard)),
			"BATTLE",
			"SCR_BATTLE_GATHER_DISCARDS"
		);
	}

	#endregion
}