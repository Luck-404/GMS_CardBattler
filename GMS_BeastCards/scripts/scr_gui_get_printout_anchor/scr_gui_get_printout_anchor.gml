//===============================================================================//
//
// SCRIPT: SCR_GUI_GET_PRINTOUT_ANCHOR
// FUNCTION: Resolves the display anchor associated with an ordinary printout
//           using the popup coordinates already supplied by callers.
//
//           Battle popup coordinates resolve to the nearest Beast or Minion.
//           Overworld popup coordinates resolve to the player when available.
//
// ARGUMENTS: _val_x - Original popup x coordinate.
//            _val_y - Original popup y coordinate.
// RETURNS: Anchor instance, or undefined when no suitable anchor exists.
//
//===============================================================================//

function scr_gui_get_printout_anchor(_val_x,_val_y){

	#region BATTLE

	//================//
	//BATTLE ANCHORS//
	//================//
	if (room == rm_battle){

		var _ref_beast = instance_nearest(_val_x,_val_y,obj_battle_beast);
		var _ref_minion = instance_nearest(_val_x,_val_y,obj_battle_minion);

		var _val_beast_distance = 999999;
		var _val_minion_distance = 999999;

		if (instance_exists(_ref_beast)){
			_val_beast_distance = point_distance(
				_val_x,
				_val_y,
				_ref_beast.x,
				_ref_beast.y
			);
		}

		if (instance_exists(_ref_minion)){
			_val_minion_distance = point_distance(
				_val_x,
				_val_y,
				_ref_minion.x,
				_ref_minion.y
			);
		}

		var _val_anchor_range = 72;

		if (
			_val_beast_distance <= _val_minion_distance &&
			_val_beast_distance <= _val_anchor_range
		){
			return _ref_beast;
		}

		if (
			_val_minion_distance < _val_beast_distance &&
			_val_minion_distance <= _val_anchor_range
		){
			return _ref_minion;
		}

		return undefined;
	}

	#endregion

	#region OVERWORLD

	//==================//
	//OVERWORLD ANCHOR//
	//==================//
	if (instance_exists(obj_player)){
		return obj_player;
	}

	#endregion

	return undefined;
}