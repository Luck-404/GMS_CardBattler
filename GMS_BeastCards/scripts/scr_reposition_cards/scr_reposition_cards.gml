//===============================================================================//
//
// SCRIPT: SCR_REPOSITION_CARDS
// FUNCTION: Repositions all cards currently in the player's hand.
//           Centers the hand at the bottom of the battle screen.
//           Updates active Draw-animation destinations without teleporting them.
//
//===============================================================================//

function scr_reposition_cards(){

	//-------------//
	//HAND LAYOUT//
	//-------------//
	var _val_base_x = 548;
	var _val_card_spacing = 15;
	var _val_card_width = 120;

	var _val_hand_y =
		room_height - 100;

	//--------//
	//GET HAND//
	//--------//
	var _list_hand =
		obj_battle_player_controller._list_battle_hand;

	var _ct_hand =
		ds_list_size(_list_hand);

	if (_ct_hand <= 0){
		return;
	}

	//----------------//
	//CALCULATE WIDTH//
	//----------------//
	var _val_total_width =
		(_ct_hand * _val_card_width) +
		(
			(_ct_hand - 1) *
			_val_card_spacing
		);

	var _val_start_x =
		_val_base_x -
		(_val_total_width * 0.5) +
		(_val_card_width * 0.5);

	//----------------//
	//POSITION CARDS//
	//----------------//
	for (
		var _it_card = 0;
		_it_card < _ct_hand;
		_it_card++
	){

		var _ref_card =
			ds_list_find_value(
				_list_hand,
				_it_card
			);

		if (!instance_exists(_ref_card)){
			continue;
		}

		var _val_target_x =
			_val_start_x +
			(
				_it_card *
				(
					_val_card_width +
					_val_card_spacing
				)
			);

		var _val_target_y =
			_val_hand_y;

		//----------------------//
		//ACTIVE DRAW DESTINATION//
		//----------------------//
		if (
			_ref_card._flag_card_moving &&
			_ref_card._str_card_move_type == "DRAW"
		){

			_ref_card._val_card_move_end_x =
				_val_target_x;

			_ref_card._val_card_move_end_y =
				_val_target_y;
		}

		//---------------//
		//NORMAL POSITION//
		//---------------//
		else{

			_ref_card.x =
				_val_target_x;

			_ref_card.y =
				_val_target_y;
		}
	}
}