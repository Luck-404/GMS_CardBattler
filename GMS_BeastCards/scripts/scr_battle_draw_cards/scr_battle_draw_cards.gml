
//===============================================================================//
//
// SCRIPT: SCR_BATTLE_DRAW_CARDS
// FUNCTION: Draws a requested number of Cards from the player's battle deck.
//           Draws from the top of the shuffled Deck.
//           Refills and reshuffles from Discard when the Deck becomes empty.
//           DRAW_2 adds 2 cards and spends one charge per successful draw event.
//           Calculates final Hand layout, animates draws, and logs them.
//
// INPUT:    _ct_amount - Number of Cards requested from the battle deck.
// RETURNS:  Number of Cards actually drawn.
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

	//====================//
	//CHECK DRAW 2 BONUS//
	//====================//
	var _ref_draw_2 = -1;
	var _ct_draw_2_bonus = 0;

	if (
		variable_global_exists("list_statuses") &&
		ds_exists(global.list_statuses,ds_type_list)
	){

		_ref_draw_2 = scr_status_check(
			"DRAW_2",
			global.list_statuses
		);

		if (
			_ref_draw_2 != -1 &&
			instance_exists(_ref_draw_2)
		){

			if (_ref_draw_2._ct_status_stacks > 0){

				_ct_draw_2_bonus = _ref_draw_2._val_status_magnitude;

				_ct_amount += _ct_draw_2_bonus;
			}
		}
	}

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

	#region DRAW 2 CHARGE

	//================//
	//CONSUME ONE CHARGE//
	//================//
	// One function call is one draw event, even when multiple
	// cards are drawn. Empty draw attempts spend no charges.
	if (
		_ct_drawn > 0 &&
		_ct_draw_2_bonus > 0 &&
		instance_exists(_ref_draw_2)
	){

		scr_status_buff_draw_2(
			"CONSUME",
			_ref_draw_2
		);
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