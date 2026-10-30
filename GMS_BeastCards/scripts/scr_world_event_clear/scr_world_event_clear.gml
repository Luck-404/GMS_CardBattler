//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_CLEAR
// FUNCTION: Performs final World Event cleanup, including live instances, event-bound GUI/battle state, Merchant Market storage, and persistent active-event reset.
//
//===============================================================================//

function scr_world_event_clear(_flag_log=true){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _uid_world_event = -1;
	var _str_event_id = "";
	var _ct_removed = 0;
	var _flag_market_stock_removed = false;

	if (
		is_struct(
			_ref_controller
				._stct_active_world_event
		)
	){

		_uid_world_event =
			_ref_controller
				._stct_active_world_event
				._uid_world_event;

		_str_event_id =
			_ref_controller
				._stct_active_world_event
				._str_event_id;
	}

	if (_uid_world_event >= 0){

		_ct_removed =
			scr_world_event_cleanup_room_instances(
				_uid_world_event
			);
	}

	//========================//
	//MERCHANT MARKET STORAGE//
	//========================//
	if (
		_str_event_id == "WANDERING_MERCHANT" &&
		is_struct(_ref_controller._stct_active_world_event) &&
		is_struct(_ref_controller._stct_active_world_event._stct_payload) &&
		variable_struct_exists(
			_ref_controller._stct_active_world_event._stct_payload,
			"_uid_wandering_merchant_npc"
		)
	){
		var _str_market_uid =
			"NPC_VENDOR_" +
			string(_ref_controller._stct_active_world_event._stct_payload._uid_wandering_merchant_npc);

		if (
			variable_global_exists("map_market_stock") &&
			ds_exists(global.map_market_stock,ds_type_map) &&
			ds_map_exists(global.map_market_stock,_str_market_uid)
		){
			ds_map_delete(global.map_market_stock,_str_market_uid);
			_flag_market_stock_removed = true;
		}
	}

	//================//
	//BATTLE / GUI STATE//
	//================//
	scr_world_event_clear_battle_context(false);

	_ref_controller._flag_status_banner_pending = false;
	_ref_controller._str_pending_banner_title = "";
	_ref_controller._str_pending_banner_line_1 = "";
	_ref_controller._str_pending_banner_line_2 = "";
	_ref_controller._arr_pending_reward_popups = [];

	with (obj_gui_world_event_banner){
		instance_destroy();
	}

	_ref_controller._stct_active_world_event =
		scr_world_event_create_empty();

	if (_flag_log){

		scr_debug_log(
			"WORLD_EVENT",
			"STATE",
			_ref_controller,
			"WORLD EVENT STATE CLEARED" +
			" | UID: " +
			string(
				_uid_world_event
			) +
			" | EVENT: " +
			string_upper(
				string(
					_str_event_id
				)
			) +
			" | LIVE INSTANCES REMOVED: " + string(_ct_removed) +
			" | MERCHANT MARKET STOCK REMOVED: " + (_flag_market_stock_removed ? "YES" : "NO") +
			" | BATTLE/GUI STATE: CLEARED",
			"INFO",
			"SCR_WORLD_EVENT_CLEAR"
		);
	}

	return true;
}
