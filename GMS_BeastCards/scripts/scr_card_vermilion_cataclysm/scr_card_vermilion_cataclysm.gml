//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_CATACLYSM
// FUNCTION: Deals 8% MAG damage to every Beast on the selected team.
//           Snapshots Burn after all primary hits.
//           Resolves eligible ERUPTIONS in ascending order.
//
//           ERUPTION 3 resolves immediately.
//           Each subsequent eligible ERUPTION resolves 10 frames later.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_cataclysm(_stct_card,_ref_caster,_ref_target){

	#region VALIDATION

	//================//
	//VALIDATE CAST//
	//================//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	//===================//
	//GET SELECTED TEAM//
	//===================//
	var _list_targets = scr_battle_get_target_team_list(_ref_target);

	if (
		_list_targets == undefined ||
		!ds_exists(_list_targets,ds_type_list)
	){
		return;
	}

	#endregion

	#region KILL CASTER
	
	_ref_caster._val_cur_hp = 0;
		
	#endregion
	
	#region TARGET SNAPSHOT

	//================//
	//SNAPSHOT TEAM//
	//================//
	var _arr_targets = [];

	for (var _it_target = 0;_it_target < ds_list_size(_list_targets);_it_target++){

		var _ref_beast = ds_list_find_value(
			_list_targets,
			_it_target
		);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (
			_ref_beast._str_list != "ALIVE" ||
			_ref_beast._val_cur_hp <= 0
		){
			continue;
		}

		array_push(_arr_targets,_ref_beast);
	}

	//================//
	//STORE CONTEXT//
	//================//
	var _ref_card = global.ref_cast_card;

	#endregion

	#region PRIMARY DAMAGE

	//=======================//
	//DAMAGE ENTIRE TEAM//
	//=======================//
	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_beast = _arr_targets[_it_target];

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (
			_ref_beast._str_list != "ALIVE" ||
			_ref_beast._val_cur_hp <= 0
		){
			continue;
		}


		//======================//
		//DEAL 8% MAX HP MAG//
		//======================//
		scr_battle_damage_target(
			"PERCENT",
			_ref_caster,
			_ref_beast,
			_stct_card._val_card_magnitude,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);
	}


	#endregion

	#region ERUPTION SETUP

	//========================//
	//SNAPSHOT BURN THRESHOLDS//
	//========================//
	var _arr_eruption_targets = [];
	var _ct_highest_burn = 0;

	for (var _it_target = 0;_it_target < array_length(_arr_targets);_it_target++){

		var _ref_beast = _arr_targets[_it_target];

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (
			_ref_beast._str_list != "ALIVE" ||
			_ref_beast._val_cur_hp <= 0
		){
			continue;
		}

		var _ct_burn = 0;

		var _ref_burn = scr_status_check(
			"BURN",
			_ref_beast
		);

		if (
			_ref_burn != -1 &&
			instance_exists(_ref_burn)
		){
			_ct_burn = _ref_burn._ct_status_stacks;
		}

		_ct_highest_burn = max(
			_ct_highest_burn,
			_ct_burn
		);

		array_push(
			_arr_eruption_targets,
			{
				_ref_beast : _ref_beast,
				_ct_burn : _ct_burn
			}
		);
	}

	//================//
	//NO ERUPTIONS//
	//================//
	if (_ct_highest_burn < scr_battle_get_eruption_threshold(3)){
		return;
	}

	//=======================//
	//BUILD ERUPTION STAGES//
	//=======================//
	var _arr_stages = [];

	if (_ct_highest_burn >= scr_battle_get_eruption_threshold(3)){
		array_push(_arr_stages,3);
	}

	if (_ct_highest_burn >= scr_battle_get_eruption_threshold(5)){
		array_push(_arr_stages,5);
	}

	if (_ct_highest_burn >= scr_battle_get_eruption_threshold(8)){
		array_push(_arr_stages,8);
	}

	if (_ct_highest_burn >= scr_battle_get_eruption_threshold(10)){
		array_push(_arr_stages,10);
	}

	//=====================//
	//CREATE CAST CONTEXT//
	//=====================//
	var _stct_sequence = {
		_ref_card : _ref_card,
		_ref_caster : _ref_caster,
		_stct_card : _stct_card,
		_arr_targets : _arr_eruption_targets,
		_arr_stages : _arr_stages,
		_it_stage : 0
	};

	#endregion

	#region FIRST ERUPTION

	//======================//
	//RESOLVE FIRST STAGE//
	//======================//
	var _flag_more_stages = scr_card_vermilion_cataclysm_resolve_stage(
		_stct_sequence
	);

	if (!_flag_more_stages){
		return;
	}

	#endregion

	#region TIMED ERUPTIONS

	//========================//
	//CREATE SEQUENCE WAIT//
	//========================//
	var _ref_wait = instance_create_layer(
		room_width * 0.5,
		room_height * 0.5,
		"ily_fx",
		obj_battle_wait
	);

	//================//
	//SET WAIT DATA//
	//================//
	_ref_wait._ct_life = 10;

	_ref_wait._stct_cataclysm = _stct_sequence;

	_ref_wait._scr_on_complete =
		scr_card_vermilion_cataclysm_wait_step;

	#endregion
}
