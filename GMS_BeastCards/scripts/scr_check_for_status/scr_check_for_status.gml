function scr_check_for_status(_id,_ref){
	var _list;
	if (_ref == global.statuses){
		_list = global.statuses;
	} else {
		_list = _ref._statuses;
	}
	for (var i = 0; i < ds_list_size(_list); i++)
	{
		var _status = ds_list_find_value(_list, i);

		if (instance_exists(_status) && _status._status_name == _id)
		{
			return _status;
		}
	}
	return -1;
}