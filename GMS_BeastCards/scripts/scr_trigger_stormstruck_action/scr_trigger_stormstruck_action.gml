//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_STORMSTRUCK_ACTION
// FUNCTION: Triggers Stormstruck when a Beast successfully performs an action.
//           Deals 2 neutral damage per current stack.
//           Removes 1 Stormstruck stack.
//           Refreshes the remaining status lifetime to 3 rounds.
//
//===============================================================================//

function scr_trigger_stormstruck_action(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (_ref_beast._val_cur_hp <= 0){
		return false;
	}

	//-------------------//
	//CHECK STORMSTRUCK//
	//-------------------//
	var _ref_stormstruck = scr_check_for_status(
		"STORMSTRUCK",
		_ref_beast
	);

	if (_ref_stormstruck == -1){
		return false;
	}

	//----------------//
	//GET STACK COUNT//
	//----------------//
	var _ct_stacks =
		_ref_stormstruck._ct_status_stacks;

	if (_ct_stacks <= 0){
		return false;
	}

	//----------------//
	//DAMAGE AMOUNT//
	//----------------//
	var _val_damage =
		_ct_stacks *
		_ref_stormstruck._val_status_magnitude;

	//----------------//
	//DAMAGE OVERHEALTH//
	//----------------//
	if (
		_val_damage > 0 &&
		_ref_beast._val_overhealth > 0
	){

		var _val_overhealth_damage = min(
			_ref_beast._val_overhealth,
			_val_damage
		);

		_ref_beast._val_overhealth -=
			_val_overhealth_damage;

		_val_damage -=
			_val_overhealth_damage;

		scr_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_overhealth_damage),
			undefined,
			c_green,
			_ref_beast.x + irandom_range(-32,32),
			_ref_beast.y - 24 + irandom_range(-32,32)
		);
	}

	//----------//
	//DAMAGE HP//
	//----------//
	if (_val_damage > 0){

		var _val_hp_damage = min(
			_val_damage,
			_ref_beast._val_cur_hp
		);

		_ref_beast._val_cur_hp = max(
			0,
			_ref_beast._val_cur_hp -
			_val_hp_damage
		);

		scr_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_hp_damage),
			undefined,
			c_maroon,
			_ref_beast.x + irandom_range(-32,32),
			_ref_beast.y - 24 + irandom_range(-32,32)
		);
	}

	scr_battle_vfx(
		_ref_beast,
		spr_battle_vfx_stormstruck_tick,
		undefined,
		undefined,
		32,
		32,
		1,
		0,
		snd_battle_sfx_stormstruck
	);

	//----------------//
	//REMOVE 1 STACK//
	//----------------//
	if (instance_exists(_ref_stormstruck)){

		_ref_stormstruck._ct_status_stacks--;

		if (_ref_stormstruck._ct_status_stacks <= 0){

			scr_status_dot_stormstruck(
				"DEATH",
				_ref_stormstruck
			);
		}
		else{

			//----------------//
			//REFRESH LIFETIME//
			//----------------//
			scr_status_refresh_lifetime(
				_ref_stormstruck,
				3
			);

			scr_reposition_statuses(_ref_beast);
		}
	}

	return true;
}