//===============================================================================//
//
// SCR_REPOSITION_MINIONS
// FUNCTION: Repositions all minions relative to their host beast.
//           Supports mirrored ordering for player-side beasts.
//           Uses preset layouts for 1-6 minions and grid fallback for 7+.
//
//===============================================================================//
function scr_reposition_minions(_ref_host){

	var _list_minions = _ref_host._list_minions;
	var _ct_minions = ds_list_size(_list_minions);

	if (_ct_minions <= 0){
		exit;
	}

	var _val_center_x = _ref_host.x;
	var _val_center_y = _ref_host.y + 50;

	var _val_x_spacing = 32;
	var _val_row_gap = 48;

	function get_idx(_it_minion,_ref_host_check,_ct_minion_check){

		if (_ref_host_check._str_team == "PLAYER"){
			return (_ct_minion_check - 1) - _it_minion;
		}

		return _it_minion;
	}

	if (_ct_minions == 1){

		var _ref_minion = ds_list_find_value(_list_minions,get_idx(0,_ref_host,_ct_minions));

		_ref_minion.x = _val_center_x;
		_ref_minion.y = _val_center_y + _val_row_gap;

		exit;
	}

	if (_ct_minions == 2){

		for (var _it_minion = 0; _it_minion < 2; _it_minion++){

			var _ref_minion = ds_list_find_value(_list_minions,get_idx(_it_minion,_ref_host,_ct_minions));

			_ref_minion.x = _val_center_x + (-1 + (_it_minion * 2)) * _val_x_spacing;
			_ref_minion.y = _val_center_y + _val_row_gap;
		}

		exit;
	}

	if (_ct_minions == 3){

		var _ref_minion = ds_list_find_value(_list_minions,get_idx(0,_ref_host,_ct_minions));
		_ref_minion.x = _val_center_x - _val_x_spacing;
		_ref_minion.y = _val_center_y + _val_row_gap;

		_ref_minion = ds_list_find_value(_list_minions,get_idx(1,_ref_host,_ct_minions));
		_ref_minion.x = _val_center_x + _val_x_spacing;
		_ref_minion.y = _val_center_y + _val_row_gap;

		_ref_minion = ds_list_find_value(_list_minions,get_idx(2,_ref_host,_ct_minions));
		_ref_minion.x = _val_center_x;
		_ref_minion.y = _val_center_y + _val_row_gap + 16;

		exit;
	}

	if (_ct_minions == 4){

		for (var _it_minion = 0; _it_minion < 4; _it_minion++){

			var _val_row = _it_minion div 2;
			var _val_col = _it_minion mod 2;

			var _ref_minion = ds_list_find_value(_list_minions,get_idx(_it_minion,_ref_host,_ct_minions));

			_ref_minion.x = _val_center_x + ((_val_col * 2) - 1) * _val_x_spacing;
			_ref_minion.y = _val_center_y + (_val_row * _val_row_gap) + 32;
		}

		exit;
	}

	if (_ct_minions == 5){

		for (var _it_minion = 0; _it_minion < 3; _it_minion++){

			var _ref_minion = ds_list_find_value(_list_minions,get_idx(_it_minion,_ref_host,_ct_minions));

			_ref_minion.x = _val_center_x + (_it_minion - 1) * _val_x_spacing;
			_ref_minion.y = _val_center_y + _val_row_gap;
		}

		for (var _it_minion = 0; _it_minion < 2; _it_minion++){

			var _ref_minion = ds_list_find_value(_list_minions,get_idx(3 + _it_minion,_ref_host,_ct_minions));

			_ref_minion.x = _val_center_x + (-0.5 + _it_minion) * (_val_x_spacing * 2);
			_ref_minion.y = _val_center_y + (_val_row_gap * 2);
		}

		exit;
	}

	if (_ct_minions == 6){

		for (var _it_minion = 0; _it_minion < 6; _it_minion++){

			var _val_row = _it_minion div 3;
			var _val_col = _it_minion mod 3;

			var _ref_minion = ds_list_find_value(_list_minions,get_idx(_it_minion,_ref_host,_ct_minions));

			_ref_minion.x = _val_center_x + (_val_col - 1) * _val_x_spacing;
			_ref_minion.y = _val_center_y + (_val_row * _val_row_gap) + 32;
		}

		exit;
	}

	var _ct_cols = 4;

	for (var _it_minion = 0; _it_minion < _ct_minions; _it_minion++){

		var _val_row = _it_minion div _ct_cols;
		var _val_col = _it_minion mod _ct_cols;

		var _ref_minion = ds_list_find_value(_list_minions,get_idx(_it_minion,_ref_host,_ct_minions));

		_ref_minion.x = _val_center_x + (_val_col - ((_ct_cols - 1) * 0.5)) * _val_x_spacing;
		_ref_minion.y = _val_center_y + (_val_row * _val_row_gap) + 32;
	}
}