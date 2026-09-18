//===============================================================================//
//
// SCRIPT: SCR_BATTLE_DRAW_CARDS
// FUNCTION: Draws a requested number of Cards from the player's battle deck.
//           Draws from the top of the shuffled Deck.
//           Refills and reshuffles from Discard when the Deck becomes empty.
//           Calculates final Hand layout, animates draws, and logs them.
//
// INPUT:    _ct_amount - Number of Cards requested from the battle deck.
// USES:     Player battle Deck, Hand, and Discard lists along with shared
//           hand-repositioning, discard-gathering, and Card movement systems.
//
//===============================================================================//

function scr_battle_draw_cards(_ct_amount){

	#region VALIDATION

	//----------------//
	//VALIDATE AMOUNT//
	//----------------//
	if (_ct_amount <= 0){
		return 0;
	}

	#endregion

	#region DRAW SETUP

	//--------------//
	//DRAW SETTINGS//
	//--------------//
	var _ct_draw_duration = 8;
	var _ct_draw_stagger = 2;

	//-----------------//
	//BATTLE CARD LISTS//
	//-----------------//
	var _list_deck = obj_battle_player_controller._list_battle_deck;
	var _list_hand = obj_battle_player_controller._list_battle_hand;
	var _list_discard = obj_battle_player_controller._list_battle_discard;

	//----------------//
	//TRACK NEW CARDS//
	//----------------//
	var _arr_drawn_cards = [];
	var _ct_drawn = 0;

	#endregion

	#region DRAW CARDS

	//==========//
	//DRAW CARDS//
	//==========//
	while (_ct_drawn < _ct_amount){

		//-------------//
		//REFILL DECK//
		//-------------//
		if (ds_list_size(_list_deck) <= 0){

			if (ds_list_size(_list_discard) > 0){
				scr_battle_gather_discards();
			}
			else{
				break;
			}
		}

		//---------------//
		//DRAW TOP CARD//
		//---------------//
		var _it_card = 0;
		var _ref_card = ds_list_find_value(_list_deck,_it_card);

		if (!instance_exists(_ref_card)){
			ds_list_delete(_list_deck,_it_card);
			continue;
		}

		//-------------//
		//MOVE TO HAND//
		//-------------//
		ds_list_delete(_list_deck,_it_card);
		ds_list_add(_list_hand,_ref_card);

		_ref_card._str_location = "HAND";

		//-----------//
		//TRACK DRAW//
		//-----------//
		array_push(_arr_drawn_cards,_ref_card);

		_ct_drawn++;
	}

	#endregion

	#region DRAW PRESENTATION

	//--------------------//
	//CALCULATE FINAL HAND//
	//--------------------//
	scr_battle_reposition_hand();

	//---------------------//
	//START DRAW ANIMATIONS//
	//---------------------//
	for (var _it_draw = 0; _it_draw < array_length(_arr_drawn_cards); _it_draw++){

		var _ref_drawn_card = _arr_drawn_cards[_it_draw];

		if (!instance_exists(_ref_drawn_card)){
			continue;
		}

		//----------------//
		//START MOVEMENT//
		//----------------//
		scr_battle_move_card_between_piles(
			_ref_drawn_card,
			"DECK",
			"HAND",
			_ct_draw_duration,
			_it_draw * _ct_draw_stagger
		);
	}

	#endregion

	#region DEBUG

	//----------------//
	//LOG CARDS DRAWN//
	//----------------//
	if (_ct_drawn > 0){

		var _str_drawn_cards = "";

		for (var _it_draw = 0; _it_draw < array_length(_arr_drawn_cards); _it_draw++){

			var _ref_drawn_card = _arr_drawn_cards[_it_draw];

			if (!instance_exists(_ref_drawn_card) || !is_struct(_ref_drawn_card._ref_card)){
				continue;
			}

			if (_str_drawn_cards != ""){
				_str_drawn_cards += ", ";
			}

			_str_drawn_cards += string_upper(_ref_drawn_card._ref_card._str_card_name);
		}

		scr_debug_log(
			"CARDS",
			"DRAW",
			undefined,
			"PLAYER DREW " + string(_ct_drawn) +
			(_ct_drawn == 1 ? " CARD" : " CARDS") +
			" | CARDS: " + _str_drawn_cards +
			" | HAND: " + string(ds_list_size(_list_hand)) +
			" | DECK: " + string(ds_list_size(_list_deck)),
			"BATTLE",
			"SCR_BATTLE_DRAW_CARDS"
		);
	}

	#endregion

	return _ct_drawn;
}