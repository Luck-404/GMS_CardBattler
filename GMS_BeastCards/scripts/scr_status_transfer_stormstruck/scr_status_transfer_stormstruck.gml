//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRANSFER_STORMSTRUCK
// FUNCTION: Moves all Stormstruck stacks from one living Beast to another.
//           The resulting Status preserves the greatest CURRENT remaining
//           lifetime and greatest stored maximum lifetime independently.
//           Transfer is not a new Stormstruck application and does not itself
//           trigger DISCHARGE; the caller triggers DISCHARGE after all transfers.
//
// ARGUMENTS: _ref_source - Beast losing all Stormstruck stacks.
//            _ref_target - Beast receiving those Stormstruck stacks.
// RETURNS: Number of Stormstruck stacks successfully moved.
//
//===============================================================================//
function scr_status_transfer_stormstruck(_ref_source,_ref_target){

	//================//
	//VALIDATE BEASTS//
	//================//
	if (!instance_exists(_ref_source) || !instance_exists(_ref_target)){
		return 0;
	}

	if (_ref_source == _ref_target){
		return 0;
	}

	if (
		_ref_source._str_list != "ALIVE" ||
		_ref_source._val_cur_hp <= 0 ||
		_ref_target._str_list != "ALIVE" ||
		_ref_target._val_cur_hp <= 0
	){
		return 0;
	}

	if (
		!ds_exists(_ref_source._list_statuses,ds_type_list) ||
		!ds_exists(_ref_target._list_statuses,ds_type_list)
	){
		return 0;
	}

	//===================//
	//GET SOURCE STATUS//
	//===================//
	var _ref_source_stormstruck = scr_status_check("STORMSTRUCK",_ref_source);

	if (
		_ref_source_stormstruck == -1 ||
		!instance_exists(_ref_source_stormstruck)
	){
		return 0;
	}

	var _ct_stacks_moved = max(
		0,
		floor(_ref_source_stormstruck._ct_status_stacks)
	);

	if (_ct_stacks_moved <= 0){
		return 0;
	}

	//=========================//
	//SNAPSHOT SOURCE LIFETIME//
	//=========================//
	var _val_source_lifetime =
		_ref_source_stormstruck._val_status_lifetime;

	var _val_source_lifetime_max =
		_val_source_lifetime;

	if (
		!is_real(_val_source_lifetime) ||
		_val_source_lifetime <= 0
	){
		return 0;
	}

	if (
		variable_instance_exists(
			_ref_source_stormstruck,
			"_val_status_lifetime_max"
		) &&
		is_real(_ref_source_stormstruck._val_status_lifetime_max)
	){
		_val_source_lifetime_max = max(
			_val_source_lifetime,
			_ref_source_stormstruck._val_status_lifetime_max
		);
	}

	//===================//
	//GET TARGET STATUS//
	//===================//
	var _ref_target_stormstruck =
		scr_status_check("STORMSTRUCK",_ref_target);

	var _val_target_lifetime = 0;
	var _val_target_lifetime_max = 0;

	if (
		_ref_target_stormstruck != -1 &&
		instance_exists(_ref_target_stormstruck)
	){

		if (
			is_real(
				_ref_target_stormstruck._val_status_lifetime
			)
		){
			_val_target_lifetime = max(
				0,
				_ref_target_stormstruck._val_status_lifetime
			);

			_val_target_lifetime_max =
				_val_target_lifetime;
		}

		if (
			variable_instance_exists(
				_ref_target_stormstruck,
				"_val_status_lifetime_max"
			) &&
			is_real(
				_ref_target_stormstruck._val_status_lifetime_max
			)
		){
			_val_target_lifetime_max = max(
				_val_target_lifetime,
				_ref_target_stormstruck._val_status_lifetime_max
			);
		}
	}

	//===================//
	//COMBINE LIFETIMES//
	//===================//
	var _val_preserved_lifetime = max(
		_val_source_lifetime,
		_val_target_lifetime
	);

	var _val_preserved_lifetime_max = max(
		_val_source_lifetime_max,
		_val_target_lifetime_max
	);

	//======================//
	//CREATE TARGET STATUS//
	//======================//
	if (
		_ref_target_stormstruck == -1 ||
		!instance_exists(_ref_target_stormstruck)
	){
		_ref_target_stormstruck =
			scr_status_dot_stormstruck(
				"APPLY",
				undefined,
				_val_preserved_lifetime_max,
				_ref_target
			);

		if (!instance_exists(_ref_target_stormstruck)){
			return 0;
		}

		_ref_target_stormstruck._ct_status_stacks =
			_ct_stacks_moved;
	}

	//=======================//
	//STACK EXISTING TARGET//
	//=======================//
	else{
		_ref_target_stormstruck._ct_status_stacks +=
			_ct_stacks_moved;
	}

	//===================//
	//PRESERVE LIFETIME//
	//===================//
	_ref_target_stormstruck._val_status_lifetime =
		_val_preserved_lifetime;

	_ref_target_stormstruck._val_status_lifetime_max =
		_val_preserved_lifetime_max;

	//====================//
	//REMOVE SOURCE STATUS//
	//====================//
	scr_status_dot_stormstruck(
		"DEATH",
		_ref_source_stormstruck
	);

	scr_status_reposition(_ref_target);

	return _ct_stacks_moved;
}