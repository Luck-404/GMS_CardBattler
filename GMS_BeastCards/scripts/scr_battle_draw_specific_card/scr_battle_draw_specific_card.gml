//===============================================================================//
//
// SCRIPT: SCR_BATTLE_DRAW_SPECIFIC_CARD
// FUNCTION: Draws one specified battle Card instance from the player's draw pile.
//           Moves that exact Card from Deck to Hand and refreshes hand layout.
//
// INPUT:    _ref_card - Specific battle Card instance requested from the Deck.
// USES:     Player battle Deck and Hand lists and the shared hand-repositioning
//           system.
//
//===============================================================================//

function scr_battle_draw_specific_card(_ref_card){

	#region VALIDATION

	//---------------//
	//VALIDATE CARD//
	//---------------//
	if (!instance_exists(_ref_card)){
		return false;
	}

	//---------//
	//GET LISTS//
	//---------//
	var _list_deck = obj_battle_player_controller._list_battle_deck;
	var _list_hand = obj_battle_player_controller._list_battle_hand;

	//----------------//
	//FIND DECK CARD//
	//----------------//
	var _it_card = ds_list_find_index(_list_deck,_ref_card);

	if (_it_card == -1){
		return false;
	}

	if (_ref_card._str_location != "DECK"){
		return false;
	}

	#endregion

	#region DRAW CARD

	//-----------------//
	//REMOVE FROM DECK//
	//-----------------//
	ds_list_delete(_list_deck,_it_card);

	//-------------//
	//ADD TO HAND//
	//-------------//
	ds_list_add(_list_hand,_ref_card);

	_ref_card._str_location = "HAND";

	//----------------//
	//REFRESH HAND GUI//
	//----------------//
	scr_battle_reposition_hand();

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_card_draw,0,false);

	#endregion

	return true;
}