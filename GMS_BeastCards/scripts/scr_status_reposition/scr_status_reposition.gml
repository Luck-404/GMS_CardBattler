//===============================================================================//
//
// SCRIPT: SCR_STATUS_REPOSITION
// FUNCTION: Repositions Status icons.
//           Removes stale Status references before calculating layout.
//           Supports Global Statuses at the top of the screen.
//           Supports host-bound Statuses above battle Beasts.
//
// ARGUMENTS: _ref_host is the owning Beast, global.list_statuses for Global
//            Statuses, or undefined to reposition the Global Status list.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_status_reposition(_ref_host){

	//===================//
	//GLOBAL STATUSES//
	//===================//
	if (_ref_host == undefined || _ref_host == global.list_statuses){

		var _list_statuses = global.list_statuses;

		if (!ds_exists(_list_statuses,ds_type_list)){
			return;
		}

		//====================//
		//PURGE INVALID REFS//
		//====================//
		scr_status_prune_list(_list_statuses);

		var _ct_statuses = ds_list_size(_list_statuses);

		if (_ct_statuses <= 0){
			return;
		}

		var _val_center_x = room_width * 0.5;
		var _val_center_y = 50;

		var _ct_cols = 6;
		var _val_x_spacing = 24;
		var _val_y_spacing = 24;

		//-------------------//
		//POSITION STATUSES//
		//-------------------//
		for (var _it_status = 0;_it_status < _ct_statuses;_it_status++){

			var _val_row = _it_status div _ct_cols;
			var _val_col = _it_status mod _ct_cols;

			var _ct_row = min(
				_ct_cols,
				_ct_statuses - (_val_row * _ct_cols)
			);

			var _val_start_x =
				_val_center_x -
				((_ct_row - 1) * _val_x_spacing * 0.5);

			var _ref_status = ds_list_find_value(
				_list_statuses,
				_it_status
			);

			if (!instance_exists(_ref_status)){
				continue;
			}

			_ref_status.x = _val_start_x + (_val_col * _val_x_spacing);
			_ref_status.y = _val_center_y + (_val_row * _val_y_spacing);
		}

		return;
	}

	//======================//
	//HOST-BOUND STATUSES//
	//======================//
	if (!instance_exists(_ref_host)){
		return;
	}

	var _list_statuses = _ref_host._list_statuses;

	if (!ds_exists(_list_statuses,ds_type_list)){
		return;
	}

	//====================//
	//PURGE INVALID REFS//
	//====================//
	scr_status_prune_list(_list_statuses);

	var _ct_statuses = ds_list_size(_list_statuses);

	if (_ct_statuses <= 0){
		return;
	}

	//----------------//
	//DEAD HOST//
	//----------------//
	if (_ref_host._val_cur_hp <= 0){
		return;
	}

	var _val_center_x = _ref_host.x;
	var _val_center_y = _ref_host.y - 100;

	var _ct_cols = 4;
	var _val_x_spacing = 24;
	var _val_y_spacing = 24;

	var _ct_rows = ceil(_ct_statuses / _ct_cols);

	//-------------------//
	//POSITION STATUSES//
	//-------------------//
	for (var _it_status = 0;_it_status < _ct_statuses;_it_status++){

		var _val_row = _it_status div _ct_cols;
		var _val_col = _it_status mod _ct_cols;

		var _ct_row = min(
			_ct_cols,
			_ct_statuses - (_val_row * _ct_cols)
		);

		var _val_start_x =
			_val_center_x -
			((_ct_row - 1) * _val_x_spacing * 0.5);

		var _ref_status = ds_list_find_value(
			_list_statuses,
			_it_status
		);

		if (!instance_exists(_ref_status)){
			continue;
		}

		_ref_status.x = _val_start_x + (_val_col * _val_x_spacing);
		_ref_status.y =
			_val_center_y -
			((_ct_rows - 1 - _val_row) * _val_y_spacing);
	}
}