//===============================================================================//
//
// SCRIPT: SCR_TRANSFER_OLDEST_BUFF
// FUNCTION: Transfers the oldest Buff from one Beast to another.
//           Preserves the existing status instance, stacks, and lifetime.
//           Rebinds host-dependent bonuses to the new Beast.
//           Source-Min​​ion Buffs cannot be transferred.
//
//===============================================================================//

function scr_transfer_oldest_buff(_ref_source,_ref_target){

	//----------------//
	//VALIDATE BEASTS//
	//----------------//
	if (!instance_exists(_ref_source)){
		return false;
	}

	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_ref_source == _ref_target){
		return false;
	}

	if (
		_ref_source._str_list != "ALIVE" ||
		_ref_source._val_cur_hp <= 0
	){
		return false;
	}

	if (
		_ref_target._str_list != "ALIVE" ||
		_ref_target._val_cur_hp <= 0
	){
		return false;
	}

	//==================//
	//GET OLDEST BUFF//
	//==================//
	var _ref_buff = undefined;

	for (
		var _it_status = 0;
		_it_status < ds_list_size(_ref_source._list_statuses);
		_it_status++
	){

		var _ref_status =
			ds_list_find_value(
				_ref_source._list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "BUFF"){
			continue;
		}

		_ref_buff =
			_ref_status;

		break;
	}

	//---------------//
	//NO BUFF FOUND//
	//---------------//
	if (!instance_exists(_ref_buff)){

		scr_spawn_popup_scrolling(
			"TEXT",
			"NO BUFF",
			undefined,
			c_aqua,
			_ref_source.x,
			_ref_source.y - 48
		);

		return false;
	}

	//===================//
	//SOURCE-BOUND BUFF//
	//===================//
	/*
		Anchor Stone, Blooming Sprite, and future Minion-sourced
		Buffs cannot be separated from their source Minion.
	*/
	if (instance_exists(_ref_buff._ref_source_minion)){

		scr_spawn_popup_scrolling(
			"TEXT",
			"BUFF IS SOURCE-BOUND",
			undefined,
			c_aqua,
			_ref_source.x,
			_ref_source.y - 48
		);

		return false;
	}

	var _str_buff_name =
		_ref_buff._str_status_name;

	//========================//
	//CHECK TARGET DUPLICATE//
	//========================//
	/*
		Do not create duplicate instances of one Buff ID.

		Many existing helpers use scr_check_for_status() and assume
		one status instance per Buff name.
	*/
	var _ref_existing_buff =
		scr_check_for_status(
			_str_buff_name,
			_ref_target
		);

	if (_ref_existing_buff != -1){

		scr_spawn_popup_scrolling(
			"TEXT",
			"BUFF ALREADY ACTIVE",
			undefined,
			c_aqua,
			_ref_target.x,
			_ref_target.y - 48
		);

		return false;
	}

	//============================//
	//REMOVE OLD HOST CONTRIBUTION//
	//============================//
	scr_transfer_buff_host_effects(
		"REMOVE",
		_ref_buff,
		_ref_source,
		_ref_target
	);

	//========================//
	//REMOVE FROM SOURCE LIST//
	//========================//
	var _it_source_status =
		ds_list_find_index(
			_ref_source._list_statuses,
			_ref_buff
		);

	if (_it_source_status == -1){
		return false;
	}

	ds_list_delete(
		_ref_source._list_statuses,
		_it_source_status
	);

	//================//
	//CHANGE HOST//
	//================//
	_ref_buff._ref_host =
		_ref_target;

	_ref_buff._str_status_command =
		"WAIT";

	//------------------//
	//MOVE PERSISTENT VFX//
	//------------------//
	if (instance_exists(_ref_buff._ref_persistent_vfx)){

		_ref_buff._ref_persistent_vfx._ref_anchor =
			_ref_target;
	}

	//=====================//
	//REGISTER WITH TARGET//
	//=====================//
	ds_list_add(
		_ref_target._list_statuses,
		_ref_buff
	);

	//==========================//
	//APPLY NEW HOST CONTRIBUTION//
	//==========================//
	scr_transfer_buff_host_effects(
		"APPLY",
		_ref_buff,
		_ref_source,
		_ref_target
	);

	//-------------------//
	//REFRESH STATUS ICONS//
	//-------------------//
	scr_reposition_statuses(_ref_source);
	scr_reposition_statuses(_ref_target);

	//----------//
	//FEEDBACK//
	//----------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"TRANSFERRED " +
			string(_ref_buff._ct_status_stacks) +
			" " +
			_str_buff_name,
		undefined,
		c_aqua,
		_ref_target.x,
		_ref_target.y - 48
	);

	return true;
}