//
// scr_check_status_pos(_host)
// 16x16 status icons
// 6 per row, centered
//
function scr_reposition_statuses(_host)
{
	#region GLOBAL
	if (_host == undefined || _host == global.statuses){
		var _list = global.statuses;
		var _count = ds_list_size(_list);

		if (_count <= 0) exit;

		var _cx = room_width * 0.5;
		var _cy = 50;

		var _cols = 6;
		var _x_spacing = 24;
		var _y_spacing = 24;

		for (var i = 0; i < _count; i++)
		{
		    var _row = i div _cols;
		    var _col = i mod _cols;

		    var _row_count = min(
		        _cols,
		        _count - (_row * _cols)
		    );

		    var _start_x =
		        _cx - ((_row_count - 1) * _x_spacing * 0.5);

		    var _s = ds_list_find_value(_list, i);

		    if (instance_exists(_s))
		    {
		        _s.x = _start_x + (_col * _x_spacing);
		        _s.y = _cy + (_row * _y_spacing);
		    }
		}

		exit;
		}
	#endregion
    
	#region REGULAR
	var _list = _host._statuses;

	if (_host._cur_hp <= 0) exit;

	var _count = ds_list_size(_list);

	if (_count <= 0) exit;

	var _cx = _host.x;
	var _cy = _host.y - 100;

	var _cols = 4;
	var _x_spacing = 24;
	var _y_spacing = 24;

	//------------------------------------------------------------
	// Total rows
	//------------------------------------------------------------
	var _rows = ceil(_count / _cols);

	//------------------------------------------------------------
	// Position statuses
	//------------------------------------------------------------
	for (var i = 0; i < _count; i++)
	{
	    var _row = i div _cols;
	    var _col = i mod _cols;

	    var _row_count = min(
	        _cols,
	        _count - (_row * _cols)
	    );

	    // center this row independently
	    var _start_x =
	        _cx - ((_row_count - 1) * _x_spacing * 0.5);

	    var _s = ds_list_find_value(_list, i);

	    if (instance_exists(_s))
	    {
	        _s.x = _start_x + (_col * _x_spacing);

	        // grow upward from host
	        _s.y =
	            _cy
	            - ((_rows - 1 - _row) * _y_spacing);
	    }
	}
	#endregion
}