//===============================================================================//
//
// SCRIPT: SCR_GUI_SPAWN_PRINTOUT
// FUNCTION: Routes ordinary temporary popup feedback through the active
//           printout presentation mode.
//
//           The original popup family is always preserved:
//
//           SCR_GUI_SPAWN_POPUP
//               -> OBJ_GUI_POPUP
//
//           SCR_GUI_SPAWN_POPUP_SCROLLING
//               -> OBJ_GUI_POPUP_SCROLLING
//
//           RANDOM/CLEAN controls placement only.
//           STACKING controls repeated-entry aggregation only.
//
//           CLEAN entries use permanent upward displacement. New entries push
//           older entries upward once; expired entries never cause surviving
//           entries to shift back downward.
//
// ARGUMENTS: _flag_scroll_random - TRUE when the original caller requested a
//                                  scrolling popup.
//            _str_type - TEXT, ICON, or DUAL.
//            _str_text - Popup text.
//            _spr_icon - Optional popup icon.
//            _c_popup - Popup display color.
//            _val_x - Original popup x coordinate.
//            _val_y - Original popup y coordinate.
// RETURNS: Created or stacked popup instance.
//
//===============================================================================//

function scr_gui_spawn_printout(_flag_scroll_random,_str_type,_str_text,_spr_icon,_c_popup,_val_x,_val_y){

	#region MODE

	//================//
	//ENSURE SETTINGS//
	//================//
	if (!variable_global_exists("str_printout_mode")){
		global.str_printout_mode = "CLEAN";
	}

	if (!variable_global_exists("val_printout_serial")){
		global.val_printout_serial = 0;
	}

	//================//
	//RESOLVE MODE//
	//================//
	var _flag_clean = false;
	var _flag_stacking = false;

	switch (global.str_printout_mode){

		case "RANDOM":

			_flag_clean = false;
			_flag_stacking = false;

		break;

		case "CLEAN":

			_flag_clean = true;
			_flag_stacking = false;

		break;

		case "RANDOM STACKING":

			_flag_clean = false;
			_flag_stacking = true;

		break;

		case "CLEAN STACKING":

			_flag_clean = true;
			_flag_stacking = true;

		break;

		default:

			global.str_printout_mode = "CLEAN";

			_flag_clean = true;
			_flag_stacking = false;

			scr_debug_log(
				"GUI",
				"PRINTOUT",
				undefined,
				"INVALID PRINTOUT MODE RESET TO CLEAN",
				"WARNING",
				"SCR_GUI_SPAWN_PRINTOUT"
			);

		break;
	}

	#endregion

	#region POPUP FAMILY

	//================//
	//PRESERVE FAMILY//
	//================//
	var _obj_popup = obj_gui_popup;

	if (_flag_scroll_random){
		_obj_popup = obj_gui_popup_scrolling;
	}

	#endregion

	#region PRINT DATA

	//================//
	//RESOLVE ANCHOR//
	//================//
	var _ref_anchor = scr_gui_get_printout_anchor(
		_val_x,
		_val_y
	);

	//================//
	//GROUP KEY//
	//================//
	var _str_group_key = "";

	if (instance_exists(_ref_anchor)){

		_str_group_key =
			"INSTANCE:" +
			string(_ref_anchor);
	}
	else{

		_str_group_key =
			"POSITION:" +
			string(round(_val_x)) +
			":" +
			string(round(_val_y));
	}

	//================//
	//EVENT KEY//
	//================//
	var _str_event_key =
		string_upper(string(_str_type)) + "|" +
		string(_str_text) + "|" +
		string(_spr_icon) + "|" +
		string(_c_popup);

	#endregion

	#region STACK EXISTING

	if (_flag_stacking){

		var _ct_existing =
			instance_number(_obj_popup);

		for (
			var _it_popup = 0;
			_it_popup < _ct_existing;
			_it_popup++
		){

			var _ref_existing = instance_find(
				_obj_popup,
				_it_popup
			);

			if (!instance_exists(_ref_existing)){
				continue;
			}

			if (!variable_instance_exists(_ref_existing,"_flag_printout")){
				continue;
			}

			if (!_ref_existing._flag_printout){
				continue;
			}

			if (!_ref_existing._flag_printout_stacking){
				continue;
			}

			if (_ref_existing._flag_clean_printout != _flag_clean){
				continue;
			}

			if (_ref_existing._str_printout_group_key != _str_group_key){
				continue;
			}

			if (_ref_existing._str_printout_event_key != _str_event_key){
				continue;
			}

			//================//
			//STACK ENTRY//
			//================//
			_ref_existing._ct_printout_stack++;

			_ref_existing._ct_life =
				_ref_existing._ct_printout_life_max;

			global.val_printout_serial++;

			_ref_existing._val_printout_order =
				global.val_printout_serial;

			//======================//
			//CLEAN STACK POSITION//
			//======================//
			if (_flag_clean){

				//-------------------------//
				//PUSH OTHER ENTRIES UPWARD//
				//-------------------------//
				var _ct_clean_existing =
					instance_number(_obj_popup);

				for (
					var _it_clean = 0;
					_it_clean < _ct_clean_existing;
					_it_clean++
				){

					var _ref_clean = instance_find(
						_obj_popup,
						_it_clean
					);

					if (!instance_exists(_ref_clean)){
						continue;
					}

					if (_ref_clean == _ref_existing){
						continue;
					}

					if (!variable_instance_exists(_ref_clean,"_flag_clean_printout")){
						continue;
					}

					if (!_ref_clean._flag_clean_printout){
						continue;
					}

					if (_ref_clean._str_printout_group_key != _str_group_key){
						continue;
					}

					_ref_clean._val_printout_push_offset +=
						_ref_clean._val_printout_spacing;
				}

				//----------------------//
				//RETURN STACK TO BOTTOM//
				//----------------------//
				_ref_existing._val_printout_push_offset = 0;

				if (
					variable_instance_exists(
						_ref_existing,
						"_val_printout_scroll_offset"
					)
				){
					_ref_existing._val_printout_scroll_offset = 0;
				}

				_ref_existing._val_printout_anchor_x = _val_x;
				_ref_existing._val_printout_anchor_y = _val_y;

				_ref_existing._ref_printout_anchor =
					_ref_anchor;
			}

			//=======================//
			//RANDOM STACK POSITION//
			//=======================//
			else{

				_ref_existing.x = _val_x;
				_ref_existing.y = _val_y;
			}

			//================//
			//DEBUG STACK//
			//================//
			scr_debug_log(
				"GUI",
				"PRINTOUT",
				_ref_anchor,
				"PRINTOUT STACKED" +
					" | MODE: " + global.str_printout_mode +
					" | TEXT: " + string_upper(string(_str_text)) +
					" | STACKS: " + string(_ref_existing._ct_printout_stack) +
					" | FAMILY: " +
					(_flag_scroll_random ? "SCROLLING" : "STANDARD"),
				"INFO",
				"SCR_GUI_SPAWN_PRINTOUT"
			);

			return _ref_existing;
		}
	}

	#endregion

	#region PUSH CLEAN ENTRIES

	//========================//
	//MAKE ROOM FOR NEW ENTRY//
	//========================//
	if (_flag_clean){

		var _ct_clean_existing =
			instance_number(_obj_popup);

		for (
			var _it_clean = 0;
			_it_clean < _ct_clean_existing;
			_it_clean++
		){

			var _ref_clean = instance_find(
				_obj_popup,
				_it_clean
			);

			if (!instance_exists(_ref_clean)){
				continue;
			}

			if (!variable_instance_exists(_ref_clean,"_flag_clean_printout")){
				continue;
			}

			if (!_ref_clean._flag_clean_printout){
				continue;
			}

			if (_ref_clean._str_printout_group_key != _str_group_key){
				continue;
			}

			_ref_clean._val_printout_push_offset +=
				_ref_clean._val_printout_spacing;
		}
	}

	#endregion

	#region CREATE POPUP

	//================//
	//CREATE POPUP//
	//================//
	var _ref_popup = instance_create_layer(
		_val_x,
		_val_y,
		"ily_fx",
		_obj_popup
	);

	//================//
	//BASE DATA//
	//================//
	_ref_popup._str_type = _str_type;
	_ref_popup._str_text = _str_text;

	_ref_popup._spr_icon = _spr_icon;
	_ref_popup._c_popup = _c_popup;

	//================//
	//PRINTOUT DATA//
	//================//
	_ref_popup._flag_printout = true;

	_ref_popup._flag_clean_printout = _flag_clean;
	_ref_popup._flag_printout_stacking = _flag_stacking;

	_ref_popup._ref_printout_anchor = _ref_anchor;

	_ref_popup._val_printout_anchor_x = _val_x;
	_ref_popup._val_printout_anchor_y = _val_y;

	_ref_popup._str_printout_group_key = _str_group_key;
	_ref_popup._str_printout_event_key = _str_event_key;

	_ref_popup._ct_printout_stack = 1;

	global.val_printout_serial++;

	_ref_popup._val_printout_order =
		global.val_printout_serial;

	//================//
	//CLEAN LIFETIME//
	//================//
	if (_flag_clean){

		_ref_popup._ct_life = 30;
		_ref_popup._ct_printout_life_max = 30;

		_ref_popup._val_printout_push_offset = 0;

		if (
			variable_instance_exists(
				_ref_popup,
				"_val_printout_scroll_offset"
			)
		){
			_ref_popup._val_printout_scroll_offset = 0;
		}
	}

	//================//
	//RANDOM LIFETIME//
	//================//
	else{

		_ref_popup._ct_printout_life_max =
			_ref_popup._ct_life;
	}

	//================//
	//DEBUG CLEAN//
	//================//
	if (_flag_clean){

		scr_debug_log(
			"GUI",
			"PRINTOUT",
			_ref_anchor,
			"CLEAN PRINTOUT QUEUED" +
				" | TEXT: " + string_upper(string(_str_text)) +
				" | FAMILY: " +
				(_flag_scroll_random ? "SCROLLING" : "STANDARD"),
			"INFO",
			"SCR_GUI_SPAWN_PRINTOUT"
		);
	}

	return _ref_popup;

	#endregion
}