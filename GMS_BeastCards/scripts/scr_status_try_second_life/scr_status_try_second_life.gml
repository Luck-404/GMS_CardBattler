//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRY_SECOND_LIFE
// FUNCTION: Checks whether a defeated Beast has an active death-prevention
//           effect.
//
//           Priority:
//           1. Phoenix Ember Held Item
//           2. Last Stand
//           3. Phoenix Rebirth
//           4. Second Life
//
//           Phoenix Ember is checked before all Status-based resurrection
//           effects. When it succeeds, the item is consumed from both the
//           battle Beast and its persistent Beast struct.
//
// ARGUMENTS: _ref_beast - Battle Beast whose HP reached 0.
// RETURNS: True when normal death handling should be cancelled.
//
//===============================================================================//

function scr_status_try_second_life(_ref_beast){

	#region VALIDATION

	if (!instance_exists(_ref_beast)){
		return false;
	}

	#endregion

	#region PHOENIX EMBER

	if (
		variable_instance_exists(
			_ref_beast,
			"_stct_held_item"
		)
	){

		var _stct_phoenix_item =
			_ref_beast
				._stct_held_item;

		if (
			is_struct(_stct_phoenix_item) &&
			variable_struct_exists(
				_stct_phoenix_item,
				"_str_item_id"
			) &&
			string_upper(
				string(
					_stct_phoenix_item
						._str_item_id
				)
			) ==
			"HELD_PHOENIX_EMBER" &&
			variable_struct_exists(
				_stct_phoenix_item,
				"_scr_item"
			) &&
			_stct_phoenix_item._scr_item !=
				undefined
		){

			var _flag_phoenix_ember =
				script_execute(
					_stct_phoenix_item
						._scr_item,
					"TRIGGER",
					_stct_phoenix_item,
					_ref_beast
				);

			if (_flag_phoenix_ember){

				//=======================//
				//CONSUME PERSISTENT ITEM//
				//=======================//
				if (
					variable_instance_exists(
						_ref_beast,
						"_ref_unit"
					) &&
					is_struct(
						_ref_beast._ref_unit
					)
				){

					_ref_beast
						._ref_unit
						._stct_beast_held_item =
						"EMPTY";
				}

				//===================//
				//CONSUME BATTLE ITEM//
				//===================//
				_ref_beast._stct_held_item =
					"EMPTY";

				return true;
			}
		}
	}

	#endregion

	#region LAST STAND

	var _ref_last_stand =
		scr_status_check(
			"LAST_STAND",
			_ref_beast
		);

	if (
		_ref_last_stand != -1 &&
		instance_exists(
			_ref_last_stand
		)
	){

		return scr_status_buff_last_stand(
			"TRIGGER",
			_ref_last_stand
		);
	}

	#endregion

	#region PHOENIX REBIRTH

	var _ref_phoenix_rebirth =
		scr_status_check(
			"PHOENIX_REBIRTH",
			_ref_beast
		);

	if (
		_ref_phoenix_rebirth != -1 &&
		instance_exists(
			_ref_phoenix_rebirth
		)
	){

		return scr_status_buff_phoenix_rebirth(
			"TRIGGER",
			_ref_phoenix_rebirth
		);
	}

	#endregion

	#region SECOND LIFE

	var _ref_second_life =
		scr_status_check(
			"SECOND_LIFE",
			_ref_beast
		);

	if (
		_ref_second_life == -1 ||
		!instance_exists(
			_ref_second_life
		)
	){
		return false;
	}

	return scr_status_buff_second_life(
		"TRIGGER",
		_ref_second_life,
		undefined
	);

	#endregion
}
