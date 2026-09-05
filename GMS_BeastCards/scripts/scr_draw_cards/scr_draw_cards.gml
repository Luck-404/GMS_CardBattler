//===============================================================================//
//
// SCRIPT: SCR_DRAW_CARDS
// FUNCTION: Draws cards from the player's battle deck into the hand.
//           Refills the deck from discard when needed.
//           Repositions the hand before animating newly drawn cards.
//           Moves each drawn card from the deck to its final hand position.
//
//===============================================================================//

function scr_draw_cards(_ct_amount){

	//----------------//
	//VALIDATE AMOUNT//
	//----------------//
	if (_ct_amount <= 0){
		return 0;
	}

	//--------------//
	//DRAW SETTINGS//
	//--------------//
	var _val_deck_x =
		70;

	var _val_deck_y =
		room_height - 100;

	var _ct_draw_duration =
		8;

	var _ct_draw_stagger =
		2;

	//----------------//
	//TRACK NEW CARDS//
	//----------------//
	var _arr_drawn_cards = [];

	var _ct_drawn = 0;

	//==========//
	//DRAW CARDS//
	//==========//
	while (_ct_drawn < _ct_amount){

		//-------------//
		//REFILL DECK//
		//-------------//
		if (
			ds_list_size(
				obj_battle_player_controller
					._list_battle_deck
			) <= 0
		){

			if (
				ds_list_size(
					obj_battle_player_controller
						._list_battle_discard
				) > 0
			){

				scr_gather_discards();
			}
			else{

				break;
			}
		}

		//--------//
		//GET DECK//
		//--------//
		var _list_deck =
			obj_battle_player_controller
				._list_battle_deck;

		//------------------//
		//SELECT RANDOM CARD//
		//------------------//
		var _it_card =
			irandom(
				ds_list_size(_list_deck) - 1
			);

		var _ref_card =
			ds_list_find_value(
				_list_deck,
				_it_card
			);

		if (!instance_exists(_ref_card)){

			ds_list_delete(
				_list_deck,
				_it_card
			);

			continue;
		}

		//-------------//
		//MOVE TO HAND//
		//-------------//
		ds_list_add(
			obj_battle_player_controller
				._list_battle_hand,
			_ref_card
		);

		ds_list_delete(
			_list_deck,
			_it_card
		);

		_ref_card._str_location =
			"HAND";

		//-----------//
		//TRACK DRAW//
		//-----------//
		array_push(
			_arr_drawn_cards,
			_ref_card
		);

		_ct_drawn++;
	}

	//======================//
	//CALCULATE FINAL HAND//
	//======================//
	scr_reposition_cards();

	//=======================//
	//START DRAW ANIMATIONS//
	//=======================//
	for (
		var _it_draw = 0;
		_it_draw < array_length(_arr_drawn_cards);
		_it_draw++
	){

		var _ref_drawn_card =
			_arr_drawn_cards[_it_draw];

		if (!instance_exists(_ref_drawn_card)){
			continue;
		}

		//------------------//
		//STORE DESTINATION//
		//------------------//
		var _val_end_x =
			_ref_drawn_card.x;

		var _val_end_y =
			_ref_drawn_card.y;

		//----------------//
		//START MOVEMENT//
		//----------------//
		scr_start_card_move_animation(
			_ref_drawn_card,
			"DRAW",
			_val_deck_x,
			_val_deck_y,
			_val_end_x,
			_val_end_y,
			_ct_draw_duration,
			_it_draw * _ct_draw_stagger
		);
	}

	return _ct_drawn;
}