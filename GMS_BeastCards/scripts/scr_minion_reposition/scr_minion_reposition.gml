//===============================================================================//
//
// SCRIPT: SCR_MINION_REPOSITION
// FUNCTION: Repositions all Minions relative to their host Beast.
//           Mirrors Minion ordering for player-side Beasts.
//           Uses preset layouts for 1-6 Minions and a grid fallback for 7+.
//
// INPUT:    _ref_host - Battle Beast whose Minions should be repositioned.
//
//===============================================================================//

function scr_minion_reposition(_ref_host){

	//---------------//
	//VALIDATE HOST//
	//---------------//
	if (!instance_exists(_ref_host)){
		return;
	}

	//--------------------//
	//VALIDATE MINION LIST//
	//--------------------//
	if (!ds_exists(_ref_host._list_minions,ds_type_list)){
		return;
	}

	var _list_minions = _ref_host._list_minions;

	//-----------------------//
	//REMOVE INVALID MINIONS//
	//-----------------------//
	for (var _it_minion = ds_list_size(_list_minions) - 1;_it_minion >= 0;_it_minion--){

		var _ref_minion = ds_list_find_value(
			_list_minions,
			_it_minion
		);

		if (!instance_exists(_ref_minion)){
			ds_list_delete(_list_minions,_it_minion);
		}
	}

	//----------------//
	//GET MINION COUNT//
	//----------------//
	var _ct_minions = ds_list_size(_list_minions);

	if (_ct_minions <= 0){
		return;
	}

	//----------------//
	//LAYOUT SETTINGS//
	//----------------//
	var _val_center_x = _ref_host.x;
	var _val_center_y = _ref_host.y + 50;

	var _val_x_spacing = 32;
	var _val_row_gap = 48;

	var _flag_mirror =
		_ref_host._str_team == "PLAYER";

	//================//
	//1 MINION//
	//================//
	if (_ct_minions == 1){

		var _ref_minion = ds_list_find_value(
			_list_minions,
			0
		);

		_ref_minion.x = _val_center_x;
		_ref_minion.y = _val_center_y + _val_row_gap;

		return;
	}

	//================//
	//2 MINIONS//
	//================//
	if (_ct_minions == 2){

		for (var _it_minion = 0;_it_minion < 2;_it_minion++){

			var _it_list_index =
				_flag_mirror
					? (_ct_minions - 1) - _it_minion
					: _it_minion;

			var _ref_minion = ds_list_find_value(
				_list_minions,
				_it_list_index
			);

			_ref_minion.x =
				_val_center_x +
				(-1 + (_it_minion * 2)) *
				_val_x_spacing;

			_ref_minion.y =
				_val_center_y +
				_val_row_gap;
		}

		return;
	}

	//================//
	//3 MINIONS//
	//================//
	if (_ct_minions == 3){

		for (var _it_minion = 0;_it_minion < 3;_it_minion++){

			var _it_list_index =
				_flag_mirror
					? (_ct_minions - 1) - _it_minion
					: _it_minion;

			var _ref_minion = ds_list_find_value(
				_list_minions,
				_it_list_index
			);

			switch (_it_minion){

				case 0:

					_ref_minion.x = _val_center_x - _val_x_spacing;
					_ref_minion.y = _val_center_y + _val_row_gap;

				break;

				case 1:

					_ref_minion.x = _val_center_x + _val_x_spacing;
					_ref_minion.y = _val_center_y + _val_row_gap;

				break;

				case 2:

					_ref_minion.x = _val_center_x;
					_ref_minion.y = _val_center_y + _val_row_gap + 16;

				break;
			}
		}

		return;
	}

	//================//
	//4 MINIONS//
	//================//
	if (_ct_minions == 4){

		for (var _it_minion = 0;_it_minion < 4;_it_minion++){

			var _val_row = _it_minion div 2;
			var _val_col = _it_minion mod 2;

			var _it_list_index =
				_flag_mirror
					? (_ct_minions - 1) - _it_minion
					: _it_minion;

			var _ref_minion = ds_list_find_value(
				_list_minions,
				_it_list_index
			);

			_ref_minion.x =
				_val_center_x +
				((_val_col * 2) - 1) *
				_val_x_spacing;

			_ref_minion.y =
				_val_center_y +
				(_val_row * _val_row_gap) +
				32;
		}

		return;
	}

	//================//
	//5 MINIONS//
	//================//
	if (_ct_minions == 5){

		//-----------//
		//FIRST ROW//
		//-----------//
		for (var _it_minion = 0;_it_minion < 3;_it_minion++){

			var _it_list_index =
				_flag_mirror
					? (_ct_minions - 1) - _it_minion
					: _it_minion;

			var _ref_minion = ds_list_find_value(
				_list_minions,
				_it_list_index
			);

			_ref_minion.x =
				_val_center_x +
				(_it_minion - 1) *
				_val_x_spacing;

			_ref_minion.y =
				_val_center_y +
				_val_row_gap;
		}

		//------------//
		//SECOND ROW//
		//------------//
		for (var _it_minion = 0;_it_minion < 2;_it_minion++){

			var _it_position = 3 + _it_minion;

			var _it_list_index =
				_flag_mirror
					? (_ct_minions - 1) - _it_position
					: _it_position;

			var _ref_minion = ds_list_find_value(
				_list_minions,
				_it_list_index
			);

			_ref_minion.x =
				_val_center_x +
				(-0.5 + _it_minion) *
				(_val_x_spacing * 2);

			_ref_minion.y =
				_val_center_y +
				(_val_row_gap * 2);
		}

		return;
	}

	//================//
	//6 MINIONS//
	//================//
	if (_ct_minions == 6){

		for (var _it_minion = 0;_it_minion < 6;_it_minion++){

			var _val_row = _it_minion div 3;
			var _val_col = _it_minion mod 3;

			var _it_list_index =
				_flag_mirror
					? (_ct_minions - 1) - _it_minion
					: _it_minion;

			var _ref_minion = ds_list_find_value(
				_list_minions,
				_it_list_index
			);

			_ref_minion.x =
				_val_center_x +
				(_val_col - 1) *
				_val_x_spacing;

			_ref_minion.y =
				_val_center_y +
				(_val_row * _val_row_gap) +
				32;
		}

		return;
	}

	//================//
	//7+ MINIONS//
	//================//
	var _ct_cols = 4;

	for (var _it_minion = 0;_it_minion < _ct_minions;_it_minion++){

		var _val_row = _it_minion div _ct_cols;
		var _val_col = _it_minion mod _ct_cols;

		var _it_list_index =
			_flag_mirror
				? (_ct_minions - 1) - _it_minion
				: _it_minion;

		var _ref_minion = ds_list_find_value(
			_list_minions,
			_it_list_index
		);

		_ref_minion.x =
			_val_center_x +
			(
				_val_col -
				((_ct_cols - 1) * 0.5)
			) *
			_val_x_spacing;

		_ref_minion.y =
			_val_center_y +
			(_val_row * _val_row_gap) +
			32;
	}
}