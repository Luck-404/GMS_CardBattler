//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_REWARD_NOTIFY
// FUNCTION: Displays a World Event pickup notification immediately when already
//           in stable overworld gameplay, or queues it on the persistent World
//           Event controller when rewards resolve inside rm_battle / transitions.
//
//           Reward ownership is NOT deferred. This helper controls presentation
//           only, so the underlying premium reward remains exactly-once.
//
// ARGUMENTS: _str_reward_type - GOLD, CARD, ITEM, or EGG.
//            _str_reward_id   - Reward id; undefined for Gold.
//            _ct_amount       - Awarded amount.
// RETURNS: True when displayed or queued.
//
//===============================================================================//

function scr_world_event_reward_notify(_str_reward_type,_str_reward_id,_ct_amount=1){

	_ct_amount =
		max(
			1,
			floor(_ct_amount)
		);

	_str_reward_type =
		string_upper(
			string(_str_reward_type)
		);

	var _ref_controller =
		scr_world_event_get_controller();

	var _flag_stable_overworld =
		room != rm_battle &&
		!instance_exists(obj_transition) &&
		!instance_exists(obj_transition_fader);

	if (_flag_stable_overworld){

		scr_gui_spawn_treasure_reward(
			_str_reward_type,
			_str_reward_id,
			_ct_amount
		);

		return true;
	}

	if (!instance_exists(_ref_controller)){
		return false;
	}

	if (
		!variable_instance_exists(
			_ref_controller,
			"_arr_pending_reward_popups"
		) ||
		!is_array(
			_ref_controller._arr_pending_reward_popups
		)
	){
		_ref_controller._arr_pending_reward_popups = [];
	}

	array_push(
		_ref_controller._arr_pending_reward_popups,
		{
			_str_reward_type : _str_reward_type,
			_str_reward_id : _str_reward_id,
			_ct_amount : _ct_amount
		}
	);

	scr_debug_log(
		"WORLD_EVENT",
		"REWARD",
		_ref_controller,
		"WORLD EVENT REWARD PICKUP QUEUED" +
		" | TYPE: " +
		_str_reward_type +
		" | ID: " +
		(
			_str_reward_id == undefined
			? "UNDEFINED"
			: string_upper(string(_str_reward_id))
		) +
		" | AMOUNT: " +
		string(_ct_amount) +
		" | ROOM: " +
		string_upper(room_get_name(room)),
		"INFO",
		"SCR_WORLD_EVENT_REWARD_NOTIFY"
	);

	return true;
}
